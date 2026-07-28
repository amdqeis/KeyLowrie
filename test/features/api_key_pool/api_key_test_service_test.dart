import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/api_key_pool/application/api_key_test_service.dart';
import 'package:keyspace/features/api_key_pool/data/api_key_admin_repository.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';

void main() {
  late AppDatabase database;
  late InMemorySecretStore secrets;
  late ApiKeyAdminRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    secrets = InMemorySecretStore();
    await SettingsRepository(database).initialize();
    repository = ApiKeyAdminRepository(database, secrets);
  });

  tearDown(() => database.close());

  test('valid key becomes healthy', () async {
    final id = await repository.add(alias: 'Valid', secret: 'secret-valid');
    final service = ApiKeyTestService(
      repository: repository,
      client: _ResultClient(_success()),
    );

    final result = await service.test(id);

    expect(result.isSuccess, isTrue);
    expect(result.health, ApiKeyHealth.healthy);
    expect((await repository.keys()).single.healthStatus, 'healthy');
  });

  for (final entry in <GeminiFailureCategory, ApiKeyHealth>{
    GeminiFailureCategory.invalidKey: ApiKeyHealth.invalid,
    GeminiFailureCategory.permission: ApiKeyHealth.blocked,
    GeminiFailureCategory.rateLimit: ApiKeyHealth.limited,
    GeminiFailureCategory.transientServer: ApiKeyHealth.transientError,
    GeminiFailureCategory.modelNotFound: ApiKeyHealth.transientError,
    GeminiFailureCategory.offline: ApiKeyHealth.transientError,
  }.entries) {
    test('${entry.key.name} updates sanitized key health', () async {
      final id = await repository.add(alias: 'Key', secret: 'private-value');
      final service = ApiKeyTestService(
        repository: repository,
        client: _ResultClient(_failure(entry.key)),
      );

      final result = await service.test(id);

      expect(result.failureCategory, entry.key);
      expect(result.health, entry.value);
      expect(
        (await repository.keys()).single.healthStatus,
        _status(entry.value),
      );
    });
  }

  test('timeout cancels request and releases with timeout result', () async {
    final id = await repository.add(alias: 'Slow', secret: 'secret-slow');
    final client = _PendingClient();
    final cancellation = RequestCancellation();
    final service = ApiKeyTestService(
      repository: repository,
      client: client,
      timeout: const Duration(milliseconds: 10),
    );

    final result = await service.test(id, cancellation: cancellation);

    expect(result.failureCategory, GeminiFailureCategory.timeout);
    expect(result.health, ApiKeyHealth.transientError);
    expect(cancellation.isCancelled, isTrue);
  });

  test('missing secret is reported without calling Gemini', () async {
    final id = await repository.add(alias: 'Missing', secret: 'temporary');
    await secrets.delete(id);
    final client = _ResultClient(_success());
    final service = ApiKeyTestService(repository: repository, client: client);

    final result = await service.test(id);

    expect(result.failureCategory, GeminiFailureCategory.secretUnavailable);
    expect(result.health, ApiKeyHealth.secretUnavailable);
    expect(client.calls, 0);
  });
}

class _ResultClient implements GeminiClient {
  _ResultClient(this.result);

  final GeminiCallResult result;
  int calls = 0;

  @override
  Future<GeminiCallResult> parseFood({
    required String secret,
    required String input,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) async {
    calls++;
    return result;
  }

  @override
  Future<GeminiCallResult> parseChat({
    required String secret,
    required String input,
    required ChatParseContext context,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) async {
    calls++;
    return result;
  }
}

class _PendingClient implements GeminiClient {
  final Completer<GeminiCallResult> completer = Completer<GeminiCallResult>();

  @override
  Future<GeminiCallResult> parseFood({
    required String secret,
    required String input,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) => completer.future;

  @override
  Future<GeminiCallResult> parseChat({
    required String secret,
    required String input,
    required ChatParseContext context,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) => completer.future;
}

GeminiCallSuccess _success() => const GeminiCallSuccess(
  data: <String, dynamic>{},
  latency: Duration(milliseconds: 1),
);

GeminiCallFailure _failure(GeminiFailureCategory category) => GeminiCallFailure(
  failure: GeminiFailure(category: category),
  latency: const Duration(milliseconds: 1),
);

String _status(ApiKeyHealth health) => switch (health) {
  ApiKeyHealth.untested => 'untested',
  ApiKeyHealth.healthy => 'healthy',
  ApiKeyHealth.limited => 'limited',
  ApiKeyHealth.invalid => 'invalid',
  ApiKeyHealth.blocked => 'blocked',
  ApiKeyHealth.transientError => 'transient_error',
  ApiKeyHealth.secretUnavailable => 'secret_unavailable',
  ApiKeyHealth.disabled => 'disabled',
};
