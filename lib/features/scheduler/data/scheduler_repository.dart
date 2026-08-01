import 'package:drift/drift.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/scheduler/domain/recurrence_engine.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';
import 'package:uuid/uuid.dart';

class SchedulerRepository {
  SchedulerRepository(
    this.database, {
    RecurrenceEngine recurrenceEngine = const RecurrenceEngine(),
    Uuid uuid = const Uuid(),
  }) : _recurrenceEngine = recurrenceEngine,
       _uuid = uuid;

  final AppDatabase database;
  final RecurrenceEngine _recurrenceEngine;
  final Uuid _uuid;

  Stream<List<ScheduleItem>> watchItems() {
    return (database.select(
      database.scheduleItems,
    )..orderBy([(row) => OrderingTerm.asc(row.startAtUtc)])).watch();
  }

  Stream<List<ScheduleCategory>> watchCategories() {
    return (database.select(database.scheduleCategories)
          ..where((row) => row.isActive.equals(true))
          ..orderBy([(row) => OrderingTerm.asc(row.name)]))
        .watch();
  }

  Future<List<ScheduleCategory>> activeCategories() =>
      (database.select(database.scheduleCategories)
            ..where((row) => row.isActive.equals(true))
            ..orderBy([(row) => OrderingTerm.asc(row.name)]))
          .get();

  Future<ScheduleItem?> findById(String id) => (database.select(
    database.scheduleItems,
  )..where((row) => row.id.equals(id))).getSingleOrNull();

  Future<List<ScheduleReminder>> remindersForItem(String id) =>
      (database.select(database.scheduleReminders)
            ..where(
              (row) =>
                  row.scheduleItemId.equals(id) & row.isEnabled.equals(true),
            )
            ..orderBy([(row) => OrderingTerm.asc(row.offsetMinutes)]))
          .get();

  Future<ScheduleReminderSelection> reminderSelectionForItem(String id) async {
    final reminders = await (database.select(
      database.scheduleReminders,
    )..where((row) => row.scheduleItemId.equals(id))).get();
    final day = reminders.where((row) => row.reminderType == 'day_before');
    final minutes = reminders.where(
      (row) => row.reminderType == 'minutes_before',
    );
    return ScheduleReminderSelection(
      dayBeforeEnabled: day.any((row) => row.isEnabled),
      minutesBeforeEnabled: minutes.any((row) => row.isEnabled),
      minutesBeforeOffset:
          minutes
              .where(
                (row) => row.offsetMinutes == 15 || row.offsetMinutes == 30,
              )
              .firstOrNull
              ?.offsetMinutes ??
          30,
    );
  }

  Future<String> saveDraft(
    ScheduleDraft draft, {
    String? id,
    String source = 'manual',
    String? originalUserText,
    ScheduleReminderSelection? reminderSelection,
  }) async {
    _validate(draft);
    var selection =
        reminderSelection ??
        ScheduleReminderSelection.fromOffsets(draft.reminderOffsets);
    if (draft.itemType == ScheduleItemType.task &&
        draft.dueAtUtc == null &&
        draft.dueDateLocal == null) {
      selection = const ScheduleReminderSelection(
        dayBeforeEnabled: false,
        minutesBeforeEnabled: false,
      );
    }
    final itemId = id ?? _uuid.v4();
    final now = DateTime.now().toUtc();
    await database.transaction(() async {
      final existing = id == null ? null : await findById(id);
      await database
          .into(database.scheduleItems)
          .insertOnConflictUpdate(
            ScheduleItemsCompanion.insert(
              id: itemId,
              itemType: draft.itemType.name,
              title: draft.title.trim(),
              description: Value(_emptyToNull(draft.description)),
              startAtUtc: Value(draft.startAtUtc?.toUtc()),
              endAtUtc: Value(draft.endAtUtc?.toUtc()),
              dueAtUtc: Value(draft.dueAtUtc?.toUtc()),
              localStartDate: Value(draft.localStartDate),
              localStartTime: Value(draft.localStartTime),
              localEndTime: Value(draft.localEndTime),
              dueDateLocal: Value(draft.dueDateLocal),
              allDay: draft.allDay,
              categoryId: draft.categoryId,
              priority: draft.priority.name,
              status: existing?.status ?? ScheduleStatus.pending.name,
              timezone: draft.timezone,
              recurrenceType: draft.recurrence.type.name,
              recurrenceInterval: Value(draft.recurrence.interval),
              recurrenceWeekdaysJson: Value(draft.recurrence.weekdaysJson),
              recurrenceEndDateLocal: Value(
                _dateKey(draft.recurrence.endDateLocal),
              ),
              source: Value(source),
              originalUserText: Value(originalUserText),
              completedAt: Value(existing?.completedAt),
              createdAt: existing?.createdAt ?? now,
              updatedAt: now,
            ),
          );
      await (database.delete(
        database.scheduleReminders,
      )..where((row) => row.scheduleItemId.equals(itemId))).go();
      await database.batch((batch) {
        batch.insertAll(
          database.scheduleReminders,
          [
            (
              type: 'day_before',
              offset: 1440,
              enabled: selection.dayBeforeEnabled,
            ),
            (
              type: 'minutes_before',
              offset: selection.minutesBeforeOffset,
              enabled: selection.minutesBeforeEnabled,
            ),
          ].map(
            (reminder) => ScheduleRemindersCompanion.insert(
              id: _uuid.v4(),
              scheduleItemId: itemId,
              reminderType: Value(reminder.type),
              offsetMinutes: reminder.offset,
              isEnabled: reminder.enabled,
              createdAt: now,
              updatedAt: now,
            ),
          ),
        );
      });
    });
    return itemId;
  }

  Future<void> setCompleted(String id, bool completed) async {
    final now = DateTime.now().toUtc();
    await (database.update(
      database.scheduleItems,
    )..where((row) => row.id.equals(id))).write(
      ScheduleItemsCompanion(
        status: Value(
          completed
              ? ScheduleStatus.completed.name
              : ScheduleStatus.pending.name,
        ),
        completedAt: Value(completed ? now : null),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> deleteSeries(String id) async {
    await (database.delete(
      database.scheduleItems,
    )..where((row) => row.id.equals(id))).go();
  }

  Future<List<ScheduleOccurrence>> occurrencesBetween(
    DateTime startUtc,
    DateTime endUtc,
  ) async {
    final rows =
        await (database.select(database.scheduleItems)..where(
              (row) => row.status.equals(ScheduleStatus.cancelled.name).not(),
            ))
            .get();
    return rows
        .expand(
          (row) => _recurrenceEngine.expand(
            seed: _occurrence(row),
            recurrence: ScheduleRecurrence(
              type: ScheduleRecurrenceType.values.byName(row.recurrenceType),
              interval: row.recurrenceInterval,
              weekdays: ScheduleRecurrence.decodeWeekdays(
                row.recurrenceWeekdaysJson,
              ),
              endDateLocal: DateTime.tryParse(row.recurrenceEndDateLocal ?? ''),
            ),
            rangeStartUtc: startUtc.toUtc(),
            rangeEndUtc: endUtc.toUtc(),
          ),
        )
        .toList()
      ..sort(
        (a, b) => (a.startAtUtc ?? a.dueAtUtc ?? DateTime(9999)).compareTo(
          b.startAtUtc ?? b.dueAtUtc ?? DateTime(9999),
        ),
      );
  }

  Future<List<ScheduleConflict>> conflicts({
    String? excludingId,
    required DateTime startAtUtc,
    required DateTime endAtUtc,
  }) async {
    final occurrences = await occurrencesBetween(
      startAtUtc.toUtc().subtract(const Duration(days: 366)),
      endAtUtc.toUtc(),
    );
    return occurrences
        .where(
          (occurrence) =>
              occurrence.scheduleItemId != excludingId &&
              occurrence.itemType == ScheduleItemType.event &&
              !occurrence.allDay &&
              occurrence.status == ScheduleStatus.pending &&
              occurrence.startAtUtc != null &&
              occurrence.endAtUtc != null &&
              occurrence.startAtUtc!.isBefore(endAtUtc.toUtc()) &&
              occurrence.endAtUtc!.isAfter(startAtUtc.toUtc()),
        )
        .map(
          (occurrence) => ScheduleConflict(
            scheduleItemId: occurrence.scheduleItemId,
            title: occurrence.title,
            startAtUtc: occurrence.startAtUtc!,
            endAtUtc: occurrence.endAtUtc!,
          ),
        )
        .toList(growable: false);
  }

  ScheduleOccurrence _occurrence(ScheduleItem row) => ScheduleOccurrence(
    scheduleItemId: row.id,
    occurrenceKey:
        row.startAtUtc?.toIso8601String() ??
        row.dueAtUtc?.toIso8601String() ??
        row.localStartDate ??
        row.dueDateLocal ??
        row.id,
    title: row.title,
    itemType: ScheduleItemType.values.byName(row.itemType),
    status: ScheduleStatus.values.byName(row.status),
    allDay: row.allDay,
    categoryId: row.categoryId,
    priority: SchedulePriority.values.byName(row.priority),
    startAtUtc: row.startAtUtc,
    endAtUtc: row.endAtUtc,
    dueAtUtc: row.dueAtUtc,
    localDate: row.localStartDate ?? row.dueDateLocal,
  );

  void _validate(ScheduleDraft draft) {
    if (draft.title.trim().isEmpty) {
      throw const ScheduleValidationException('title_empty');
    }
    if (draft.recurrence.interval < 1) {
      throw const ScheduleValidationException('recurrence_interval_invalid');
    }
    if (draft.recurrence.weekdays.any((day) => day < 1 || day > 7)) {
      throw const ScheduleValidationException('weekday_invalid');
    }
    if (draft.itemType == ScheduleItemType.event &&
        !draft.allDay &&
        draft.startAtUtc == null) {
      throw const ScheduleValidationException('event_start_missing');
    }
    if (draft.startAtUtc != null &&
        draft.endAtUtc != null &&
        !draft.endAtUtc!.isAfter(draft.startAtUtc!)) {
      throw const ScheduleValidationException('event_end_invalid');
    }
    if (draft.reminderOffsets.any(
      (offset) => offset != 15 && offset != 30 && offset != 1440,
    )) {
      throw const ScheduleValidationException('reminder_offset_invalid');
    }
  }

  String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  String? _dateKey(DateTime? value) => value == null
      ? null
      : '${value.year.toString().padLeft(4, '0')}-'
            '${value.month.toString().padLeft(2, '0')}-'
            '${value.day.toString().padLeft(2, '0')}';
}
