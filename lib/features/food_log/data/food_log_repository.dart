import 'package:drift/drift.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/food_log/domain/food_log_input.dart';
import 'package:uuid/uuid.dart';

class FoodLogRepository {
  FoodLogRepository(this.database, {Uuid uuid = const Uuid()}) : _uuid = uuid;

  final AppDatabase database;
  final Uuid _uuid;

  Stream<List<FoodLog>> watchLogsForDate(String date) {
    return (database.select(database.foodLogs)
          ..where(
            (row) =>
                row.localDate.equals(date) &
                row.status.equals('confirmed') &
                row.deletedAt.isNull(),
          )
          ..orderBy([(row) => OrderingTerm.desc(row.consumedAtUtc)]))
        .watch();
  }

  Future<List<FoodLog>> logsForDate(String date) {
    return (database.select(database.foodLogs)
          ..where(
            (row) =>
                row.localDate.equals(date) &
                row.status.equals('confirmed') &
                row.deletedAt.isNull(),
          )
          ..orderBy([(row) => OrderingTerm.desc(row.consumedAtUtc)]))
        .get();
  }

  Stream<DailyNutritionTotal> watchTotal(String date) {
    final calories = database.foodLogs.totalCaloriesKcal.sum();
    final protein = database.foodLogs.totalProteinG.sum();
    final carbs = database.foodLogs.totalCarbsG.sum();
    final fat = database.foodLogs.totalFatG.sum();
    final query = database.selectOnly(database.foodLogs)
      ..addColumns([calories, protein, carbs, fat])
      ..where(
        database.foodLogs.localDate.equals(date) &
            database.foodLogs.status.equals('confirmed') &
            database.foodLogs.deletedAt.isNull(),
      );
    return query.watchSingle().map(
      (row) => DailyNutritionTotal(
        caloriesKcal: row.read(calories) ?? 0,
        proteinG: row.read(protein),
        carbsG: row.read(carbs),
        fatG: row.read(fat),
      ),
    );
  }

  Stream<List<FoodLog>> watchPendingDrafts() {
    return (database.select(database.foodLogs)
          ..where((row) => row.status.equals('draft') & row.deletedAt.isNull())
          ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)]))
        .watch();
  }

  Stream<List<String>> watchHistoryDates() {
    final query = database.selectOnly(database.foodLogs, distinct: true)
      ..addColumns([database.foodLogs.localDate])
      ..where(
        database.foodLogs.status.equals('confirmed') &
            database.foodLogs.deletedAt.isNull(),
      )
      ..orderBy([OrderingTerm.desc(database.foodLogs.localDate)]);
    return query.watch().map(
      (rows) =>
          rows.map((row) => row.read(database.foodLogs.localDate)!).toList(),
    );
  }

  Future<FoodLogDetail?> detail(String id) async {
    final log = await (database.select(
      database.foodLogs,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (log == null) return null;
    final items =
        await (database.select(database.foodItems)
              ..where((row) => row.foodLogId.equals(id))
              ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
            .get();
    return FoodLogDetail(log: log, items: items);
  }

  Future<String> saveManual(FoodLogInput input) async {
    final id = _uuid.v4();
    await _saveConfirmed(id: id, input: input, source: 'manual');
    return id;
  }

  Future<String> createDraft({
    required String requestId,
    required String input,
    required DateTime consumedAt,
    required String mealType,
  }) async {
    final existing = await (database.select(
      database.foodLogs,
    )..where((row) => row.localRequestId.equals(requestId))).getSingleOrNull();
    if (existing != null) {
      await (database.update(
        database.foodLogs,
      )..where((row) => row.id.equals(existing.id))).write(
        FoodLogsCompanion(
          localDate: Value(localDateKey(consumedAt)),
          consumedAtUtc: Value(consumedAt.toUtc()),
          timezoneOffsetMinutes: Value(consumedAt.timeZoneOffset.inMinutes),
          mealType: Value(mealType),
          originalUserText: Value(input.trim()),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return existing.id;
    }
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    final utc = consumedAt.toUtc();
    await database
        .into(database.foodLogs)
        .insert(
          FoodLogsCompanion.insert(
            id: id,
            localRequestId: Value(requestId),
            localDate: localDateKey(consumedAt),
            consumedAtUtc: utc,
            timezoneOffsetMinutes: consumedAt.timeZoneOffset.inMinutes,
            mealType: mealType,
            source: 'ai',
            status: 'draft',
            originalUserText: Value(input.trim()),
            totalCaloriesKcal: 0,
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<void> applyParsedDraft({
    required String requestId,
    required ParsedFoodDraft draft,
    required String keyId,
  }) async {
    final log = await (database.select(
      database.foodLogs,
    )..where((row) => row.localRequestId.equals(requestId))).getSingle();
    final now = DateTime.now().toUtc();
    await database.transaction(() async {
      await (database.delete(
        database.foodItems,
      )..where((row) => row.foodLogId.equals(log.id))).go();
      await database.batch((batch) {
        batch.insertAll(
          database.foodItems,
          draft.items.indexed.map((entry) {
            final item = entry.$2;
            return FoodItemsCompanion.insert(
              id: _uuid.v4(),
              foodLogId: log.id,
              displayName: item.name,
              normalizedName: Value(_normalize(item.name)),
              quantity: Value(item.quantity),
              unit: Value(item.unit),
              portionText: Value(item.portionText),
              caloriesKcal: item.caloriesKcal,
              proteinG: Value(item.proteinG),
              carbsG: Value(item.carbsG),
              fatG: Value(item.fatG),
              fiberG: Value(item.fiberG),
              sodiumMg: Value(item.sodiumMg),
              confidence: Value(item.confidence),
              assumptionNote: Value(item.assumptionNote),
              sortOrder: entry.$1,
              createdAt: now,
              updatedAt: now,
            );
          }),
        );
      });
      await (database.update(
        database.foodLogs,
      )..where((row) => row.id.equals(log.id))).write(
        FoodLogsCompanion(
          totalCaloriesKcal: Value(draft.totalCaloriesKcal),
          totalProteinG: Value(draft.totalProteinG),
          totalCarbsG: Value(draft.totalCarbsG),
          totalFatG: Value(draft.totalFatG),
          notes: Value(draft.generalNote),
          aiModel: const Value(ProviderConfig.model),
          aiKeyMetadataId: Value(keyId),
          updatedAt: Value(now),
        ),
      );
      await (database.update(database.chatMessages)
            ..where((row) => row.localRequestId.equals(requestId)))
          .write(ChatMessagesCompanion(foodLogId: Value(log.id)));
    });
  }

  Future<void> confirmDraft(String id) {
    return (database.update(
      database.foodLogs,
    )..where((row) => row.id.equals(id) & row.status.equals('draft'))).write(
      FoodLogsCompanion(
        status: const Value('confirmed'),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> update(String id, FoodLogInput input) async {
    final detailValue = await detail(id);
    if (detailValue == null) throw StateError('food_log_not_found');
    final totals = _totals(input.items);
    final now = DateTime.now().toUtc();
    await database.transaction(() async {
      await (database.delete(
        database.foodItems,
      )..where((row) => row.foodLogId.equals(id))).go();
      await _insertItems(id, input.items, now);
      await (database.update(
        database.foodLogs,
      )..where((row) => row.id.equals(id))).write(
        FoodLogsCompanion(
          localDate: Value(localDateKey(input.consumedAt)),
          consumedAtUtc: Value(input.consumedAt.toUtc()),
          timezoneOffsetMinutes: Value(
            input.consumedAt.timeZoneOffset.inMinutes,
          ),
          mealType: Value(input.mealType),
          originalUserText: Value(input.originalUserText),
          notes: Value(input.notes),
          totalCaloriesKcal: Value(totals.$1),
          totalProteinG: Value(totals.$2),
          totalCarbsG: Value(totals.$3),
          totalFatG: Value(totals.$4),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<String> duplicate(String id, DateTime consumedAt) async {
    final value = await detail(id);
    if (value == null) throw StateError('food_log_not_found');
    final log = value.log as FoodLog;
    final items = value.items.cast<FoodItem>();
    return saveManual(
      FoodLogInput(
        consumedAt: consumedAt,
        mealType: log.mealType,
        originalUserText: log.originalUserText,
        notes: log.notes,
        items: items
            .map(
              (item) => FoodItemInput(
                name: item.displayName,
                caloriesKcal: item.caloriesKcal,
                quantity: item.quantity,
                unit: item.unit,
                portionText: item.portionText,
                proteinG: item.proteinG,
                carbsG: item.carbsG,
                fatG: item.fatG,
                fiberG: item.fiberG,
                sodiumMg: item.sodiumMg,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<bool> isPotentialDuplicate(FoodLogInput input) async {
    final from = input.consumedAt.toUtc().subtract(
      ProviderConfig.duplicateWindow,
    );
    final until = input.consumedAt.toUtc().add(ProviderConfig.duplicateWindow);
    final total = _totals(input.items).$1;
    final candidates =
        await (database.select(database.foodLogs)..where(
              (row) =>
                  row.status.equals('confirmed') &
                  row.deletedAt.isNull() &
                  row.consumedAtUtc.isBiggerOrEqualValue(from) &
                  row.consumedAtUtc.isSmallerOrEqualValue(until),
            ))
            .get();
    return candidates.any((row) => (row.totalCaloriesKcal - total).abs() <= 1);
  }

  Future<void> softDelete(String id, DateTime at) {
    return (database.update(database.foodLogs)
          ..where((row) => row.id.equals(id) & row.deletedAt.isNull()))
        .write(FoodLogsCompanion(deletedAt: Value(at.toUtc())));
  }

  Future<void> undoDelete(String id) {
    return (database.update(
      database.foodLogs,
    )..where((row) => row.id.equals(id))).write(
      FoodLogsCompanion(
        deletedAt: const Value(null),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<int> purgeExpiredDeletes(DateTime now) {
    final cutoff = now.toUtc().subtract(ProviderConfig.undoWindow);
    return (database.delete(
      database.foodLogs,
    )..where((row) => row.deletedAt.isSmallerOrEqualValue(cutoff))).go();
  }

  Future<void> discardDraft(String id) {
    return (database.delete(
      database.foodLogs,
    )..where((row) => row.id.equals(id) & row.status.equals('draft'))).go();
  }

  Future<void> _saveConfirmed({
    required String id,
    required FoodLogInput input,
    required String source,
  }) async {
    if (input.items.isEmpty) throw const FormatException('items_empty');
    final totals = _totals(input.items);
    final now = DateTime.now().toUtc();
    await database.transaction(() async {
      await database
          .into(database.foodLogs)
          .insert(
            FoodLogsCompanion.insert(
              id: id,
              localDate: localDateKey(input.consumedAt),
              consumedAtUtc: input.consumedAt.toUtc(),
              timezoneOffsetMinutes: input.consumedAt.timeZoneOffset.inMinutes,
              mealType: input.mealType,
              source: source,
              status: 'confirmed',
              originalUserText: Value(input.originalUserText),
              notes: Value(input.notes),
              totalCaloriesKcal: totals.$1,
              totalProteinG: Value(totals.$2),
              totalCarbsG: Value(totals.$3),
              totalFatG: Value(totals.$4),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await _insertItems(id, input.items, now);
    });
  }

  Future<void> _insertItems(
    String logId,
    List<FoodItemInput> items,
    DateTime now,
  ) {
    return database.batch((batch) {
      batch.insertAll(
        database.foodItems,
        items.indexed.map((entry) {
          final item = entry.$2;
          return FoodItemsCompanion.insert(
            id: _uuid.v4(),
            foodLogId: logId,
            displayName: item.name.trim(),
            normalizedName: Value(_normalize(item.name)),
            quantity: Value(item.quantity),
            unit: Value(item.unit),
            portionText: Value(item.portionText),
            caloriesKcal: item.caloriesKcal,
            proteinG: Value(item.proteinG),
            carbsG: Value(item.carbsG),
            fatG: Value(item.fatG),
            fiberG: Value(item.fiberG),
            sodiumMg: Value(item.sodiumMg),
            confidence: Value(item.confidence),
            assumptionNote: Value(item.assumptionNote),
            sortOrder: entry.$1,
            createdAt: now,
            updatedAt: now,
          );
        }),
      );
    });
  }

  (double, double?, double?, double?) _totals(List<FoodItemInput> items) {
    double calories = 0;
    double? protein;
    double? carbs;
    double? fat;
    for (final item in items) {
      if (!item.caloriesKcal.isFinite || item.caloriesKcal < 0) {
        throw const FormatException('calories_invalid');
      }
      calories += item.caloriesKcal;
      if (item.proteinG != null) protein = (protein ?? 0) + item.proteinG!;
      if (item.carbsG != null) carbs = (carbs ?? 0) + item.carbsG!;
      if (item.fatG != null) fat = (fat ?? 0) + item.fatG!;
    }
    return (calories, protein, carbs, fat);
  }

  String _normalize(String value) => value
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
      .replaceAll(RegExp(r'\s+'), ' ');
}
