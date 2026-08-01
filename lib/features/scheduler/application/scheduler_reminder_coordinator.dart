import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/scheduler/data/schedule_notification_service.dart';
import 'package:keyspace/features/scheduler/data/scheduler_repository.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

class SchedulerReminderCoordinator {
  SchedulerReminderCoordinator({
    required this.database,
    required this.repository,
    required this.notifications,
    Uuid uuid = const Uuid(),
  }) : _uuid = uuid;

  final AppDatabase database;
  final SchedulerRepository repository;
  final ScheduleNotificationService notifications;
  final Uuid _uuid;

  Future<void> reconcileAll() async {
    await notifications.initialize();
    final settings = await (database.select(
      database.schedulerSettings,
    )..where((row) => row.id.equals(1))).getSingle();
    final now = DateTime.now().toUtc();
    final end = now.add(Duration(days: settings.rollingHorizonDays));
    final items = await database.select(database.scheduleItems).get();
    for (final item in items) {
      if (item.status == 'pending') {
        await reconcileItem(item.id, startUtc: now, endUtc: end);
      } else {
        await cancelItem(item.id);
      }
    }
  }

  Future<ReminderReconciliationResult> reconcileItem(
    String itemId, {
    DateTime? startUtc,
    DateTime? endUtc,
  }) async {
    final item = await repository.findById(itemId);
    if (item == null || item.status != 'pending') {
      await cancelItem(itemId);
      return const ReminderReconciliationResult();
    }
    final settings = await (database.select(
      database.schedulerSettings,
    )..where((row) => row.id.equals(1))).getSingle();
    final from = startUtc ?? DateTime.now().toUtc();
    final until =
        endUtc ?? from.add(Duration(days: settings.rollingHorizonDays));
    final occurrences = (await repository.occurrencesBetween(from, until))
        .where((occurrence) => occurrence.scheduleItemId == itemId)
        .take(60)
        .toList(growable: false);
    final reminders =
        await (database.select(database.scheduleReminders)..where(
              (row) =>
                  row.scheduleItemId.equals(itemId) &
                  row.isEnabled.equals(true),
            ))
            .get();
    final desiredIds = <String>{};
    var scheduledCount = 0;
    final skipped = <String>[];
    final failed = <String>[];
    for (final reminder in reminders) {
      for (final occurrence in occurrences) {
        final anchor = _anchorFor(item: item, occurrence: occurrence);
        if (anchor == null) continue;
        final scheduledAt =
            item.allDay || (item.itemType == 'task' && item.dueAtUtc == null)
            ? reminder.reminderType == 'day_before'
                  ? anchor.subtract(const Duration(days: 1))
                  : anchor
            : anchor.subtract(Duration(minutes: reminder.offsetMinutes));
        if (!scheduledAt.isAfter(from)) {
          skipped.add(reminder.reminderType);
          continue;
        }
        final occurrenceId = '${reminder.id}:${occurrence.occurrenceKey}';
        desiredIds.add(occurrenceId);
        final platformId = await _notificationIdFor(occurrenceId);
        final now = DateTime.now().toUtc();
        await database
            .into(database.scheduleNotificationOccurrences)
            .insertOnConflictUpdate(
              ScheduleNotificationOccurrencesCompanion.insert(
                id: occurrenceId,
                reminderId: reminder.id,
                scheduleItemId: itemId,
                occurrenceKey: occurrence.occurrenceKey,
                platformNotificationId: platformId,
                scheduledAtUtc: scheduledAt,
                syncStatus: const Value('pending'),
                createdAt: now,
                updatedAt: now,
              ),
            );
        try {
          await notifications.schedule(
            id: platformId,
            title: item.title,
            body: item.itemType == 'task'
                ? 'Task menunggu untuk diselesaikan.'
                : 'Event akan segera dimulai.',
            scheduledAtUtc: scheduledAt,
            payload: jsonEncode({'schedule_item_id': itemId}),
            isTask: item.itemType == 'task',
          );
          await _mark(occurrenceId, 'scheduled');
          scheduledCount++;
        } on Object catch (error) {
          await _mark(occurrenceId, 'failed', error.runtimeType.toString());
          failed.add(reminder.reminderType);
        }
      }
    }
    final stale = await (database.select(
      database.scheduleNotificationOccurrences,
    )..where((row) => row.scheduleItemId.equals(itemId))).get();
    for (final row in stale.where((row) => !desiredIds.contains(row.id))) {
      await notifications.cancel(row.platformNotificationId);
      await (database.delete(
        database.scheduleNotificationOccurrences,
      )..where((entry) => entry.id.equals(row.id))).go();
    }
    return ReminderReconciliationResult(
      scheduledCount: scheduledCount,
      skippedReminderTypes: skipped.toSet().toList(growable: false),
      failedReminderTypes: failed.toSet().toList(growable: false),
    );
  }

  Future<void> cancelItem(String itemId) async {
    final rows = await (database.select(
      database.scheduleNotificationOccurrences,
    )..where((row) => row.scheduleItemId.equals(itemId))).get();
    for (final row in rows) {
      await notifications.cancel(row.platformNotificationId);
    }
    await (database.delete(
      database.scheduleNotificationOccurrences,
    )..where((row) => row.scheduleItemId.equals(itemId))).go();
  }

  Future<void> snooze(String itemId) async {
    final item = await repository.findById(itemId);
    if (item == null) return;
    final at = DateTime.now().toUtc().add(const Duration(minutes: 10));
    await notifications.schedule(
      id: _stableNotificationId('snooze:$itemId:${at.toIso8601String()}'),
      title: item.title,
      body: 'Reminder ditunda 10 menit.',
      scheduledAtUtc: at,
      payload: jsonEncode({'schedule_item_id': itemId}),
      isTask: item.itemType == 'task',
    );
  }

  Future<void> _mark(String id, String status, [String? error]) async {
    await (database.update(
      database.scheduleNotificationOccurrences,
    )..where((row) => row.id.equals(id))).write(
      ScheduleNotificationOccurrencesCompanion(
        syncStatus: Value(status),
        lastError: Value(error),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  int _stableNotificationId(String input) {
    var hash = 0x811c9dc5;
    for (final unit in input.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0x7fffffff;
    }
    return hash == 7001 ? _stableNotificationId('$input:${_uuid.v4()}') : hash;
  }

  DateTime? _anchorFor({
    required ScheduleItem item,
    required ScheduleOccurrence occurrence,
  }) {
    final instant = occurrence.startAtUtc ?? occurrence.dueAtUtc;
    if (instant != null) return instant;
    final localDate = DateTime.tryParse(occurrence.localDate ?? '');
    if (localDate == null) return null;
    tz_data.initializeTimeZones();
    tz.Location location;
    try {
      location = tz.getLocation(item.timezone);
    } on Object {
      location = tz.UTC;
    }
    return tz.TZDateTime(
      location,
      localDate.year,
      localDate.month,
      localDate.day,
      9,
    ).toUtc();
  }

  Future<int> _notificationIdFor(String occurrenceId) async {
    final existing = await (database.select(
      database.scheduleNotificationOccurrences,
    )..where((row) => row.id.equals(occurrenceId))).getSingleOrNull();
    if (existing != null) return existing.platformNotificationId;
    var attempt = 0;
    while (true) {
      final candidate = _stableNotificationId(
        attempt == 0 ? occurrenceId : '$occurrenceId:$attempt',
      );
      final collision =
          await (database.select(database.scheduleNotificationOccurrences)
                ..where((row) => row.platformNotificationId.equals(candidate)))
              .getSingleOrNull();
      if (collision == null) return candidate;
      attempt++;
    }
  }
}

class ReminderReconciliationResult {
  const ReminderReconciliationResult({
    this.scheduledCount = 0,
    this.skippedReminderTypes = const [],
    this.failedReminderTypes = const [],
  });

  final int scheduledCount;
  final List<String> skippedReminderTypes;
  final List<String> failedReminderTypes;

  bool get hasIssues =>
      skippedReminderTypes.isNotEmpty || failedReminderTypes.isNotEmpty;
}
