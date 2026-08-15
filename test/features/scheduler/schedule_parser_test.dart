import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_response_parser.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';

void main() {
  const parser = UnifiedChatResponseParser();
  final context = ChatParseContext(
    mode: ChatInputMode.schedule,
    localDate: DateTime(2026, 7, 28),
    timezone: 'Asia/Jakarta',
    currencyCode: 'IDR',
    activeCategories: const [],
    scheduleCategories: const ['Pekerjaan', 'Pribadi', 'Lainnya'],
    currentDateTime: DateTime(2026, 7, 28, 11, 30),
  );

  Map<String, dynamic> scheduleItem({
    String title = 'Meeting marketing',
    String startAt = '2026-07-29T11:00:00+07:00',
    String? endAt = '2026-07-29T12:00:00+07:00',
  }) {
    return {
      'intent': 'create_event',
      'title': title,
      'description': null,
      'start_at': startAt,
      'end_at': endAt,
      'due_at': null,
      'all_day': false,
      'category': 'Pekerjaan',
      'priority': 'medium',
      'recurrence': {
        'type': 'weekly',
        'interval': 1,
        'weekdays': [1, 3],
        'end_at': null,
      },
      'reminders': [
        {'offset_minutes': 15},
      ],
      'assumptions': <String>[],
    };
  }

  Map<String, dynamic> response({String? endAt = '2026-07-29T12:00:00+07:00'}) {
    return {
      'detected_domain': 'schedule',
      'confidence': 0.95,
      'requires_clarification': false,
      'clarification_question': null,
      'items': [],
      'schedules': [scheduleItem(endAt: endAt)],
    };
  }

  test('parses schedule structured output in UTC', () {
    final draft = parser.parse(response(), context: context).schedules.first;

    expect(draft.itemType, ScheduleItemType.event);
    expect(draft.startAtUtc, DateTime.utc(2026, 7, 29, 4));
    expect(draft.recurrence.weekdays, [1, 3]);
    expect(draft.categoryId, 'schedule-pekerjaan');
  });

  test(
    'localStartDate pakai timezone lokal, bukan UTC — regression timezone',
    () {
      // Gemini mengirim UTC datetime yang melewati tengah malam UTC
      // tetapi masih hari yang sama di WIB (UTC+7).
      // Sebelum fix, localDate dihitung dari UTC year/month/day (salah).
      // Setelah fix, localDate dihitung dari .toLocal() (benar).
      final resp = {
        'detected_domain': 'schedule',
        'confidence': 0.95,
        'requires_clarification': false,
        'clarification_question': null,
        'items': [],
        'schedules': [
          scheduleItem(
            startAt: '2026-07-29T00:30:00Z',
            endAt: '2026-07-29T02:00:00Z',
          ),
        ],
      };
      final draft = parser.parse(resp, context: context).schedules.first;

      final expectedStartUtc = DateTime.utc(2026, 7, 29, 0, 30);
      expect(draft.startAtUtc, expectedStartUtc);

      // localStartDate wajib cocok dengan hari lokal dari startAtUtc
      final localDay = expectedStartUtc.toLocal();
      final expectedLocalDate =
          '${localDay.year.toString().padLeft(4, '0')}-'
          '${localDay.month.toString().padLeft(2, '0')}-'
          '${localDay.day.toString().padLeft(2, '0')}';
      expect(
        draft.localStartDate,
        expectedLocalDate,
        reason: 'localStartDate harus diambil dari waktu lokal, bukan UTC',
      );
    },
  );

  test('adds explicit default-duration assumption', () {
    final draft = parser
        .parse(response(endAt: null), context: context)
        .schedules
        .first;

    expect(
      draft.endAtUtc!.difference(draft.startAtUtc!),
      const Duration(minutes: 60),
    );
    expect(draft.assumptions.single, contains('60 menit'));
  });

  test('parses multiple schedule events from one input', () {
    final multiResponse = {
      'detected_domain': 'schedule',
      'confidence': 0.95,
      'requires_clarification': false,
      'clarification_question': null,
      'items': [],
      'schedules': [
        scheduleItem(
          title: 'Mandi',
          startAt: '2026-07-29T05:00:00Z',
          endAt: '2026-07-29T05:30:00Z',
        ),
        scheduleItem(
          title: 'Makan',
          startAt: '2026-07-29T05:30:00Z',
          endAt: '2026-07-29T06:00:00Z',
        ),
      ],
    };
    final drafts = parser.parse(multiResponse, context: context).schedules;

    expect(drafts.length, 2);
    expect(drafts[0].title, 'Mandi');
    expect(drafts[1].title, 'Makan');
  });

  test('rejects event without determinable start', () {
    final item = scheduleItem();
    item['start_at'] = null; // override start to null
    final invalid = {
      'detected_domain': 'schedule',
      'confidence': 0.95,
      'requires_clarification': false,
      'clarification_question': null,
      'items': [],
      'schedules': [item],
    };
    expect(
      () => parser.parse(invalid, context: context),
      throwsA(
        isA<UnifiedChatResponseException>().having(
          (error) => error.reason,
          'reason',
          'schedule_start_missing',
        ),
      ),
    );
  });
}
