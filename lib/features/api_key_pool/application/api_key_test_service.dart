import 'dart:async';

import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/features/api_key_pool/data/api_key_admin_repository.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';

class ApiKeyTestResult {
  const ApiKeyTestResult({required this.health, this.failureCategory});

  final ApiKeyHealth health;
  final GeminiFailureCategory? failureCategory;

  bool get isSuccess => failureCategory == null;
}

class ApiKeyTestService {
  const ApiKeyTestService({
    required ApiKeyAdminRepository repository,
    required GeminiClient client,
    Duration timeout = ProviderConfig.apiKeyTestTimeout,
  }) : _repository = repository,
       _client = client,
       _timeout = timeout;

  final ApiKeyAdminRepository _repository;
  final GeminiClient _client;
  final Duration _timeout;

  Future<ApiKeyTestResult> test(
    String id, {
    RequestCancellation? cancellation,
  }) async {
    final signal = cancellation ?? RequestCancellation();
    final String? secret;
    try {
      secret = await _repository.readSecret(id);
    } on SecretStoreException {
      return _finish(id, GeminiFailureCategory.secretUnavailable);
    }

    if (secret == null || secret.isEmpty) {
      return _finish(id, GeminiFailureCategory.secretUnavailable);
    }
    if (signal.isCancelled) {
      return const ApiKeyTestResult(
        health: ApiKeyHealth.untested,
        failureCategory: GeminiFailureCategory.cancelled,
      );
    }

    // Use verifyKey (models.get) instead of parseFood (generateContent)
    // to validate the key without consuming RPD or tokens.
    final result = await _client
        .verifyKey(secret: secret, cancellation: signal)
        .timeout(
          _timeout,
          onTimeout: () {
            signal.cancel();
            return GeminiCallFailure(
              failure: const GeminiFailure(
                category: GeminiFailureCategory.timeout,
              ),
              latency: _timeout,
            );
          },
        );

    if (result is GeminiCallSuccess) {
      await _repository.updateHealth(id, ApiKeyHealth.healthy);
      return const ApiKeyTestResult(health: ApiKeyHealth.healthy);
    }

    final failure = (result as GeminiCallFailure).failure.category;
    if (failure == GeminiFailureCategory.cancelled) {
      return const ApiKeyTestResult(
        health: ApiKeyHealth.untested,
        failureCategory: GeminiFailureCategory.cancelled,
      );
    }
    return _finish(id, failure);
  }

  /// Tests all keys sequentially using models.get (0 RPD cost).
  /// Yields each result as it completes for live UI updates.
  Stream<(String keyId, ApiKeyTestResult result)> testAll(
    List<String> keyIds, {
    RequestCancellation? cancellation,
  }) async* {
    for (final id in keyIds) {
      if (cancellation?.isCancelled ?? false) return;
      final result = await test(id, cancellation: cancellation);
      yield (id, result);
    }
  }

  Future<ApiKeyTestResult> _finish(
    String id,
    GeminiFailureCategory category,
  ) async {
    final health = apiKeyHealthForFailure(category);
    await _repository.updateHealth(id, health);
    return ApiKeyTestResult(health: health, failureCategory: category);
  }
}

ApiKeyHealth apiKeyHealthForFailure(GeminiFailureCategory category) =>
    switch (category) {
      GeminiFailureCategory.invalidKey => ApiKeyHealth.invalid,
      GeminiFailureCategory.permission => ApiKeyHealth.blocked,
      GeminiFailureCategory.rateLimit => ApiKeyHealth.limited,
      GeminiFailureCategory.secretUnavailable => ApiKeyHealth.secretUnavailable,
      GeminiFailureCategory.transientServer ||
      GeminiFailureCategory.timeout ||
      GeminiFailureCategory.requestInvalid ||
      GeminiFailureCategory.modelNotFound ||
      GeminiFailureCategory.offline ||
      GeminiFailureCategory.unknown => ApiKeyHealth.transientError,
      // The key itself remains usable for content/schema/cancellation failures.
      GeminiFailureCategory.safetyBlock ||
      GeminiFailureCategory.schemaMismatch ||
      GeminiFailureCategory.cancelled => ApiKeyHealth.untested,
    };
