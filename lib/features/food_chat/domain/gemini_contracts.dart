import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';

sealed class GeminiCallResult {
  const GeminiCallResult({required this.latency});

  final Duration latency;
}

class GeminiCallSuccess extends GeminiCallResult {
  const GeminiCallSuccess({
    required this.data,
    required super.latency,
    this.promptTokens,
    this.outputTokens,
  });

  final Map<String, dynamic> data;
  final int? promptTokens;
  final int? outputTokens;
}

class GeminiCallFailure extends GeminiCallResult {
  const GeminiCallFailure({required this.failure, required super.latency});

  final GeminiFailure failure;
}

abstract interface class GeminiClient {
  Future<GeminiCallResult> parseFood({
    required String secret,
    required String input,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  });

  Future<GeminiCallResult> parseChat({
    required String secret,
    required String input,
    required ChatParseContext context,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  });
}

abstract interface class NetworkStatus {
  Future<bool> get isOnline;
}

class StaticNetworkStatus implements NetworkStatus {
  const StaticNetworkStatus(this.online);

  final bool online;

  @override
  Future<bool> get isOnline async => online;
}

enum ApiKeyHealth {
  untested,
  healthy,
  limited,
  invalid,
  blocked,
  transientError,
  secretUnavailable,
  disabled,
}

class ApiKeyCandidate {
  const ApiKeyCandidate({
    required this.id,
    required this.secureRef,
    required this.priorityOrder,
    required this.isEnabled,
    required this.health,
    this.cooldownUntil,
  });

  final String id;
  final String secureRef;
  final int priorityOrder;
  final bool isEnabled;
  final ApiKeyHealth health;
  final DateTime? cooldownUntil;

  bool isEligible(DateTime now) {
    if (!isEnabled) return false;
    if (health == ApiKeyHealth.invalid ||
        health == ApiKeyHealth.blocked ||
        health == ApiKeyHealth.secretUnavailable ||
        health == ApiKeyHealth.disabled) {
      return false;
    }
    return cooldownUntil == null || !cooldownUntil!.isAfter(now);
  }
}

class ApiUsageEvent {
  const ApiUsageEvent({
    required this.keyId,
    required this.requestId,
    required this.success,
    required this.latency,
    required this.createdAt,
    this.category,
    this.httpStatus,
    this.promptTokens,
    this.outputTokens,
  });

  final String keyId;
  final String requestId;
  final bool success;
  final Duration latency;
  final DateTime createdAt;
  final GeminiFailureCategory? category;
  final int? httpStatus;
  final int? promptTokens;
  final int? outputTokens;
}

abstract interface class KeyPoolRepository {
  Future<List<ApiKeyCandidate>> enabledKeysByPriority();
  Future<String?> activeKeyId();
  Future<void> markHealthyAndActive(String keyId, DateTime at);
  Future<void> markFailure(
    String keyId,
    ApiKeyHealth health,
    GeminiFailureCategory category,
    DateTime at, {
    DateTime? cooldownUntil,
  });
  Future<void> recordUsage(ApiUsageEvent event);
}

abstract interface class PendingRequestRepository {
  Future<void> savePending({
    required String requestId,
    required String input,
    required DateTime createdAt,
  });
  Future<void> markFailed(String requestId, GeminiFailureCategory category);
  Future<void> markPreviewReady(String requestId, ParsedFoodDraft draft);
  Future<void> markUnifiedPreviewReady(
    String requestId,
    UnifiedChatDraft draft,
  );
}
