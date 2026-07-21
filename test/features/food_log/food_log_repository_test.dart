import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_log/data/food_log_repository.dart';
import 'package:keyspace/features/food_log/domain/food_log_input.dart';

void main() {
  late AppDatabase database;
  late FoodLogRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = FoodLogRepository(database);
  });

  tearDown(() => database.close());

  test('manual CRUD menghitung total dan tetap tersedia offline', () async {
    final at = DateTime(2026, 7, 21, 12);
    final id = await repository.saveManual(_input(at));

    final total = await database.dailyNutritionTotal(localDateKey(at));
    expect(total.caloriesKcal, 500);
    expect(total.proteinG, 20);
    expect((await repository.detail(id))!.items, hasLength(2));

    await repository.update(
      id,
      FoodLogInput(
        consumedAt: at.add(const Duration(days: 1)),
        mealType: 'makan_malam',
        items: const [FoodItemInput(name: 'Sup', caloriesKcal: 250)],
      ),
    );
    expect(await repository.logsForDate('2026-07-21'), isEmpty);
    expect(await repository.logsForDate('2026-07-22'), hasLength(1));
  });

  test('draft dikecualikan dari agregasi lalu masuk setelah confirm', () async {
    final at = DateTime(2026, 7, 21, 12);
    final id = await repository.createDraft(
      requestId: 'request-1',
      input: 'nasi goreng',
      consumedAt: at,
      mealType: 'makan_siang',
    );

    expect((await database.dailyNutritionTotal('2026-07-21')).caloriesKcal, 0);
    await repository.update(
      id,
      FoodLogInput(
        consumedAt: at,
        mealType: 'makan_siang',
        items: const [FoodItemInput(name: 'Nasi goreng', caloriesKcal: 600)],
      ),
    );
    await repository.confirmDraft(id);
    expect(
      (await database.dailyNutritionTotal('2026-07-21')).caloriesKcal,
      600,
    );
  });

  test('soft delete, undo, dan expiry cleanup konsisten', () async {
    final at = DateTime.utc(2026, 7, 21, 12);
    final id = await repository.saveManual(_input(at));
    await repository.softDelete(id, at);
    expect((await database.dailyNutritionTotal('2026-07-21')).caloriesKcal, 0);

    await repository.undoDelete(id);
    expect(
      (await database.dailyNutritionTotal('2026-07-21')).caloriesKcal,
      500,
    );

    await repository.softDelete(id, at);
    final purged = await repository.purgeExpiredDeletes(
      at.add(ProviderConfig.undoWindow).add(const Duration(milliseconds: 1)),
    );
    expect(purged, 1);
    expect(await repository.detail(id), isNull);
  });

  test('duplicate detector memberi warning pada interval dua menit', () async {
    final at = DateTime(2026, 7, 21, 12);
    await repository.saveManual(_input(at));
    expect(
      await repository.isPotentialDuplicate(
        _input(at.add(const Duration(minutes: 1))),
      ),
      isTrue,
    );
    expect(
      await repository.isPotentialDuplicate(
        _input(at.add(const Duration(minutes: 3))),
      ),
      isFalse,
    );
  });
}

FoodLogInput _input(DateTime at) => FoodLogInput(
  consumedAt: at,
  mealType: 'makan_siang',
  items: const [
    FoodItemInput(name: 'Nasi', caloriesKcal: 300, proteinG: 5),
    FoodItemInput(name: 'Ayam', caloriesKcal: 200, proteinG: 15),
  ],
);
