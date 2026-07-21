import 'package:drift/drift.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/reminders/domain/reminder_scheduler.dart';

class ReminderRepository {
  const ReminderRepository(this.database, this.scheduler);

  final AppDatabase database;
  final ReminderScheduler scheduler;

  Stream<ReminderSetting> watch() {
    return (database.select(
      database.reminderSettings,
    )..where((row) => row.id.equals(1))).watchSingle();
  }

  Future<void> configure({
    required bool enabled,
    required int hour,
    required int minute,
    required int thresholdPercent,
  }) async {
    var permission = 'not_requested';
    var effectiveEnabled = enabled;
    if (enabled) {
      final granted = await scheduler.requestPermission();
      permission = granted ? 'granted' : 'denied';
      effectiveEnabled = granted;
      if (granted) {
        await scheduler.scheduleNext(hour: hour, minute: minute);
      }
    } else {
      await scheduler.cancel();
    }
    await (database.update(
      database.reminderSettings,
    )..where((row) => row.id.equals(1))).write(
      ReminderSettingsCompanion(
        isEnabled: Value(effectiveEnabled),
        reminderTimeLocal: Value(
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
        ),
        thresholdPercent: Value(thresholdPercent.clamp(1, 100)),
        permissionStatus: Value(permission),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> reconcile({required double progress}) async {
    final settings = await (database.select(
      database.reminderSettings,
    )..where((row) => row.id.equals(1))).getSingle();
    if (!settings.isEnabled || settings.permissionStatus != 'granted') return;
    if (progress * 100 >= settings.thresholdPercent) {
      await scheduler.cancel();
      return;
    }
    final parts = settings.reminderTimeLocal.split(':').map(int.parse).toList();
    await scheduler.scheduleNext(hour: parts[0], minute: parts[1]);
  }
}
