import 'package:keyspace/features/scheduler/domain/schedule_models.dart';

class RecurrenceEngine {
  const RecurrenceEngine();

  List<ScheduleOccurrence> expand({
    required ScheduleOccurrence seed,
    required ScheduleRecurrence recurrence,
    required DateTime rangeStartUtc,
    required DateTime rangeEndUtc,
  }) {
    final seedStart = seed.startAtUtc ?? seed.dueAtUtc;
    if (seedStart == null) {
      return _expandLocalDate(
        seed: seed,
        recurrence: recurrence,
        rangeStartUtc: rangeStartUtc,
        rangeEndUtc: rangeEndUtc,
      );
    }
    final seedEnd = seed.endAtUtc;
    final duration = seedEnd?.difference(seedStart);
    final endDate = recurrence.endDateLocal;
    final results = <ScheduleOccurrence>[];
    var cursor = seedStart;
    var guard = 0;
    while (cursor.isBefore(rangeEndUtc) && guard++ < 3700) {
      if (endDate != null &&
          DateTime(cursor.year, cursor.month, cursor.day).isAfter(endDate)) {
        break;
      }
      if (!cursor.isBefore(rangeStartUtc) &&
          _matches(seedStart, cursor, recurrence)) {
        results.add(
          ScheduleOccurrence(
            scheduleItemId: seed.scheduleItemId,
            occurrenceKey: cursor.toUtc().toIso8601String(),
            title: seed.title,
            itemType: seed.itemType,
            status: seed.status,
            allDay: seed.allDay,
            categoryId: seed.categoryId,
            priority: seed.priority,
            startAtUtc: seed.startAtUtc == null ? null : cursor.toUtc(),
            endAtUtc: duration == null ? null : cursor.add(duration).toUtc(),
            dueAtUtc: seed.dueAtUtc == null ? null : cursor.toUtc(),
            localDate: seed.localDate,
          ),
        );
      }
      if (recurrence.type == ScheduleRecurrenceType.none) break;
      cursor = cursor.add(const Duration(days: 1));
    }
    return results;
  }

  List<ScheduleOccurrence> _expandLocalDate({
    required ScheduleOccurrence seed,
    required ScheduleRecurrence recurrence,
    required DateTime rangeStartUtc,
    required DateTime rangeEndUtc,
  }) {
    final parsed = DateTime.tryParse(seed.localDate ?? '');
    if (parsed == null) return [seed];
    final origin = DateTime.utc(parsed.year, parsed.month, parsed.day);
    final results = <ScheduleOccurrence>[];
    var cursor = origin;
    var guard = 0;
    while (cursor.isBefore(rangeEndUtc) && guard++ < 3700) {
      if (recurrence.endDateLocal != null &&
          DateTime(
            cursor.year,
            cursor.month,
            cursor.day,
          ).isAfter(recurrence.endDateLocal!)) {
        break;
      }
      if (!cursor.isBefore(rangeStartUtc) &&
          _matches(origin, cursor, recurrence)) {
        final key =
            '${cursor.year.toString().padLeft(4, '0')}-'
            '${cursor.month.toString().padLeft(2, '0')}-'
            '${cursor.day.toString().padLeft(2, '0')}';
        results.add(
          ScheduleOccurrence(
            scheduleItemId: seed.scheduleItemId,
            occurrenceKey: key,
            title: seed.title,
            itemType: seed.itemType,
            status: seed.status,
            allDay: seed.allDay,
            categoryId: seed.categoryId,
            priority: seed.priority,
            localDate: key,
          ),
        );
      }
      if (recurrence.type == ScheduleRecurrenceType.none) break;
      cursor = cursor.add(const Duration(days: 1));
    }
    return results;
  }

  bool _matches(
    DateTime seed,
    DateTime candidate,
    ScheduleRecurrence recurrence,
  ) {
    final days = DateTime(
      candidate.year,
      candidate.month,
      candidate.day,
    ).difference(DateTime(seed.year, seed.month, seed.day)).inDays;
    return switch (recurrence.type) {
      ScheduleRecurrenceType.none => days == 0,
      ScheduleRecurrenceType.daily => days % recurrence.interval == 0,
      ScheduleRecurrenceType.weekly =>
        (days ~/ 7) % recurrence.interval == 0 &&
            (recurrence.weekdays.isEmpty
                ? candidate.weekday == seed.weekday
                : recurrence.weekdays.contains(candidate.weekday)),
      ScheduleRecurrenceType.monthly =>
        _monthDistance(seed, candidate) % recurrence.interval == 0 &&
            candidate.day == seed.day,
    };
  }

  int _monthDistance(DateTime start, DateTime end) =>
      (end.year - start.year) * 12 + end.month - start.month;
}
