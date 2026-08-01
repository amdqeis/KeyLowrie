import 'dart:math' as math;

import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:keyspace/features/food_chat/domain/food_response_parser.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';

class UnifiedChatResponseException implements Exception {
  const UnifiedChatResponseException(this.reason);

  final String reason;

  @override
  String toString() => 'UnifiedChatResponseException($reason)';
}

class UnifiedChatResponseParser {
  const UnifiedChatResponseParser({
    FoodResponseParser foodParser = const FoodResponseParser(),
  }) : _foodParser = foodParser;

  final FoodResponseParser _foodParser;

  UnifiedChatDraft parse(
    Map<String, dynamic> json, {
    required ChatParseContext context,
  }) {
    final domain = _domain(json['detected_domain']);
    _validateModeLock(context.mode, domain);
    final confidence = _number(json['confidence'], 'confidence');
    if (confidence < 0 || confidence > 1) {
      throw const UnifiedChatResponseException('confidence_out_of_range');
    }
    final requiresClarification = json['requires_clarification'];
    if (requiresClarification is! bool) {
      throw const UnifiedChatResponseException(
        'requires_clarification_invalid',
      );
    }
    final question = _optionalText(json['clarification_question']);
    if (requiresClarification && question == null) {
      throw const UnifiedChatResponseException(
        'clarification_question_missing',
      );
    }
    final rawItems = json['items'];
    if (rawItems is! List) {
      throw const UnifiedChatResponseException('items_invalid');
    }

    if (requiresClarification || domain == ChatDomain.unknown) {
      if (domain == ChatDomain.unknown && !requiresClarification) {
        throw const UnifiedChatResponseException(
          'unknown_requires_clarification',
        );
      }
      return UnifiedChatDraft(
        detectedDomain: domain,
        confidence: confidence,
        requiresClarification: requiresClarification,
        clarificationQuestion: question,
        financialItems: const [],
      );
    }

    switch (domain) {
      case ChatDomain.nutrition:
        final summary = json['nutrition_summary'];
        if (summary is! Map<String, dynamic>) {
          throw const UnifiedChatResponseException('nutrition_summary_invalid');
        }
        try {
          final nutrition = _foodParser.parse({
            'items': rawItems,
            'summary': summary,
          });
          return UnifiedChatDraft(
            detectedDomain: domain,
            confidence: confidence,
            requiresClarification: false,
            clarificationQuestion: question,
            financialItems: const [],
            nutrition: nutrition,
          );
        } on FoodResponseException catch (error) {
          throw UnifiedChatResponseException('nutrition_${error.reason}');
        }
      case ChatDomain.expense:
      case ChatDomain.income:
        if (rawItems.isEmpty) {
          throw const UnifiedChatResponseException('financial_items_empty');
        }
        final items = rawItems
            .map((item) => _financialItem(item, domain, context))
            .toList(growable: false);
        return UnifiedChatDraft(
          detectedDomain: domain,
          confidence: confidence,
          requiresClarification: false,
          clarificationQuestion: question,
          financialItems: items,
        );
      case ChatDomain.schedule:
        final schedule = json['schedule'];
        if (schedule is! Map<String, dynamic>) {
          throw const UnifiedChatResponseException('schedule_invalid');
        }
        return UnifiedChatDraft(
          detectedDomain: domain,
          confidence: confidence,
          requiresClarification: false,
          clarificationQuestion: question,
          financialItems: const [],
          schedule: _schedule(schedule, context, confidence),
        );
      case ChatDomain.unknown:
        throw const UnifiedChatResponseException('unknown_invalid');
    }
  }

  ScheduleDraft _schedule(
    Map<String, dynamic> value,
    ChatParseContext context,
    double confidence,
  ) {
    final intent = _requiredText(value['intent'], 'schedule_intent');
    final type = switch (intent) {
      'create_event' => ScheduleItemType.event,
      'create_task' => ScheduleItemType.task,
      _ => throw const UnifiedChatResponseException('schedule_intent_invalid'),
    };
    final title = _requiredText(value['title'], 'schedule_title');
    final allDay = value['all_day'];
    if (allDay is! bool) {
      throw const UnifiedChatResponseException('schedule_all_day_invalid');
    }
    final start = _optionalDateTime(value['start_at'], 'schedule_start_at');
    var end = _optionalDateTime(value['end_at'], 'schedule_end_at');
    final due = _optionalDateTime(value['due_at'], 'schedule_due_at');
    final assumptions = _stringList(value['assumptions'], 'assumptions');
    if (type == ScheduleItemType.event && !allDay && start == null) {
      throw const UnifiedChatResponseException('schedule_start_missing');
    }
    final normalizedAssumptions = [...assumptions];
    if (type == ScheduleItemType.event &&
        !allDay &&
        start != null &&
        end == null) {
      end = start.add(Duration(minutes: context.defaultEventDurationMinutes));
      normalizedAssumptions.add(
        'Durasi default ${context.defaultEventDurationMinutes} menit digunakan.',
      );
    }
    if (start != null && end != null && !end.isAfter(start)) {
      throw const UnifiedChatResponseException('schedule_end_invalid');
    }
    final requestedCategory = _requiredText(
      value['category'],
      'schedule_category',
    );
    final category = _resolveScheduleCategory(requestedCategory, context);
    final recurrence = value['recurrence'];
    if (recurrence is! Map<String, dynamic>) {
      throw const UnifiedChatResponseException('recurrence_invalid');
    }
    final recurrenceType = switch (recurrence['type']) {
      'none' => ScheduleRecurrenceType.none,
      'daily' => ScheduleRecurrenceType.daily,
      'weekly' => ScheduleRecurrenceType.weekly,
      'monthly' => ScheduleRecurrenceType.monthly,
      _ => throw const UnifiedChatResponseException('recurrence_type_invalid'),
    };
    final interval = recurrence['interval'];
    if (interval is! int || interval < 1) {
      throw const UnifiedChatResponseException('recurrence_interval_invalid');
    }
    final weekdays = (recurrence['weekdays'] as List? ?? const [])
        .whereType<num>()
        .map((day) => day.toInt())
        .toList(growable: false);
    if (weekdays.any((day) => day < 1 || day > 7)) {
      throw const UnifiedChatResponseException('recurrence_weekday_invalid');
    }
    final reminderValues = value['reminders'];
    if (reminderValues is! List) {
      throw const UnifiedChatResponseException('reminders_invalid');
    }
    final reminderOffsets = reminderValues
        .map((entry) {
          if (entry is! Map<String, dynamic> ||
              entry['offset_minutes'] is! int ||
              !const {15, 30, 1440}.contains(entry['offset_minutes'])) {
            throw const UnifiedChatResponseException('reminder_offset_invalid');
          }
          return entry['offset_minutes'] as int;
        })
        .toList(growable: false);
    final priority = switch (value['priority']) {
      'low' => SchedulePriority.low,
      'medium' => SchedulePriority.medium,
      'high' => SchedulePriority.high,
      _ => throw const UnifiedChatResponseException('priority_invalid'),
    };
    final dateSource = start ?? due;
    final localDateSource = dateSource?.toLocal();
    final localDate = localDateSource == null
        ? null
        : '${localDateSource.year.toString().padLeft(4, '0')}-'
              '${localDateSource.month.toString().padLeft(2, '0')}-'
              '${localDateSource.day.toString().padLeft(2, '0')}';
    return ScheduleDraft(
      itemType: type,
      title: title,
      description: _optionalText(value['description']),
      startAtUtc: start?.toUtc(),
      endAtUtc: end?.toUtc(),
      dueAtUtc: due?.toUtc(),
      localStartDate: type == ScheduleItemType.event ? localDate : null,
      dueDateLocal: type == ScheduleItemType.task ? localDate : null,
      allDay: allDay,
      categoryId: category.$1,
      categoryName: category.$2,
      priority: priority,
      timezone: context.timezone,
      recurrence: ScheduleRecurrence(
        type: recurrenceType,
        interval: interval,
        weekdays: weekdays,
        endDateLocal: _optionalDateTime(
          recurrence['end_at'],
          'recurrence_end_at',
        ),
      ),
      reminderOffsets: reminderOffsets,
      assumptions: normalizedAssumptions,
      confidence: confidence,
    );
  }

  (String, String) _resolveScheduleCategory(
    String requested,
    ChatParseContext context,
  ) {
    final normalized = requested.trim().toLowerCase();
    final match = context.scheduleCategories
        .where((name) => name.trim().toLowerCase() == normalized)
        .firstOrNull;
    final selected =
        match ??
        context.scheduleCategories
            .where((name) => name.trim().toLowerCase() == 'lainnya')
            .firstOrNull;
    if (selected == null) {
      throw const UnifiedChatResponseException(
        'schedule_fallback_category_missing',
      );
    }
    return ('schedule-${selected.toLowerCase()}', selected);
  }

  DateTime? _optionalDateTime(Object? value, String field) {
    if (value == null) return null;
    if (value is! String) {
      throw UnifiedChatResponseException('${field}_invalid');
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null) throw UnifiedChatResponseException('${field}_invalid');
    return parsed;
  }

  List<String> _stringList(Object? value, String field) {
    if (value is! List || value.any((entry) => entry is! String)) {
      throw UnifiedChatResponseException('${field}_invalid');
    }
    return value.cast<String>().map((entry) => entry.trim()).toList();
  }

  ParsedFinancialItem _financialItem(
    Object? value,
    ChatDomain domain,
    ChatParseContext context,
  ) {
    if (value is! Map<String, dynamic>) {
      throw const UnifiedChatResponseException('financial_item_invalid');
    }
    if (value.containsKey('is_reimburse') || value.containsKey('isReimburse')) {
      throw const UnifiedChatResponseException('reimburse_provider_forbidden');
    }
    final name = _requiredText(value['name'], 'item_name');
    final amount = value['amount'];
    if (amount is! int || amount <= 0) {
      throw const UnifiedChatResponseException('amount_invalid');
    }
    // Currency bersifat opsional dari respons Gemini; default ke context.
    // Bug sebelumnya: kondisi || selalu true — diperbaiki menjadi &&.
    final rawCurrency =
        (_optionalText(value['currency'])?.toUpperCase()) ??
        context.currencyCode.toUpperCase();
    if (rawCurrency != context.currencyCode.toUpperCase() &&
        rawCurrency != 'IDR') {
      throw const UnifiedChatResponseException('currency_mismatch');
    }
    final currency = rawCurrency;
    final transactionDate = _parseDate(
      _requiredText(value['transaction_date'], 'transaction_date'),
    );
    final requestedCategory = _requiredText(value['category'], 'category');
    final category = _resolveCategory(requestedCategory, domain, context);
    return ParsedFinancialItem(
      name: name,
      amount: amount,
      currencyCode: currency,
      transactionDate: transactionDate,
      categoryId: category.id,
      categoryName: category.name,
    );
  }

  GeminiCategoryContext _resolveCategory(
    String requested,
    ChatDomain domain,
    ChatParseContext context,
  ) {
    final candidates = context.activeCategories.where(
      (category) => category.type == domain,
    );
    final normalized = requested.trim().toLowerCase();
    for (final category in candidates) {
      if (category.name.trim().toLowerCase() == normalized) return category;
    }
    for (final category in candidates) {
      if (category.name.trim().toLowerCase() == 'lainnya') return category;
    }
    throw const UnifiedChatResponseException('fallback_category_missing');
  }

  DateTime _parseDate(String value) {
    final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(value);
    if (match == null) {
      throw const UnifiedChatResponseException('transaction_date_invalid');
    }
    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final day = int.parse(match.group(3)!);
    final parsed = DateTime(year, month, day);
    if (parsed.year != year || parsed.month != month || parsed.day != day) {
      throw const UnifiedChatResponseException('transaction_date_invalid');
    }
    return parsed;
  }

  void _validateModeLock(ChatInputMode mode, ChatDomain domain) {
    final expected = switch (mode) {
      ChatInputMode.automatic => null,
      ChatInputMode.nutrition => ChatDomain.nutrition,
      ChatInputMode.expense => ChatDomain.expense,
      ChatInputMode.income => ChatDomain.income,
      ChatInputMode.schedule => ChatDomain.schedule,
    };
    if (expected != null && domain != expected) {
      throw const UnifiedChatResponseException('explicit_mode_mismatch');
    }
  }

  ChatDomain _domain(Object? value) => switch (value) {
    'nutrition' => ChatDomain.nutrition,
    'expense' => ChatDomain.expense,
    'income' => ChatDomain.income,
    'schedule' => ChatDomain.schedule,
    'unknown' => ChatDomain.unknown,
    _ => throw const UnifiedChatResponseException('detected_domain_invalid'),
  };

  String _requiredText(Object? value, String field) {
    final text = _optionalText(value);
    if (text == null) throw UnifiedChatResponseException('${field}_invalid');
    return text;
  }

  String? _optionalText(Object? value) {
    if (value == null) return null;
    if (value is! String) {
      throw const UnifiedChatResponseException('text_invalid');
    }
    final sanitized = value
        .replaceAll(RegExp(r'[\u0000-\u0008\u000B\u000C\u000E-\u001F]'), '')
        .trim();
    if (sanitized.isEmpty) return null;
    return sanitized.substring(0, math.min(sanitized.length, 500));
  }

  double _number(Object? value, String field) {
    if (value is! num || !value.isFinite) {
      throw UnifiedChatResponseException('${field}_invalid');
    }
    return value.toDouble();
  }
}
