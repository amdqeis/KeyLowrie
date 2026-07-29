import 'dart:convert';

enum ScheduleItemType { event, task }

enum SchedulePriority { low, medium, high }

enum ScheduleStatus { pending, completed, cancelled }

enum ScheduleRecurrenceType { none, daily, weekly, monthly }

class ScheduleRecurrence {
  const ScheduleRecurrence({
    this.type = ScheduleRecurrenceType.none,
    this.interval = 1,
    this.weekdays = const [],
    this.endDateLocal,
  });

  final ScheduleRecurrenceType type;
  final int interval;
  final List<int> weekdays;
  final DateTime? endDateLocal;

  String? get weekdaysJson =>
      weekdays.isEmpty ? null : jsonEncode(weekdays.toSet().toList()..sort());

  static List<int> decodeWeekdays(String? value) {
    if (value == null || value.isEmpty) return const [];
    final decoded = jsonDecode(value);
    if (decoded is! List) return const [];
    return decoded.whereType<num>().map((value) => value.toInt()).toList();
  }
}

class ScheduleDraft {
  const ScheduleDraft({
    required this.itemType,
    required this.title,
    required this.categoryId,
    required this.categoryName,
    required this.timezone,
    this.description,
    this.startAtUtc,
    this.endAtUtc,
    this.dueAtUtc,
    this.localStartDate,
    this.localStartTime,
    this.localEndTime,
    this.dueDateLocal,
    this.allDay = false,
    this.priority = SchedulePriority.medium,
    this.recurrence = const ScheduleRecurrence(),
    this.reminderOffsets = const [15],
    this.assumptions = const [],
    this.requiresClarification = false,
    this.clarificationQuestion,
    this.confidence = 1,
  });

  final ScheduleItemType itemType;
  final String title;
  final String? description;
  final DateTime? startAtUtc;
  final DateTime? endAtUtc;
  final DateTime? dueAtUtc;
  final String? localStartDate;
  final String? localStartTime;
  final String? localEndTime;
  final String? dueDateLocal;
  final bool allDay;
  final String categoryId;
  final String categoryName;
  final SchedulePriority priority;
  final String timezone;
  final ScheduleRecurrence recurrence;
  final List<int> reminderOffsets;
  final List<String> assumptions;
  final bool requiresClarification;
  final String? clarificationQuestion;
  final double confidence;

  ScheduleDraft copyWith({
    ScheduleItemType? itemType,
    String? title,
    String? description,
    DateTime? startAtUtc,
    DateTime? endAtUtc,
    DateTime? dueAtUtc,
    String? localStartDate,
    String? localStartTime,
    String? localEndTime,
    String? dueDateLocal,
    bool? allDay,
    String? categoryId,
    String? categoryName,
    SchedulePriority? priority,
    String? timezone,
    ScheduleRecurrence? recurrence,
    List<int>? reminderOffsets,
    List<String>? assumptions,
  }) {
    return ScheduleDraft(
      itemType: itemType ?? this.itemType,
      title: title ?? this.title,
      description: description ?? this.description,
      startAtUtc: startAtUtc ?? this.startAtUtc,
      endAtUtc: endAtUtc ?? this.endAtUtc,
      dueAtUtc: dueAtUtc ?? this.dueAtUtc,
      localStartDate: localStartDate ?? this.localStartDate,
      localStartTime: localStartTime ?? this.localStartTime,
      localEndTime: localEndTime ?? this.localEndTime,
      dueDateLocal: dueDateLocal ?? this.dueDateLocal,
      allDay: allDay ?? this.allDay,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      priority: priority ?? this.priority,
      timezone: timezone ?? this.timezone,
      recurrence: recurrence ?? this.recurrence,
      reminderOffsets: reminderOffsets ?? this.reminderOffsets,
      assumptions: assumptions ?? this.assumptions,
      requiresClarification: requiresClarification,
      clarificationQuestion: clarificationQuestion,
      confidence: confidence,
    );
  }
}

class ScheduleOccurrence {
  const ScheduleOccurrence({
    required this.scheduleItemId,
    required this.occurrenceKey,
    required this.title,
    required this.itemType,
    required this.status,
    required this.allDay,
    required this.categoryId,
    required this.priority,
    this.startAtUtc,
    this.endAtUtc,
    this.dueAtUtc,
    this.localDate,
  });

  final String scheduleItemId;
  final String occurrenceKey;
  final String title;
  final ScheduleItemType itemType;
  final ScheduleStatus status;
  final bool allDay;
  final String categoryId;
  final SchedulePriority priority;
  final DateTime? startAtUtc;
  final DateTime? endAtUtc;
  final DateTime? dueAtUtc;
  final String? localDate;
}

class ScheduleConflict {
  const ScheduleConflict({
    required this.scheduleItemId,
    required this.title,
    required this.startAtUtc,
    required this.endAtUtc,
  });

  final String scheduleItemId;
  final String title;
  final DateTime startAtUtc;
  final DateTime endAtUtc;
}

class ScheduleValidationException implements Exception {
  const ScheduleValidationException(this.reason);
  final String reason;
}
