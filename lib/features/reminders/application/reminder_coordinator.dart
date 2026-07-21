import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/reminders/data/reminder_repository.dart';
import 'package:keyspace/features/targets/data/target_repository.dart';

class ReminderCoordinator {
  const ReminderCoordinator(this.database, this.targets, this.reminders);

  final AppDatabase database;
  final TargetRepository targets;
  final ReminderRepository reminders;

  Future<void> reconcileToday() => reconcileDate(localDateKey(DateTime.now()));

  Future<void> reconcileDate(String date) async {
    if (date != localDateKey(DateTime.now())) return;
    final target = await targets.effectiveTarget(date);
    if (target == null || target.calorieTarget <= 0) return;
    final total = await database.dailyNutritionTotal(date);
    await reminders.reconcile(
      progress: total.caloriesKcal / target.calorieTarget,
    );
  }
}
