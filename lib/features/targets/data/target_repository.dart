import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/targets/domain/target_calculator.dart';
import 'package:uuid/uuid.dart';

class TargetRepository {
  TargetRepository(this.database, {Uuid uuid = const Uuid()}) : _uuid = uuid;

  final AppDatabase database;
  final Uuid _uuid;

  Stream<DailyTarget?> watchEffectiveTarget(String date) {
    return (database.select(database.dailyTargets)
          ..where((row) => row.effectiveFromDate.isSmallerOrEqualValue(date))
          ..orderBy([
            (row) => OrderingTerm.desc(row.effectiveFromDate),
            (row) => OrderingTerm.desc(row.createdAt),
          ])
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<DailyTarget?> effectiveTarget(String date) {
    return (database.select(database.dailyTargets)
          ..where((row) => row.effectiveFromDate.isSmallerOrEqualValue(date))
          ..orderBy([
            (row) => OrderingTerm.desc(row.effectiveFromDate),
            (row) => OrderingTerm.desc(row.createdAt),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> saveManual(int calorieTarget, DateTime effectiveDate) {
    return _insert(
      calorieTarget: calorieTarget,
      effectiveDate: effectiveDate,
      source: 'manual',
    );
  }

  Future<void> saveEstimate(
    TargetEstimate estimate,
    DateTime effectiveDate, {
    required double weightKg,
    required double heightCm,
    required int age,
    required FormulaSex sex,
    required ActivityLevel activity,
    required CalorieGoal goal,
  }) async {
    final now = DateTime.now().toUtc();
    await database.transaction(() async {
      await (database.update(
        database.userProfiles,
      )..where((row) => row.id.equals('local_user'))).write(
        UserProfilesCompanion(
          birthYearOrAge: Value(age),
          sexForFormula: Value(sex.name),
          heightCm: Value(heightCm),
          weightKg: Value(weightKg),
          activityLevel: Value(activity.name),
          goalType: Value(goal.name),
          goalAdjustmentKcal: Value(estimate.adjustmentKcal),
          updatedAt: Value(now),
        ),
      );
      await database
          .into(database.dailyTargets)
          .insert(
            DailyTargetsCompanion.insert(
              id: _uuid.v4(),
              effectiveFromDate: localDateKey(effectiveDate),
              calorieTarget: estimate.suggestedTargetKcal,
              source: 'tdee',
              formulaSnapshotJson: Value(
                jsonEncode({
                  'formula': 'mifflin_st_jeor',
                  'bmr': estimate.bmr,
                  'activity_factor': estimate.activityFactor,
                  'tdee': estimate.tdee,
                  'adjustment_kcal': estimate.adjustmentKcal,
                }),
              ),
              createdAt: now,
            ),
          );
    });
  }

  Future<void> _insert({
    required int calorieTarget,
    required DateTime effectiveDate,
    required String source,
  }) {
    return database
        .into(database.dailyTargets)
        .insert(
          DailyTargetsCompanion.insert(
            id: _uuid.v4(),
            effectiveFromDate: localDateKey(effectiveDate),
            calorieTarget: calorieTarget,
            source: source,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }
}
