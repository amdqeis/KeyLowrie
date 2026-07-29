import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/scheduler/domain/recurrence_engine.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';

void main() {
  const engine = RecurrenceEngine();
  final seed = ScheduleOccurrence(
    scheduleItemId: 'series-1',
    occurrenceKey: 'seed',
    title: 'Rapat',
    itemType: ScheduleItemType.event,
    status: ScheduleStatus.pending,
    allDay: false,
    categoryId: 'schedule-pekerjaan',
    priority: SchedulePriority.medium,
    startAtUtc: DateTime.utc(2026, 7, 27, 3),
    endAtUtc: DateTime.utc(2026, 7, 27, 4),
  );

  test('weekly recurrence expands ISO Monday and Wednesday', () {
    final occurrences = engine.expand(
      seed: seed,
      recurrence: const ScheduleRecurrence(
        type: ScheduleRecurrenceType.weekly,
        weekdays: [DateTime.monday, DateTime.wednesday],
      ),
      rangeStartUtc: DateTime.utc(2026, 7, 27),
      rangeEndUtc: DateTime.utc(2026, 8, 3),
    );

    expect(occurrences.map((item) => item.startAtUtc!.weekday), [1, 3]);
    expect(
      occurrences.every(
        (item) =>
            item.endAtUtc!.difference(item.startAtUtc!) ==
            const Duration(hours: 1),
      ),
      isTrue,
    );
  });

  test('monthly recurrence skips months without original day', () {
    final monthlySeed = ScheduleOccurrence(
      scheduleItemId: 'series-31',
      occurrenceKey: 'seed',
      title: 'Tutup buku',
      itemType: ScheduleItemType.event,
      status: ScheduleStatus.pending,
      allDay: false,
      categoryId: 'schedule-keuangan',
      priority: SchedulePriority.high,
      startAtUtc: DateTime.utc(2026, 1, 31, 3),
      endAtUtc: DateTime.utc(2026, 1, 31, 4),
    );

    final occurrences = engine.expand(
      seed: monthlySeed,
      recurrence: const ScheduleRecurrence(
        type: ScheduleRecurrenceType.monthly,
      ),
      rangeStartUtc: DateTime.utc(2026),
      rangeEndUtc: DateTime.utc(2026, 5),
    );

    expect(occurrences.map((item) => item.startAtUtc!.month), [1, 3]);
  });
}
