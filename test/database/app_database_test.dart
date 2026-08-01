import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/database/app_database.dart';

import 'migration_schema/schema.dart';

void main() {
  late AppDatabase database;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('AppDatabase schema v4', () {
    test('committed snapshots preserve v1/v2/v3 and describe v4', () {
      final v1Snapshot =
          jsonDecode(
                File('drift_schemas/drift_schema_v1.json').readAsStringSync(),
              )
              as Map<String, dynamic>;
      final v2Snapshot =
          jsonDecode(
                File('drift_schemas/drift_schema_v2.json').readAsStringSync(),
              )
              as Map<String, dynamic>;
      final v1Tables = (v1Snapshot['entities'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .where((entity) => entity['type'] == 'table');
      final v2Tables = (v2Snapshot['entities'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .where((entity) => entity['type'] == 'table');
      final v3Snapshot =
          jsonDecode(
                File('drift_schemas/drift_schema_v3.json').readAsStringSync(),
              )
              as Map<String, dynamic>;
      final v3Tables = (v3Snapshot['entities'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .where((entity) => entity['type'] == 'table');
      final v4Snapshot =
          jsonDecode(
                File('drift_schemas/drift_schema_v4.json').readAsStringSync(),
              )
              as Map<String, dynamic>;
      final v4Tables = (v4Snapshot['entities'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .where((entity) => entity['type'] == 'table');
      expect(v1Tables, hasLength(12));
      expect(v2Tables, hasLength(17));
      expect(v3Tables, hasLength(22));
      expect(v4Tables, hasLength(24));
      expect(database.schemaVersion, 4);
    });

    test(
      'creates exactly 24 domain tables with required indices and FK',
      () async {
        final tables = await database
            .customSelect(
              "SELECT name FROM sqlite_master WHERE type = 'table' "
              "AND name NOT LIKE 'sqlite_%' ORDER BY name",
            )
            .get();
        expect(tables.map((row) => row.read<String>('name')).toSet(), {
          'api_key_metadata',
          'api_key_usage_events',
          'app_settings',
          'chat_messages',
          'chat_sessions',
          'daily_targets',
          'favorite_templates',
          'food_items',
          'food_logs',
          'notification_events',
          'reminder_settings',
          'user_profile',
          'financial_categories',
          'financial_periods',
          'financial_transactions',
          'finance_settings',
          'chat_drafts',
          'schedule_categories',
          'schedule_items',
          'schedule_reminders',
          'schedule_notification_occurrences',
          'scheduler_settings',
          'net_worth_initialization',
          'net_worth_adjustments',
        });
        final indices = await database
            .customSelect("SELECT name FROM sqlite_master WHERE type = 'index'")
            .get();
        final names = indices.map((row) => row.read<String>('name')).toSet();
        expect(
          names,
          containsAll({
            'idx_food_logs_local_date_deleted_status',
            'idx_food_logs_consumed_at',
            'idx_food_items_log_sort',
            'idx_food_items_normalized_name',
            'idx_chat_messages_session_created',
            'idx_api_keys_selection',
            'idx_api_usage_key_created',
            'idx_daily_targets_effective',
            'idx_notification_local_date_status',
            'idx_financial_categories_type_active',
            'idx_financial_periods_dates',
            'idx_financial_transactions_period_type_date',
            'idx_financial_transactions_category',
            'idx_financial_transactions_period_reimburse',
            'idx_financial_transactions_date_type_category',
            'idx_net_worth_adjustments_date',
            'idx_chat_drafts_updated',
            'idx_schedule_categories_active',
            'idx_schedule_items_time_status',
            'idx_schedule_items_due_status',
            'idx_schedule_items_category',
            'idx_schedule_reminders_item_enabled',
            'idx_schedule_occurrences_item_time',
            'idx_schedule_occurrences_sync',
          }),
        );
        final foreignKeys = await database
            .customSelect('PRAGMA foreign_keys')
            .getSingle();
        expect(foreignKeys.read<int>('foreign_keys'), 1);
      },
    );

    test('finance and scheduler defaults are idempotent', () async {
      await database.close();
      final temp = await Directory.systemTemp.createTemp('keyspace-seed-test-');
      final file = File('${temp.path}/keyspace.sqlite');
      try {
        final first = AppDatabase(NativeDatabase(file));
        expect(await _count(first, 'finance_settings'), 1);
        expect(await _count(first, 'financial_categories'), 23);
        expect(await _count(first, 'scheduler_settings'), 1);
        expect(await _count(first, 'schedule_categories'), 8);
        await first.close();

        final reopened = AppDatabase(NativeDatabase(file));
        expect(await _count(reopened, 'finance_settings'), 1);
        expect(await _count(reopened, 'financial_categories'), 23);
        expect(await _count(reopened, 'scheduler_settings'), 1);
        expect(await _count(reopened, 'schedule_categories'), 8);
        expect(
          await reopened
              .customSelect(
                "SELECT name FROM financial_categories "
                "WHERE id = 'income-reimbursement'",
              )
              .getSingle()
              .then((row) => row.read<String>('name')),
          'Penggantian Biaya (Reimbursement)',
        );
        await reopened.close();
      } finally {
        await temp.delete(recursive: true);
        database = AppDatabase(NativeDatabase.memory());
      }
    });

    test('migrates v1 to v4 without losing nutrition data', () async {
      final verifier = SchemaVerifier(GeneratedHelper());
      final schema = await verifier.schemaAt(1);
      schema.rawDatabase.execute(
        "INSERT INTO food_logs "
        "(id, local_date, consumed_at_utc, timezone_offset_minutes, meal_type, "
        "source, status, total_calories_kcal, created_at, updated_at) "
        "VALUES ('legacy-log', '2026-07-21', 1, 420, 'lunch', 'manual', "
        "'confirmed', 450, 1, 1)",
      );
      final migrated = AppDatabase(schema.newConnection());
      await verifier.migrateAndValidate(migrated, 4);

      expect(await _count(migrated, 'food_logs'), 1);
      expect(await _count(migrated, 'financial_categories'), 23);
      expect(await _count(migrated, 'finance_settings'), 1);
      expect(await _count(migrated, 'scheduler_settings'), 1);
      expect(await _count(migrated, 'schedule_categories'), 8);
      final columns = await migrated
          .customSelect("SELECT name FROM pragma_table_info('app_settings')")
          .get();
      expect(
        columns.map((row) => row.read<String>('name')),
        contains('voice_disclosure_acknowledged'),
      );

      await migrated.close();
      schema.close();
    });

    test('migrates v2 to v4 without losing finance data', () async {
      final verifier = SchemaVerifier(GeneratedHelper());
      final schema = await verifier.schemaAt(2);
      schema.rawDatabase.execute(
        "INSERT INTO financial_categories "
        "(id, name, type, is_system, is_active, created_at, updated_at) "
        "VALUES ('legacy-category', 'Lama', 'expense', 0, 1, 1, 1)",
      );
      final migrated = AppDatabase(schema.newConnection());
      await verifier.migrateAndValidate(migrated, 4);

      expect(await _count(migrated, 'financial_categories'), 24);
      expect(await _count(migrated, 'schedule_categories'), 8);
      expect(await _count(migrated, 'scheduler_settings'), 1);

      await migrated.close();
      schema.close();
    });

    test('migrates v3 to v4 and backfills reminder type', () async {
      final verifier = SchemaVerifier(GeneratedHelper());
      final schema = await verifier.schemaAt(3);
      schema.rawDatabase.execute(
        "INSERT INTO schedule_categories "
        "(id, name, is_system, is_active, created_at, updated_at) "
        "VALUES ('legacy-schedule-category', 'Lama', 0, 1, 1, 1)",
      );
      schema.rawDatabase.execute(
        "INSERT INTO schedule_items "
        "(id, item_type, title, start_at_utc, end_at_utc, all_day, "
        "category_id, priority, status, timezone, recurrence_type, "
        "recurrence_interval, source, created_at, updated_at) "
        "VALUES ('legacy-schedule', 'event', 'Jadwal lama', 2000000000, "
        "2000003600, 0, 'legacy-schedule-category', 'medium', 'pending', "
        "'Asia/Jakarta', 'none', 1, 'manual', 1, 1)",
      );
      schema.rawDatabase.execute(
        "INSERT INTO schedule_reminders "
        "(id, schedule_item_id, offset_minutes, is_enabled, created_at, updated_at) "
        "VALUES ('legacy-day', 'legacy-schedule', 1440, 1, 1, 1), "
        "('legacy-minutes', 'legacy-schedule', 15, 1, 1, 1)",
      );
      final migrated = AppDatabase(schema.newConnection());
      await verifier.migrateAndValidate(migrated, 4);

      final reminders = await migrated.select(migrated.scheduleReminders).get();
      expect(reminders, hasLength(2));
      expect(reminders.map((row) => row.reminderType).toSet(), {
        'day_before',
        'minutes_before',
      });
      expect(await _count(migrated, 'schedule_items'), 1);

      await migrated.close();
      schema.close();
    });

    test(
      'database schema contains references but no secret value column',
      () async {
        final columns = await database
            .customSelect(
              "SELECT name FROM pragma_table_info('api_key_metadata')",
            )
            .get();
        final names = columns.map((row) => row.read<String>('name')).toSet();
        expect(names, containsAll({'secure_ref', 'masked_suffix'}));
        expect(names, isNot(contains('api_key')));
        expect(names, isNot(contains('secret')));
        expect(names, isNot(contains('key_value')));
      },
    );

    test('singleton constraints reject a second app settings record', () async {
      await expectLater(
        database.customStatement(
          "INSERT INTO app_settings "
          "(id, onboarding_completed, weight_unit, height_unit, theme_mode, "
          "locale, gemini_model, preview_before_save, created_at, updated_at) "
          "VALUES (2, 0, 'kg', 'cm', 'system', 'id', 'model', 1, 1, 1)",
        ),
        throwsA(anything),
      );
    });

    test('cascade and SET NULL preserve audit rows correctly', () async {
      await _insertKey(database, 'key-a');
      await database.customStatement(
        "INSERT INTO app_settings "
        "(id, onboarding_completed, weight_unit, height_unit, theme_mode, "
        "locale, active_key_id, gemini_model, preview_before_save, created_at, updated_at) "
        "VALUES (1, 0, 'kg', 'cm', 'system', 'id', 'key-a', 'model', 1, 1, 1)",
      );
      await _insertLog(database, id: 'log-a', aiKeyId: 'key-a');
      await database.customStatement(
        "INSERT INTO food_items "
        "(id, food_log_id, display_name, calories_kcal, sort_order, created_at, updated_at) "
        "VALUES ('item-a', 'log-a', 'Nasi', 100, 0, 1, 1)",
      );
      await database.customStatement(
        "INSERT INTO chat_sessions (id, local_date, created_at, updated_at) "
        "VALUES ('session-a', '2026-07-21', 1, 1)",
      );
      await database.customStatement(
        "INSERT INTO chat_messages "
        "(id, session_id, role, content_text, status, food_log_id, created_at) "
        "VALUES ('message-a', 'session-a', 'user', 'Nasi', 'complete', 'log-a', 1)",
      );
      await database.customStatement(
        "INSERT INTO api_key_usage_events "
        "(id, api_key_metadata_id, local_request_id, operation, outcome, created_at) "
        "VALUES ('usage-a', 'key-a', 'request-a', 'parse', 'success', 1)",
      );

      await database.customStatement(
        "DELETE FROM api_key_metadata WHERE id = 'key-a'",
      );
      final settings = await database
          .customSelect('SELECT active_key_id FROM app_settings WHERE id = 1')
          .getSingle();
      final log = await database
          .customSelect(
            "SELECT ai_key_metadata_id FROM food_logs WHERE id = 'log-a'",
          )
          .getSingle();
      expect(settings.read<String?>('active_key_id'), isNull);
      expect(log.read<String?>('ai_key_metadata_id'), isNull);
      expect(await _count(database, 'api_key_usage_events'), 0);

      await database.customStatement(
        "DELETE FROM food_logs WHERE id = 'log-a'",
      );
      expect(await _count(database, 'food_items'), 0);
      final message = await database
          .customSelect(
            "SELECT food_log_id FROM chat_messages WHERE id = 'message-a'",
          )
          .getSingle();
      expect(message.read<String?>('food_log_id'), isNull);
    });

    test('daily aggregate excludes draft and soft-deleted logs', () async {
      await _insertLog(database, id: 'confirmed', calories: 500);
      await _insertLog(database, id: 'draft', calories: 300, status: 'draft');
      await _insertLog(database, id: 'deleted', calories: 200, deletedAt: 2);
      await _insertLog(
        database,
        id: 'other-day',
        calories: 900,
        localDate: '2026-07-20',
      );

      final total = await database.dailyNutritionTotal('2026-07-21');

      expect(total.caloriesKcal, 500);
      expect(total.proteinG, 10);
    });

    test('transaction rolls back all writes after a child failure', () async {
      await expectLater(
        database.transaction(() async {
          await _insertLog(database, id: 'atomic-log');
          await database.customStatement(
            "INSERT INTO food_items "
            "(id, food_log_id, display_name, calories_kcal, sort_order, created_at, updated_at) "
            "VALUES ('bad-item', 'missing-parent', 'Invalid', 1, 0, 1, 1)",
          );
        }),
        throwsA(anything),
      );
      expect(await _count(database, 'food_logs'), 0);
    });
  });
}

Future<void> _insertKey(AppDatabase database, String id) {
  return database.customStatement(
    "INSERT INTO api_key_metadata "
    "(id, alias, secure_ref, masked_suffix, priority_order, is_enabled, "
    "health_status, success_count, failure_count, created_at, updated_at) "
    "VALUES ('$id', 'Utama', 'ref-$id', 'A1B2', 1, 1, 'healthy', 0, 0, 1, 1)",
  );
}

Future<void> _insertLog(
  AppDatabase database, {
  required String id,
  double calories = 500,
  String status = 'confirmed',
  String localDate = '2026-07-21',
  String? aiKeyId,
  int? deletedAt,
}) {
  final key = aiKeyId == null ? 'NULL' : "'$aiKeyId'";
  final deleted = deletedAt?.toString() ?? 'NULL';
  return database.customStatement(
    "INSERT INTO food_logs "
    "(id, local_date, consumed_at_utc, timezone_offset_minutes, meal_type, "
    "source, status, total_calories_kcal, total_protein_g, ai_key_metadata_id, "
    "created_at, updated_at, deleted_at) "
    "VALUES ('$id', '$localDate', 1, 420, 'lunch', 'manual', '$status', "
    "$calories, 10, $key, 1, 1, $deleted)",
  );
}

Future<int> _count(AppDatabase database, String table) async {
  final row = await database
      .customSelect('SELECT COUNT(*) AS total FROM $table')
      .getSingle();
  return row.read<int>('total');
}
