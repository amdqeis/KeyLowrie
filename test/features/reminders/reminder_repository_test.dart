import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/reminders/data/reminder_repository.dart';
import 'package:keyspace/features/reminders/domain/reminder_scheduler.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';

void main() {
  test('permission, schedule, dan threshold reconciliation', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await SettingsRepository(database).initialize();
    final scheduler = _FakeScheduler();
    final repository = ReminderRepository(database, scheduler);

    await repository.configure(
      enabled: true,
      hour: 20,
      minute: 15,
      thresholdPercent: 70,
    );
    expect(scheduler.schedules, [(20, 15)]);

    await repository.reconcile(progress: 0.75);
    expect(scheduler.cancelCount, 1);
  });
}

class _FakeScheduler implements ReminderScheduler {
  final List<(int, int)> schedules = [];
  int cancelCount = 0;

  @override
  Future<void> cancel() async => cancelCount++;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> scheduleNext({required int hour, required int minute}) async {
    schedules.add((hour, minute));
  }
}
