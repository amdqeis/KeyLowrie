import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:keyspace/database/migrations/schema.dart';
import 'package:keyspace/database/seed/finance_seed_data.dart';
import 'package:keyspace/database/tables/tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfiles,
    AppSettings,
    DailyTargets,
    FoodLogs,
    FoodItems,
    ChatSessions,
    ChatMessages,
    ApiKeyMetadata,
    ApiKeyUsageEvents,
    FavoriteTemplates,
    ReminderSettings,
    NotificationEvents,
    FinancialCategories,
    FinancialPeriods,
    FinancialTransactions,
    FinanceSettings,
    ChatDrafts,
    NetWorthInitializations,
    NetWorthAdjustments,
    ScheduleCategories,
    ScheduleItems,
    ScheduleReminders,
    ScheduleNotificationOccurrences,
    SchedulerSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => DatabaseSchema.currentVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(
          appSettings,
          appSettings.voiceDisclosureAcknowledged,
        );
        await migrator.createTable(financialCategories);
        await migrator.createTable(financialPeriods);
        await migrator.createTable(financialTransactions);
        await migrator.createTable(financeSettings);
        await migrator.createTable(chatDrafts);
        await migrator.createIndex(idxFinancialCategoriesTypeActive);
        await migrator.createIndex(idxFinancialPeriodsDates);
        await migrator.createIndex(idxFinancialTransactionsPeriodTypeDate);
        await migrator.createIndex(idxFinancialTransactionsCategory);
        await migrator.createIndex(idxFinancialTransactionsPeriodReimburse);
        await migrator.createIndex(idxChatDraftsUpdated);
      }
      if (from < 3) {
        await migrator.alterTable(TableMigration(chatDrafts));
        await migrator.createTable(scheduleCategories);
        await migrator.createTable(scheduleItems);
        await migrator.createTable(scheduleReminders);
        await migrator.createTable(scheduleNotificationOccurrences);
        await migrator.createTable(schedulerSettings);
        await migrator.createIndex(idxScheduleCategoriesActive);
        await migrator.createIndex(idxScheduleItemsTimeStatus);
        await migrator.createIndex(idxScheduleItemsDueStatus);
        await migrator.createIndex(idxScheduleItemsCategory);
        await migrator.createIndex(idxScheduleRemindersItemEnabled);
        await migrator.createIndex(idxScheduleOccurrencesItemTime);
        await migrator.createIndex(idxScheduleOccurrencesSync);
      }
      if (from < 4) {
        await migrator.createTable(netWorthInitializations);
        await migrator.createTable(netWorthAdjustments);
        if (from >= 3) {
          await migrator.addColumn(
            scheduleReminders,
            scheduleReminders.reminderType,
          );
        }
        await customStatement(
          "UPDATE schedule_reminders SET reminder_type = "
          "CASE WHEN offset_minutes = 1440 THEN 'day_before' ELSE 'minutes_before' END",
        );
        await migrator.createIndex(idxFinancialTransactionsDateTypeCategory);
        await migrator.createIndex(idxNetWorthAdjustmentsDate);
        if (from >= 3) {
          await migrator.alterTable(TableMigration(scheduleReminders));
        }
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await _seedFinanceDefaults();
      await _seedSchedulerDefaults();
    },
  );

  Future<void> _seedFinanceDefaults() async {
    final now = DateTime.now().toUtc();
    await transaction(() async {
      await into(financeSettings).insert(
        FinanceSettingsCompanion.insert(id: const Value(1), updatedAt: now),
        mode: InsertMode.insertOrIgnore,
      );
      await batch((batch) {
        batch.insertAll(
          financialCategories,
          defaultFinancialCategorySeeds.map(
            (seed) => FinancialCategoriesCompanion.insert(
              id: seed.id,
              name: seed.name,
              type: seed.type,
              iconKey: Value(seed.iconKey),
              isSystem: const Value(true),
              isActive: const Value(true),
              createdAt: now,
              updatedAt: now,
            ),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      });
    });
  }

  Future<void> _seedSchedulerDefaults() async {
    final now = DateTime.now().toUtc();
    const names = <String>[
      'Pekerjaan',
      'Kuliah',
      'Pribadi',
      'Kesehatan',
      'Keuangan',
      'Sosial',
      'Deadline',
      'Lainnya',
    ];
    await transaction(() async {
      await into(schedulerSettings).insert(
        SchedulerSettingsCompanion.insert(id: const Value(1), updatedAt: now),
        mode: InsertMode.insertOrIgnore,
      );
      await batch((batch) {
        batch.insertAll(
          scheduleCategories,
          names.map(
            (name) => ScheduleCategoriesCompanion.insert(
              id: 'schedule-${name.toLowerCase()}',
              name: name,
              isSystem: true,
              isActive: true,
              createdAt: now,
              updatedAt: now,
            ),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      });
    });
  }

  Future<DailyNutritionTotal> dailyNutritionTotal(String localDate) async {
    final calories = foodLogs.totalCaloriesKcal.sum();
    final protein = foodLogs.totalProteinG.sum();
    final carbs = foodLogs.totalCarbsG.sum();
    final fat = foodLogs.totalFatG.sum();
    final query = selectOnly(foodLogs)
      ..addColumns([calories, protein, carbs, fat])
      ..where(
        foodLogs.localDate.equals(localDate) &
            foodLogs.status.equals('confirmed') &
            foodLogs.deletedAt.isNull(),
      );
    final row = await query.getSingle();
    return DailyNutritionTotal(
      caloriesKcal: row.read(calories) ?? 0,
      proteinG: row.read(protein),
      carbsG: row.read(carbs),
      fatG: row.read(fat),
    );
  }

  Future<void> insertFoodLogWithItems(
    FoodLogsCompanion log,
    Iterable<FoodItemsCompanion> items,
  ) {
    return transaction(() async {
      await into(foodLogs).insert(log);
      await batch((batch) => batch.insertAll(foodItems, items));
    });
  }
}

class DailyNutritionTotal {
  const DailyNutritionTotal({
    required this.caloriesKcal,
    this.proteinG,
    this.carbsG,
    this.fatG,
  });

  final double caloriesKcal;
  final double? proteinG;
  final double? carbsG;
  final double? fatG;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'keyspace.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
