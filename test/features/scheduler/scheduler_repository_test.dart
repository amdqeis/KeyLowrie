import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/scheduler/data/scheduler_repository.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';

void main() {
  late AppDatabase database;
  late SchedulerRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = SchedulerRepository(database);
  });

  tearDown(() => database.close());

  ScheduleDraft event({
    String title = 'Meeting',
    DateTime? start,
    DateTime? end,
  }) {
    return ScheduleDraft(
      itemType: ScheduleItemType.event,
      title: title,
      startAtUtc: start ?? DateTime.utc(2026, 7, 29, 4),
      endAtUtc: end ?? DateTime.utc(2026, 7, 29, 5),
      localStartDate: '2026-07-29',
      categoryId: 'schedule-pekerjaan',
      categoryName: 'Pekerjaan',
      timezone: 'Asia/Jakarta',
    );
  }

  test('save is atomic and stores reminder rows', () async {
    final id = await repository.saveDraft(event());

    final saved = await repository.findById(id);
    final reminders = await database.select(database.scheduleReminders).get();
    expect(saved?.title, 'Meeting');
    expect(saved?.startAtUtc?.toUtc(), DateTime.utc(2026, 7, 29, 4));
    expect(reminders.single.offsetMinutes, 15);
  });

  test('half-open conflict allows adjacent event', () async {
    await repository.saveDraft(event());

    final overlapping = await repository.conflicts(
      startAtUtc: DateTime.utc(2026, 7, 29, 4, 30),
      endAtUtc: DateTime.utc(2026, 7, 29, 5, 30),
    );
    final adjacent = await repository.conflicts(
      startAtUtc: DateTime.utc(2026, 7, 29, 5),
      endAtUtc: DateTime.utc(2026, 7, 29, 6),
    );

    expect(overlapping.single.title, 'Meeting');
    expect(adjacent, isEmpty);
  });

  test('conflict detection expands recurring occurrences', () async {
    await repository.saveDraft(
      event().copyWith(
        recurrence: const ScheduleRecurrence(
          type: ScheduleRecurrenceType.weekly,
          weekdays: [DateTime.wednesday],
        ),
      ),
    );

    final conflicts = await repository.conflicts(
      startAtUtc: DateTime.utc(2026, 8, 5, 4, 30),
      endAtUtc: DateTime.utc(2026, 8, 5, 5, 30),
    );

    expect(conflicts.single.title, 'Meeting');
  });

  test('task reminder requires a due date', () {
    expect(
      () => repository.saveDraft(
        const ScheduleDraft(
          itemType: ScheduleItemType.task,
          title: 'Tanpa tanggal',
          categoryId: 'schedule-pribadi',
          categoryName: 'Pribadi',
          timezone: 'Asia/Jakarta',
        ),
      ),
      throwsA(
        isA<ScheduleValidationException>().having(
          (error) => error.reason,
          'reason',
          'task_reminder_without_due_date',
        ),
      ),
    );
  });
}
