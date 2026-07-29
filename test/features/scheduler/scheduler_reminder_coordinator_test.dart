import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/scheduler/application/scheduler_reminder_coordinator.dart';
import 'package:keyspace/features/scheduler/data/schedule_notification_service.dart';
import 'package:keyspace/features/scheduler/data/scheduler_repository.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';

void main() {
  late AppDatabase database;
  late SchedulerRepository repository;
  late _FakeNotifications notifications;
  late SchedulerReminderCoordinator coordinator;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = SchedulerRepository(database);
    notifications = _FakeNotifications();
    coordinator = SchedulerReminderCoordinator(
      database: database,
      repository: repository,
      notifications: notifications,
    );
  });

  tearDown(() => database.close());

  test('reconcile registers occurrence and marks it scheduled', () async {
    final id = await repository.saveDraft(
      ScheduleDraft(
        itemType: ScheduleItemType.event,
        title: 'Review',
        startAtUtc: DateTime.utc(2026, 7, 29, 4),
        endAtUtc: DateTime.utc(2026, 7, 29, 5),
        localStartDate: '2026-07-29',
        categoryId: 'schedule-pekerjaan',
        categoryName: 'Pekerjaan',
        timezone: 'Asia/Jakarta',
      ),
    );

    await coordinator.reconcileItem(
      id,
      startUtc: DateTime.utc(2026, 7, 28),
      endUtc: DateTime.utc(2026, 7, 30),
    );

    final rows = await database
        .select(database.scheduleNotificationOccurrences)
        .get();
    expect(notifications.scheduledIds, hasLength(1));
    expect(rows.single.syncStatus, 'scheduled');
    expect(
      rows.single.scheduledAtUtc.toUtc(),
      DateTime.utc(2026, 7, 29, 3, 45),
    );
  });

  test('completed task cancels pending OS notifications', () async {
    final id = await repository.saveDraft(
      ScheduleDraft(
        itemType: ScheduleItemType.task,
        title: 'Kirim tugas',
        dueAtUtc: DateTime.utc(2026, 7, 29, 4),
        dueDateLocal: '2026-07-29',
        categoryId: 'schedule-kuliah',
        categoryName: 'Kuliah',
        timezone: 'Asia/Jakarta',
      ),
    );
    await coordinator.reconcileItem(
      id,
      startUtc: DateTime.utc(2026, 7, 28),
      endUtc: DateTime.utc(2026, 7, 30),
    );
    await repository.setCompleted(id, true);
    await coordinator.reconcileItem(id);

    expect(notifications.cancelledIds, isNotEmpty);
    expect(
      await database.select(database.scheduleNotificationOccurrences).get(),
      isEmpty,
    );
  });
}

class _FakeNotifications implements ScheduleNotificationService {
  final scheduledIds = <int>[];
  final cancelledIds = <int>[];

  @override
  Stream<String> get actions => const Stream.empty();

  @override
  Future<void> cancel(int id) async => cancelledIds.add(id);

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAtUtc,
    required String payload,
    required bool isTask,
  }) async {
    scheduledIds.add(id);
  }
}
