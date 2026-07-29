import 'dart:math';

import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/core/time/clock.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/food_chat/domain/food_response_parser.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_response_parser.dart';

typedef Delay = Future<void> Function(Duration duration);
typedef Jitter = Duration Function();

class GeminiFailoverService {
  GeminiFailoverService({
    required GeminiClient client,
    required KeyPoolRepository keyPool,
    required PendingRequestRepository pendingRequests,
    required SecretStore secretStore,
    required NetworkStatus networkStatus,
    required Clock clock,
    required String Function() createRequestId,
    FoodResponseParser parser = const FoodResponseParser(),
    UnifiedChatResponseParser unifiedParser = const UnifiedChatResponseParser(),
    Delay delay = Future<void>.delayed,
    Jitter? jitter,
  }) : _client = client,
       _keyPool = keyPool,
       _pendingRequests = pendingRequests,
       _secretStore = secretStore,
       _networkStatus = networkStatus,
       _clock = clock,
       _createRequestId = createRequestId,
       _parser = parser,
       _unifiedParser = unifiedParser,
       _delay = delay,
       _jitter = jitter ?? _randomJitter;

  final GeminiClient _client;
  final KeyPoolRepository _keyPool;
  final PendingRequestRepository _pendingRequests;
  final SecretStore _secretStore;
  final NetworkStatus _networkStatus;
  final Clock _clock;
  final String Function() _createRequestId;
  final FoodResponseParser _parser;
  final UnifiedChatResponseParser _unifiedParser;
  final Delay _delay;
  final Jitter _jitter;

  Future<ParseFoodResult> parseFood(
    String input, {
    String? requestId,
    CancellationSignal? cancellation,
  }) async {
    requestId ??= _createRequestId();
    final startedAt = _clock.now();
    await _pendingRequests.savePending(
      requestId: requestId,
      input: input,
      createdAt: startedAt,
    );

    if (cancellation?.isCancelled ?? false) {
      await _pendingRequests.markFailed(
        requestId,
        GeminiFailureCategory.cancelled,
      );
      return CancelledFailure(requestId: requestId);
    }

    if (!await _networkStatus.isOnline) {
      await _pendingRequests.markFailed(
        requestId,
        GeminiFailureCategory.offline,
      );
      return OfflineFailure(requestId: requestId);
    }

    final candidates = await _orderedCandidates();
    final attempted = <String>[];
    for (final key in candidates) {
      final now = _clock.now();
      if (!key.isEligible(now)) continue;
      attempted.add(key.id);

      final secret = await _readSecret(key, now);
      if (secret == null) continue;

      var result = await _client.parseFood(
        secret: secret,
        input: input,
        repairAttempt: false,
        cancellation: cancellation,
      );
      if (result is GeminiCallFailure &&
          _isTransient(result.failure.category)) {
        if (!await _networkStatus.isOnline) {
          await _pendingRequests.markFailed(
            requestId,
            GeminiFailureCategory.offline,
          );
          return OfflineFailure(requestId: requestId);
        }
        await _delay(ProviderConfig.transientRetryBackoff + _jitter());
        if (cancellation?.isCancelled ?? false) {
          await _pendingRequests.markFailed(
            requestId,
            GeminiFailureCategory.cancelled,
          );
          return CancelledFailure(requestId: requestId);
        }
        result = await _client.parseFood(
          secret: secret,
          input: input,
          repairAttempt: false,
          cancellation: cancellation,
        );
      }

      if (result is GeminiCallSuccess) {
        final parsed = await _parseOrRepair(
          result,
          secret: secret,
          input: input,
          cancellation: cancellation,
        );
        if (parsed != null) {
          await _keyPool.markHealthyAndActive(key.id, _clock.now());
          await _keyPool.recordUsage(
            ApiUsageEvent(
              keyId: key.id,
              requestId: requestId,
              success: true,
              latency: result.latency,
              createdAt: _clock.now(),
              promptTokens: result.promptTokens,
              outputTokens: result.outputTokens,
            ),
          );
          await _pendingRequests.markPreviewReady(requestId, parsed);
          return ParseFoodSuccess(
            draft: parsed,
            keyId: key.id,
            requestId: requestId,
          );
        }
        await _recordFailure(
          key.id,
          requestId,
          const GeminiFailure(category: GeminiFailureCategory.schemaMismatch),
          result.latency,
        );
        await _pendingRequests.markFailed(
          requestId,
          GeminiFailureCategory.schemaMismatch,
        );
        return RequestFailure(
          GeminiFailureCategory.schemaMismatch,
          requestId: requestId,
        );
      }

      final failureResult = result as GeminiCallFailure;
      final category = failureResult.failure.category;
      if (category == GeminiFailureCategory.offline) {
        await _pendingRequests.markFailed(requestId, category);
        return OfflineFailure(requestId: requestId);
      }
      if (category == GeminiFailureCategory.cancelled) {
        await _pendingRequests.markFailed(requestId, category);
        return CancelledFailure(requestId: requestId);
      }
      await _recordFailure(
        key.id,
        requestId,
        failureResult.failure,
        failureResult.latency,
      );
      final terminal = await _handleFailure(
        key.id,
        failureResult.failure,
        requestId,
      );
      if (terminal != null) return terminal;
    }

    await _pendingRequests.markFailed(requestId, GeminiFailureCategory.unknown);
    return AllKeysFailed(
      attemptedKeys: List.unmodifiable(attempted),
      requestId: requestId,
    );
  }

  Future<ParseChatResult> parseChat(
    String input, {
    required ChatParseContext context,
    String? requestId,
    CancellationSignal? cancellation,
  }) async {
    requestId ??= _createRequestId();
    final startedAt = _clock.now();
    await _pendingRequests.savePending(
      requestId: requestId,
      input: input,
      createdAt: startedAt,
    );

    if (cancellation?.isCancelled ?? false) {
      await _pendingRequests.markFailed(
        requestId,
        GeminiFailureCategory.cancelled,
      );
      return ParseChatCancelled(requestId: requestId);
    }

    if (!await _networkStatus.isOnline) {
      await _pendingRequests.markFailed(
        requestId,
        GeminiFailureCategory.offline,
      );
      return ParseChatOffline(requestId: requestId);
    }

    final candidates = await _orderedCandidates();
    final attempted = <String>[];
    for (final key in candidates) {
      final now = _clock.now();
      if (!key.isEligible(now)) continue;
      attempted.add(key.id);

      final secret = await _readSecret(key, now);
      if (secret == null) continue;

      var result = await _client.parseChat(
        secret: secret,
        input: input,
        context: context,
        repairAttempt: false,
        cancellation: cancellation,
      );
      if (result is GeminiCallFailure &&
          _isTransient(result.failure.category)) {
        if (!await _networkStatus.isOnline) {
          await _pendingRequests.markFailed(
            requestId,
            GeminiFailureCategory.offline,
          );
          return ParseChatOffline(requestId: requestId);
        }
        await _delay(ProviderConfig.transientRetryBackoff + _jitter());
        if (cancellation?.isCancelled ?? false) {
          await _pendingRequests.markFailed(
            requestId,
            GeminiFailureCategory.cancelled,
          );
          return ParseChatCancelled(requestId: requestId);
        }
        result = await _client.parseChat(
          secret: secret,
          input: input,
          context: context,
          repairAttempt: false,
          cancellation: cancellation,
        );
      }

      if (result is GeminiCallSuccess) {
        ParsedResult<UnifiedChatDraft?> parseOutcome;
        try {
          final draft = await _parseUnifiedOrRepair(
            result,
            secret: secret,
            input: input,
            context: context,
            cancellation: cancellation,
          );
          parseOutcome = ParsedResult(value: draft, isAmbiguous: false);
        } on _AmbiguousInputSignal catch (e) {
          parseOutcome = ParsedResult(
            value: null,
            isAmbiguous: true,
            detail: e.reason,
          );
        }

        if (parseOutcome.value != null) {
          final parsed = parseOutcome.value!;
          await _keyPool.markHealthyAndActive(key.id, _clock.now());
          await _keyPool.recordUsage(
            ApiUsageEvent(
              keyId: key.id,
              requestId: requestId,
              success: true,
              latency: result.latency,
              createdAt: _clock.now(),
              promptTokens: result.promptTokens,
              outputTokens: result.outputTokens,
            ),
          );
          await _pendingRequests.markUnifiedPreviewReady(requestId, parsed);
          return ParseChatSuccess(
            draft: parsed,
            keyId: key.id,
            requestId: requestId,
          );
        }
        await _recordFailure(
          key.id,
          requestId,
          const GeminiFailure(category: GeminiFailureCategory.schemaMismatch),
          result.latency,
        );
        await _pendingRequests.markFailed(
          requestId,
          GeminiFailureCategory.schemaMismatch,
        );
        return ParseChatRequestFailure(
          GeminiFailureCategory.schemaMismatch,
          requestId: requestId,
          kind: parseOutcome.isAmbiguous
              ? ParseChatFailureKind.ambiguousInput
              : ParseChatFailureKind.technicalError,
          detail: parseOutcome.detail,
        );
      }

      final failureResult = result as GeminiCallFailure;
      final category = failureResult.failure.category;
      if (category == GeminiFailureCategory.offline) {
        await _pendingRequests.markFailed(requestId, category);
        return ParseChatOffline(requestId: requestId);
      }
      if (category == GeminiFailureCategory.cancelled) {
        await _pendingRequests.markFailed(requestId, category);
        return ParseChatCancelled(requestId: requestId);
      }
      await _recordFailure(
        key.id,
        requestId,
        failureResult.failure,
        failureResult.latency,
      );
      final terminal = await _handleUnifiedFailure(
        key.id,
        failureResult.failure,
        requestId,
      );
      if (terminal != null) return terminal;
    }

    await _pendingRequests.markFailed(requestId, GeminiFailureCategory.unknown);
    return ParseChatAllKeysFailed(
      attemptedKeys: List.unmodifiable(attempted),
      requestId: requestId,
    );
  }

  Future<List<ApiKeyCandidate>> _orderedCandidates() async {
    final keys = await _keyPool.enabledKeysByPriority();
    keys.sort((a, b) => a.priorityOrder.compareTo(b.priorityOrder));
    if (keys.isEmpty) return keys;
    final activeId = await _keyPool.activeKeyId();
    final activeIndex = keys.indexWhere((key) => key.id == activeId);
    if (activeIndex <= 0) return keys;
    return [...keys.skip(activeIndex), ...keys.take(activeIndex)];
  }

  Future<String?> _readSecret(ApiKeyCandidate key, DateTime now) async {
    try {
      final secret = await _secretStore.read(key.secureRef);
      if (secret != null && secret.isNotEmpty) return secret;
    } on SecretStoreException {
      // Only the sanitized health category is persisted below.
    }
    await _keyPool.markFailure(
      key.id,
      ApiKeyHealth.secretUnavailable,
      GeminiFailureCategory.secretUnavailable,
      now,
    );
    return null;
  }

  Future<ParsedFoodDraft?> _parseOrRepair(
    GeminiCallSuccess result, {
    required String secret,
    required String input,
    CancellationSignal? cancellation,
  }) async {
    try {
      return _parser.parse(result.data);
    } on FoodResponseException {
      final repaired = await _client.parseFood(
        secret: secret,
        input: input,
        repairAttempt: true,
        cancellation: cancellation,
      );
      if (repaired is! GeminiCallSuccess) return null;
      try {
        return _parser.parse(repaired.data);
      } on FoodResponseException {
        return null;
      }
    }
  }

  Future<UnifiedChatDraft?> _parseUnifiedOrRepair(
    GeminiCallSuccess result, {
    required String secret,
    required String input,
    required ChatParseContext context,
    CancellationSignal? cancellation,
  }) async {
    UnifiedChatResponseException? firstException;
    try {
      return _unifiedParser.parse(result.data, context: context);
    } on UnifiedChatResponseException catch (e) {
      firstException = e;
      // Jika alasan jelas merupakan input ambigu (bukan schema error teknis),
      // langsung lempar sinyal ambigu tanpa mencoba repair.
      if (_isAmbiguousReason(e.reason)) {
        throw _AmbiguousInputSignal(e.reason);
      }
    }
    // Coba repair untuk kasus schema error teknis
    final repaired = await _client.parseChat(
      secret: secret,
      input: input,
      context: context,
      repairAttempt: true,
      cancellation: cancellation,
    );
    if (repaired is! GeminiCallSuccess) return null;
    try {
      return _unifiedParser.parse(repaired.data, context: context);
    } on UnifiedChatResponseException catch (e) {
      // Setelah repair pun masih gagal — tentukan jenis kegagalan
      if (_isAmbiguousReason(e.reason) ||
          _isAmbiguousReason(firstException.reason)) {
        throw _AmbiguousInputSignal(e.reason);
      }
      return null;
    }
  }

  /// Reason yang mengindikasikan input ambigu dari pengguna,
  /// bukan schema error teknis dari Gemini.
  /// Catatan: explicit_mode_mismatch dan fallback_category_missing TIDAK
  /// termasuk di sini karena masih bisa diperbaiki dengan repair attempt.
  static bool _isAmbiguousReason(String reason) {
    // Domain benar-benar tidak dikenali: Gemini mengembalikan 'unknown'
    // baik dengan maupun tanpa clarification_question.
    return reason == 'unknown_requires_clarification' ||
        reason == 'unknown_invalid' ||
        // Tidak ada item keuangan sama sekali setelah domain terdeteksi —
        // kemungkinan input tidak menyebut nominal apapun.
        reason == 'financial_items_empty';
  }

  Future<void> _recordFailure(
    String keyId,
    String requestId,
    GeminiFailure failure,
    Duration latency,
  ) {
    return _keyPool.recordUsage(
      ApiUsageEvent(
        keyId: keyId,
        requestId: requestId,
        success: false,
        latency: latency,
        createdAt: _clock.now(),
        category: failure.category,
        httpStatus: failure.httpStatus,
      ),
    );
  }

  Future<ParseFoodResult?> _handleFailure(
    String keyId,
    GeminiFailure failure,
    String requestId,
  ) async {
    final now = _clock.now();
    switch (failure.category) {
      case GeminiFailureCategory.invalidKey:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.invalid,
          failure.category,
          now,
        );
      case GeminiFailureCategory.permission:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.blocked,
          failure.category,
          now,
        );
      case GeminiFailureCategory.rateLimit:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.limited,
          failure.category,
          now,
          cooldownUntil: now.add(
            failure.retryAfter ?? ProviderConfig.rateLimitCooldown,
          ),
        );
      case GeminiFailureCategory.transientServer:
      case GeminiFailureCategory.timeout:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.transientError,
          failure.category,
          now,
          cooldownUntil: now.add(ProviderConfig.transientCooldown),
        );
      case GeminiFailureCategory.requestInvalid:
      case GeminiFailureCategory.modelNotFound:
      case GeminiFailureCategory.schemaMismatch:
      case GeminiFailureCategory.unknown:
        await _pendingRequests.markFailed(requestId, failure.category);
        return RequestFailure(failure.category, requestId: requestId);
      case GeminiFailureCategory.safetyBlock:
        await _pendingRequests.markFailed(requestId, failure.category);
        return ContentNeedsRevision(requestId: requestId);
      case GeminiFailureCategory.offline:
        await _pendingRequests.markFailed(requestId, failure.category);
        return OfflineFailure(requestId: requestId);
      case GeminiFailureCategory.cancelled:
        await _pendingRequests.markFailed(requestId, failure.category);
        return CancelledFailure(requestId: requestId);
      case GeminiFailureCategory.secretUnavailable:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.secretUnavailable,
          failure.category,
          now,
        );
    }
    return null;
  }

  Future<ParseChatResult?> _handleUnifiedFailure(
    String keyId,
    GeminiFailure failure,
    String requestId,
  ) async {
    final now = _clock.now();
    switch (failure.category) {
      case GeminiFailureCategory.invalidKey:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.invalid,
          failure.category,
          now,
        );
      case GeminiFailureCategory.permission:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.blocked,
          failure.category,
          now,
        );
      case GeminiFailureCategory.rateLimit:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.limited,
          failure.category,
          now,
          cooldownUntil: now.add(
            failure.retryAfter ?? ProviderConfig.rateLimitCooldown,
          ),
        );
      case GeminiFailureCategory.transientServer:
      case GeminiFailureCategory.timeout:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.transientError,
          failure.category,
          now,
          cooldownUntil: now.add(ProviderConfig.transientCooldown),
        );
      case GeminiFailureCategory.requestInvalid:
      case GeminiFailureCategory.modelNotFound:
      case GeminiFailureCategory.schemaMismatch:
      case GeminiFailureCategory.unknown:
        await _pendingRequests.markFailed(requestId, failure.category);
        return ParseChatRequestFailure(failure.category, requestId: requestId);
      case GeminiFailureCategory.safetyBlock:
        await _pendingRequests.markFailed(requestId, failure.category);
        return ParseChatContentNeedsRevision(requestId: requestId);
      case GeminiFailureCategory.offline:
        await _pendingRequests.markFailed(requestId, failure.category);
        return ParseChatOffline(requestId: requestId);
      case GeminiFailureCategory.cancelled:
        await _pendingRequests.markFailed(requestId, failure.category);
        return ParseChatCancelled(requestId: requestId);
      case GeminiFailureCategory.secretUnavailable:
        await _keyPool.markFailure(
          keyId,
          ApiKeyHealth.secretUnavailable,
          failure.category,
          now,
        );
    }
    return null;
  }

  bool _isTransient(GeminiFailureCategory category) =>
      category == GeminiFailureCategory.transientServer ||
      category == GeminiFailureCategory.timeout;

  static Duration _randomJitter() =>
      Duration(milliseconds: Random.secure().nextInt(251));
}

/// Sinyal internal: parser gagal karena input ambigu (bukan schema error teknis).
/// Hanya digunakan di dalam [GeminiFailoverService].
class _AmbiguousInputSignal implements Exception {
  const _AmbiguousInputSignal(this.reason);
  final String reason;
}

/// Container hasil parsing internal yang membawa info apakah kegagalan bersifat ambigu.
class ParsedResult<T> {
  const ParsedResult({
    required this.value,
    required this.isAmbiguous,
    this.detail,
  });
  final T value;
  final bool isAmbiguous;
  final String? detail;
}
