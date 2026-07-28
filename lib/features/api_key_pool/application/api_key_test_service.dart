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

    final result = await _client
        .parseFood(
          secret: secret,
          input: '1 telur rebus',
          repairAttempt: false,
          cancellation: signal,
        )
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
