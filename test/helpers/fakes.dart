import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/time/clock.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';

class FixedClock implements Clock {
  FixedClock(this.value);

  DateTime value;

  @override
  DateTime now() => value;
}

class ClientCall {
  const ClientCall({
    required this.secret,
    required this.input,
    required this.repairAttempt,
  });

  final String secret;
  final String input;
  final bool repairAttempt;
}

class FakeGeminiClient implements GeminiClient {
  FakeGeminiClient(Iterable<GeminiCallResult> results)
    : _results = List.of(results);

  final List<GeminiCallResult> _results;
  final List<ClientCall> calls = [];

  @override
  Future<GeminiCallResult> parseFood({
    required String secret,
    required String input,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) async {
    calls.add(
      ClientCall(secret: secret, input: input, repairAttempt: repairAttempt),
    );
    if (_results.isEmpty) throw StateError('Fake result queue is empty');
    return _results.removeAt(0);
  }
}

class FailureUpdate {
  const FailureUpdate({
    required this.keyId,
    required this.health,
    required this.category,
    this.cooldownUntil,
  });

  final String keyId;
  final ApiKeyHealth health;
  final GeminiFailureCategory category;
  final DateTime? cooldownUntil;
}

class FakeKeyPoolRepository implements KeyPoolRepository {
  FakeKeyPoolRepository({required this.keys, this.activeId});

  final List<ApiKeyCandidate> keys;
  String? activeId;
  final List<FailureUpdate> failures = [];
  final List<ApiUsageEvent> usage = [];

  @override
  Future<String?> activeKeyId() async => activeId;

  @override
  Future<List<ApiKeyCandidate>> enabledKeysByPriority() async => List.of(keys);

  @override
  Future<void> markFailure(
    String keyId,
    ApiKeyHealth health,
    GeminiFailureCategory category,
    DateTime at, {
    DateTime? cooldownUntil,
  }) async {
    failures.add(
      FailureUpdate(
        keyId: keyId,
        health: health,
        category: category,
        cooldownUntil: cooldownUntil,
      ),
    );
  }

  @override
  Future<void> markHealthyAndActive(String keyId, DateTime at) async {
    activeId = keyId;
  }

  @override
  Future<void> recordUsage(ApiUsageEvent event) async {
    usage.add(event);
  }
}

class PendingRecord {
  const PendingRecord({
    required this.requestId,
    required this.input,
    required this.createdAt,
  });

  final String requestId;
  final String input;
  final DateTime createdAt;
}

class FakePendingRequestRepository implements PendingRequestRepository {
  final List<PendingRecord> pending = [];
  final Map<String, GeminiFailureCategory> failures = {};
  final Map<String, ParsedFoodDraft> previews = {};

  @override
  Future<void> markFailed(
    String requestId,
    GeminiFailureCategory category,
  ) async {
    failures[requestId] = category;
  }

  @override
  Future<void> markPreviewReady(String requestId, ParsedFoodDraft draft) async {
    previews[requestId] = draft;
  }

  @override
  Future<void> savePending({
    required String requestId,
    required String input,
    required DateTime createdAt,
  }) async {
    pending.add(
      PendingRecord(requestId: requestId, input: input, createdAt: createdAt),
    );
  }
}

Map<String, dynamic> validFoodResponse({double calories = 640}) => {
  'items': [
    {
      'name': ' Nasi goreng\u0001 ',
      'quantity': 1,
      'unit': 'porsi',
      'portion_text': '1 porsi standar',
      'calories_kcal': calories,
      'protein_g': 14,
      'carbs_g': 72,
      'fat_g': 19,
      'fiber_g': 4,
      'sodium_mg': 900,
      'confidence': 0.62,
      'assumption_note': 'Porsi standar.',
    },
  ],
  'summary': {
    'total_calories_kcal': calories,
    'total_protein_g': 14,
    'total_carbs_g': 72,
    'total_fat_g': 19,
    'needs_user_review': true,
    'general_note': 'Nilai merupakan estimasi.',
  },
};
