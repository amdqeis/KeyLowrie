import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:keyspace/database/migrations/schema.dart';
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
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

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
