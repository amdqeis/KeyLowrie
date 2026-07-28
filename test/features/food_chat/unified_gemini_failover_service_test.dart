import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/gemini_failover_service.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';

import '../../helpers/fakes.dart';

void main() {
  final now = DateTime.utc(2026, 7, 22, 12);

  group('GeminiFailoverService.parseChat', () {
    test('multiple expense sukses dan preview disimpan', () async {
      final client = FakeGeminiClient([_success()]);
      final pending = FakePendingRequestRepository();
      final service = await _service(
        client: client,
        keyPool: FakeKeyPoolRepository(keys: [_key('A', 1)], activeId: 'A'),
        pending: pending,
        now: now,
      );

      final result = await service.parseChat(
        'makan 150 ribu dan belanja 1,5 juta',
        context: _context(),
      );

      expect(result, isA<ParseChatSuccess>());
      final success = result as ParseChatSuccess;
      expect(success.draft.financialItems.map((item) => item.amount), [
        150000,
        1500000,
      ]);
      expect(pending.pending.single.input, contains('150 ribu'));
      expect(pending.unifiedPreviews['request-chat'], same(success.draft));
      expect(client.calls.single.context?.mode, ChatInputMode.automatic);
    });

    test('mode eksplisit diteruskan dan domain terkunci', () async {
      final client = FakeGeminiClient([
        _success(domain: 'income'),
        _success(domain: 'income'),
      ]);
      final service = await _service(
        client: client,
        keyPool: FakeKeyPoolRepository(keys: [_key('A', 1)], activeId: 'A'),
        pending: FakePendingRequestRepository(),
        now: now,
      );
      final context = _context(mode: ChatInputMode.expense);

      final result = await service.parseChat('gaji', context: context);

      expect(result, isA<ParseChatRequestFailure>());
      expect(client.calls, hasLength(2));
      expect(
        client.calls.every((call) => identical(call.context, context)),
        isTrue,
      );
      expect(client.calls.map((call) => call.repairAttempt), [false, true]);
    });

    test('key rate limited dirotasi lalu key berikutnya sukses', () async {
      final client = FakeGeminiClient([
        _failure(GeminiFailureCategory.rateLimit),
        _success(),
      ]);
      final keyPool = FakeKeyPoolRepository(
        keys: [_key('A', 1), _key('B', 2)],
        activeId: 'A',
      );
      final service = await _service(
        client: client,
        keyPool: keyPool,
        pending: FakePendingRequestRepository(),
        now: now,
      );

      final result = await service.parseChat(
        'catat belanja',
        context: _context(),
      );

      expect(result, isA<ParseChatSuccess>());
      expect((result as ParseChatSuccess).keyId, 'B');
      expect(client.calls.map((call) => call.secret), ['secret-A', 'secret-B']);
      expect(keyPool.failures.single.health, ApiKeyHealth.limited);
      expect(keyPool.activeId, 'B');
    });

    test('seluruh key gagal dan input tetap tersimpan', () async {
      final client = FakeGeminiClient([
        _failure(GeminiFailureCategory.invalidKey),
        _failure(GeminiFailureCategory.permission),
      ]);
      final pending = FakePendingRequestRepository();
      final service = await _service(
        client: client,
        keyPool: FakeKeyPoolRepository(
          keys: [_key('A', 1), _key('B', 2)],
          activeId: 'A',
        ),
        pending: pending,
        now: now,
      );

      final result = await service.parseChat(
        'input jangan hilang',
        context: _context(),
      );

      expect(result, isA<ParseChatAllKeysFailed>());
      expect(result.inputPreserved, isTrue);
      expect((result as ParseChatAllKeysFailed).attemptedKeys, ['A', 'B']);
      expect(pending.pending.single.input, 'input jangan hilang');
    });

    test('JSON invalid hanya diperbaiki sekali lalu gagal aman', () async {
      final malformed = GeminiCallSuccess(
        data: const {'detected_domain': 'expense'},
        latency: const Duration(milliseconds: 1),
      );
      final client = FakeGeminiClient([malformed, malformed]);
      final pending = FakePendingRequestRepository();
      final service = await _service(
        client: client,
        keyPool: FakeKeyPoolRepository(keys: [_key('A', 1)], activeId: 'A'),
        pending: pending,
        now: now,
      );

      final result = await service.parseChat('kopi', context: _context());

      expect(result, isA<ParseChatRequestFailure>());
      expect(result.inputPreserved, isTrue);
      expect(client.calls.map((call) => call.repairAttempt), [false, true]);
      expect(
        pending.failures['request-chat'],
        GeminiFailureCategory.schemaMismatch,
      );
    });

    test('offline dan cancellation berhenti sebelum akses client', () async {
      final offlineClient = FakeGeminiClient([]);
      final offline = await _service(
        client: offlineClient,
        keyPool: FakeKeyPoolRepository(keys: [_key('A', 1)], activeId: 'A'),
        pending: FakePendingRequestRepository(),
        now: now,
        online: false,
      );
      final offlineResult = await offline.parseChat(
        'kopi',
        context: _context(),
      );
      expect(offlineResult, isA<ParseChatOffline>());
      expect(offlineClient.calls, isEmpty);

      final cancelledClient = FakeGeminiClient([]);
      final cancelled = await _service(
        client: cancelledClient,
        keyPool: FakeKeyPoolRepository(keys: [_key('A', 1)], activeId: 'A'),
        pending: FakePendingRequestRepository(),
        now: now,
      );
      final cancellation = RequestCancellation()..cancel();
      final cancelledResult = await cancelled.parseChat(
        'kopi',
        context: _context(),
        cancellation: cancellation,
      );
      expect(cancelledResult, isA<ParseChatCancelled>());
      expect(cancelledClient.calls, isEmpty);
    });
  });
}

ChatParseContext _context({ChatInputMode mode = ChatInputMode.automatic}) =>
    ChatParseContext(
      mode: mode,
      localDate: DateTime(2026, 7, 22),
      timezone: 'Asia/Jakarta',
      currencyCode: 'IDR',
      activeCategories: const [
        GeminiCategoryContext(
          id: 'expense-food',
          name: 'Makan',
          type: ChatDomain.expense,
        ),
        GeminiCategoryContext(
          id: 'expense-other',
          name: 'Lainnya',
          type: ChatDomain.expense,
        ),
        GeminiCategoryContext(
          id: 'income-other',
          name: 'Lainnya',
          type: ChatDomain.income,
        ),
      ],
    );

ApiKeyCandidate _key(String id, int priority) => ApiKeyCandidate(
  id: id,
  secureRef: 'ref-$id',
  priorityOrder: priority,
  isEnabled: true,
  health: ApiKeyHealth.healthy,
);

GeminiCallSuccess _success({String domain = 'expense'}) => GeminiCallSuccess(
  data: {
    'detected_domain': domain,
    'confidence': 0.95,
    'requires_clarification': false,
    'clarification_question': null,
    'items': [
      {
        'name': domain == 'income' ? 'Gaji' : 'Makan',
        'amount': 150000,
        'currency': 'IDR',
        'transaction_date': '2026-07-22',
        'category': 'Lainnya',
      },
      if (domain == 'expense')
        {
          'name': 'Belanja',
          'amount': 1500000,
          'currency': 'IDR',
          'transaction_date': '2026-07-22',
          'category': 'Lainnya',
        },
    ],
    'nutrition_summary': null,
  },
  latency: const Duration(milliseconds: 5),
);

GeminiCallFailure _failure(GeminiFailureCategory category) => GeminiCallFailure(
  failure: GeminiFailure(category: category),
  latency: const Duration(milliseconds: 2),
);

Future<GeminiFailoverService> _service({
  required FakeGeminiClient client,
  required FakeKeyPoolRepository keyPool,
  required FakePendingRequestRepository pending,
  required DateTime now,
  bool online = true,
}) async {
  final secrets = InMemorySecretStore();
  for (final key in keyPool.keys) {
    await secrets.write(key.secureRef, 'secret-${key.id}');
  }
  return GeminiFailoverService(
    client: client,
    keyPool: keyPool,
    pendingRequests: pending,
    secretStore: secrets,
    networkStatus: StaticNetworkStatus(online),
    clock: FixedClock(now),
    createRequestId: () => 'request-chat',
    delay: (_) async {},
    jitter: () => Duration.zero,
  );
}
