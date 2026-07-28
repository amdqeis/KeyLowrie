import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/gemini_failover_service.dart';

import '../../helpers/fakes.dart';

void main() {
  final now = DateTime.utc(2026, 7, 21, 12);

  group('GeminiFailoverService', () {
    test('UF-AC-03: A 429 lalu B sukses dan menjadi Active Key', () async {
      final client = FakeGeminiClient([
        _failure(GeminiFailureCategory.rateLimit, status: 429),
        _success(),
      ]);
      final keyPool = FakeKeyPoolRepository(
        keys: [_key('A', 1), _key('B', 2)],
        activeId: 'A',
      );
      final pending = FakePendingRequestRepository();
      final service = await _service(
        client: client,
        keyPool: keyPool,
        pending: pending,
        now: now,
      );

      final result = await service.parseFood('nasi goreng');

      expect(result, isA<ParseFoodSuccess>());
      expect((result as ParseFoodSuccess).keyId, 'B');
      expect(keyPool.activeId, 'B');
      expect(client.calls.map((call) => call.secret), ['secret-A', 'secret-B']);
      expect(keyPool.failures.single.health, ApiKeyHealth.limited);
      expect(
        keyPool.failures.single.cooldownUntil,
        now.add(ProviderConfig.rateLimitCooldown),
      );
      expect(keyPool.usage.map((event) => event.success), [false, true]);
      expect(pending.pending.single.input, 'nasi goreng');
      expect(pending.previews, contains('request-1'));
    });

    test(
      'UF-AC-04: seluruh key gagal dan input serta aksi dipertahankan',
      () async {
        final client = FakeGeminiClient([
          _failure(GeminiFailureCategory.invalidKey, status: 401),
          _failure(GeminiFailureCategory.permission, status: 403),
        ]);
        final keyPool = FakeKeyPoolRepository(
          keys: [_key('A', 1), _key('B', 2)],
          activeId: 'A',
        );
        final pending = FakePendingRequestRepository();
        final service = await _service(
          client: client,
          keyPool: keyPool,
          pending: pending,
          now: now,
        );

        final result = await service.parseFood('sate ayam');

        expect(result, isA<AllKeysFailed>());
        final allFailed = result as AllKeysFailed;
        expect(allFailed.inputPreserved, isTrue);
        expect(allFailed.attemptedKeys, ['A', 'B']);
        expect(allFailed.actions, AllKeysFailedAction.values);
        expect(pending.pending.single.input, 'sate ayam');
        expect(keyPool.failures.map((failure) => failure.health), [
          ApiKeyHealth.invalid,
          ApiKeyHealth.blocked,
        ]);
      },
    );

    test(
      'UF-AC-06: offline berhenti sebelum membaca/menghabiskan pool',
      () async {
        final client = FakeGeminiClient([]);
        final keyPool = FakeKeyPoolRepository(
          keys: [_key('A', 1), _key('B', 2)],
          activeId: 'A',
        );
        final pending = FakePendingRequestRepository();
        final service = await _service(
          client: client,
          keyPool: keyPool,
          pending: pending,
          now: now,
          online: false,
        );

        final result = await service.parseFood('bakso');

        expect(result, isA<OfflineFailure>());
        expect(result.inputPreserved, isTrue);
        expect(client.calls, isEmpty);
        expect(keyPool.failures, isEmpty);
        expect(keyPool.usage, isEmpty);
        expect(pending.failures['request-1'], GeminiFailureCategory.offline);
      },
    );

    test('retry transient satu kali pada key yang sama lalu lanjut', () async {
      final client = FakeGeminiClient([
        _failure(GeminiFailureCategory.timeout),
        _failure(GeminiFailureCategory.transientServer, status: 503),
        _success(),
      ]);
      final keyPool = FakeKeyPoolRepository(
        keys: [_key('A', 1), _key('B', 2)],
        activeId: 'A',
      );
      final delays = <Duration>[];
      final service = await _service(
        client: client,
        keyPool: keyPool,
        pending: FakePendingRequestRepository(),
        now: now,
        delay: (duration) async => delays.add(duration),
      );

      final result = await service.parseFood('soto ayam');

      expect(result, isA<ParseFoodSuccess>());
      expect(client.calls.map((call) => call.secret), [
        'secret-A',
        'secret-A',
        'secret-B',
      ]);
      expect(delays, [ProviderConfig.transientRetryBackoff]);
      expect(keyPool.failures.single.health, ApiKeyHealth.transientError);
    });

    test('invalid request dan safety block tidak merotasi pool', () async {
      for (final category in [
        GeminiFailureCategory.requestInvalid,
        GeminiFailureCategory.modelNotFound,
        GeminiFailureCategory.safetyBlock,
      ]) {
        final client = FakeGeminiClient([_failure(category)]);
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

        final result = await service.parseFood('input');

        expect(client.calls, hasLength(1));
        if (category == GeminiFailureCategory.requestInvalid ||
            category == GeminiFailureCategory.modelNotFound) {
          expect(result, isA<RequestFailure>());
        } else {
          expect(result, isA<ContentNeedsRevision>());
        }
        expect(keyPool.failures, isEmpty);
      }
    });

    test(
      'secret unavailable dan key cooldown dilewati tanpa client call',
      () async {
        final client = FakeGeminiClient([_success()]);
        final keyPool = FakeKeyPoolRepository(
          keys: [
            _key('A', 1),
            _key('C', 2, cooldownUntil: now.add(const Duration(minutes: 1))),
            _key('B', 3),
          ],
          activeId: 'A',
        );
        final pending = FakePendingRequestRepository();
        final secrets = InMemorySecretStore();
        await secrets.write('ref-B', 'secret-B');
        final service = GeminiFailoverService(
          client: client,
          keyPool: keyPool,
          pendingRequests: pending,
          secretStore: secrets,
          networkStatus: const StaticNetworkStatus(true),
          clock: FixedClock(now),
          createRequestId: () => 'request-1',
          jitter: () => Duration.zero,
        );

        final result = await service.parseFood('gado-gado');

        expect(result, isA<ParseFoodSuccess>());
        expect(client.calls.single.secret, 'secret-B');
        expect(keyPool.failures.single.health, ApiKeyHealth.secretUnavailable);
        expect((result as ParseFoodSuccess).keyId, 'B');
      },
    );

    test('sticky order dimulai dari Active Key dan wrap satu kali', () async {
      final client = FakeGeminiClient([
        _failure(GeminiFailureCategory.invalidKey),
        _success(),
      ]);
      final keyPool = FakeKeyPoolRepository(
        keys: [_key('A', 1), _key('B', 2), _key('C', 3)],
        activeId: 'C',
      );
      final service = await _service(
        client: client,
        keyPool: keyPool,
        pending: FakePendingRequestRepository(),
        now: now,
      );

      final result = await service.parseFood('rendang');

      expect(result, isA<ParseFoodSuccess>());
      expect(client.calls.map((call) => call.secret), ['secret-C', 'secret-A']);
      expect(keyPool.activeId, 'A');
    });

    test(
      'schema mismatch melakukan satu repair lalu mempertahankan input',
      () async {
        final malformed = GeminiCallSuccess(
          data: const {'items': <Object>[]},
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

        final result = await service.parseFood('ketoprak');

        expect(result, isA<RequestFailure>());
        expect(result.inputPreserved, isTrue);
        expect(client.calls.map((call) => call.repairAttempt), [false, true]);
        expect(
          pending.failures['request-1'],
          GeminiFailureCategory.schemaMismatch,
        );
      },
    );

    test('cancel sebelum network tidak membaca atau merotasi key', () async {
      final client = FakeGeminiClient([_success()]);
      final keyPool = FakeKeyPoolRepository(
        keys: [_key('A', 1)],
        activeId: 'A',
      );
      final pending = FakePendingRequestRepository();
      final cancellation = RequestCancellation()..cancel();
      final service = await _service(
        client: client,
        keyPool: keyPool,
        pending: pending,
        now: now,
      );

      final result = await service.parseFood(
        'input dipertahankan',
        cancellation: cancellation,
      );

      expect(result, isA<CancelledFailure>());
      expect(client.calls, isEmpty);
      expect(keyPool.failures, isEmpty);
      expect(pending.failures['request-1'], GeminiFailureCategory.cancelled);
    });
  });
}

ApiKeyCandidate _key(String id, int priority, {DateTime? cooldownUntil}) =>
    ApiKeyCandidate(
      id: id,
      secureRef: 'ref-$id',
      priorityOrder: priority,
      isEnabled: true,
      health: cooldownUntil == null
          ? ApiKeyHealth.healthy
          : ApiKeyHealth.limited,
      cooldownUntil: cooldownUntil,
    );

GeminiCallSuccess _success() => GeminiCallSuccess(
  data: validFoodResponse(),
  latency: const Duration(milliseconds: 10),
);

GeminiCallFailure _failure(GeminiFailureCategory category, {int? status}) =>
    GeminiCallFailure(
      failure: GeminiFailure(category: category, httpStatus: status),
      latency: const Duration(milliseconds: 5),
    );

Future<GeminiFailoverService> _service({
  required FakeGeminiClient client,
  required FakeKeyPoolRepository keyPool,
  required FakePendingRequestRepository pending,
  required DateTime now,
  bool online = true,
  Delay? delay,
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
    createRequestId: () => 'request-1',
    delay: delay ?? (duration) async {},
    jitter: () => Duration.zero,
  );
}
