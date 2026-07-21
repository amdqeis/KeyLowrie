import 'package:drift/drift.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:uuid/uuid.dart';

class DriftKeyPoolRepository implements KeyPoolRepository {
  DriftKeyPoolRepository(this._database, {Uuid uuid = const Uuid()})
    : _uuid = uuid;

  final AppDatabase _database;
  final Uuid _uuid;

  @override
  Future<String?> activeKeyId() async {
    final settings = await (_database.select(
      _database.appSettings,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    return settings?.activeKeyId;
  }

  @override
  Future<List<ApiKeyCandidate>> enabledKeysByPriority() async {
    final rows =
        await (_database.select(_database.apiKeyMetadata)
              ..where((row) => row.isEnabled.equals(true))
              ..orderBy([(row) => OrderingTerm.asc(row.priorityOrder)]))
            .get();
    return rows
        .map(
          (row) => ApiKeyCandidate(
            id: row.id,
            secureRef: row.secureRef,
            priorityOrder: row.priorityOrder,
            isEnabled: row.isEnabled,
            health: _health(row.healthStatus),
            cooldownUntil: row.cooldownUntil,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> markFailure(
    String keyId,
    ApiKeyHealth health,
    GeminiFailureCategory category,
    DateTime at, {
    DateTime? cooldownUntil,
  }) async {
    final row = await (_database.select(
      _database.apiKeyMetadata,
    )..where((item) => item.id.equals(keyId))).getSingle();
    await (_database.update(
      _database.apiKeyMetadata,
    )..where((item) => item.id.equals(keyId))).write(
      ApiKeyMetadataCompanion(
        healthStatus: Value(_healthValue(health)),
        cooldownUntil: Value(cooldownUntil),
        lastFailureAt: Value(at),
        lastErrorCategory: Value(category.name),
        failureCount: Value(row.failureCount + 1),
        updatedAt: Value(at),
      ),
    );
  }

  @override
  Future<void> markHealthyAndActive(String keyId, DateTime at) async {
    await _database.transaction(() async {
      final row = await (_database.select(
        _database.apiKeyMetadata,
      )..where((item) => item.id.equals(keyId))).getSingle();
      await (_database.update(
        _database.apiKeyMetadata,
      )..where((item) => item.id.equals(keyId))).write(
        ApiKeyMetadataCompanion(
          healthStatus: const Value('healthy'),
          cooldownUntil: const Value(null),
          lastSuccessAt: Value(at),
          lastErrorCategory: const Value(null),
          successCount: Value(row.successCount + 1),
          updatedAt: Value(at),
        ),
      );
      await (_database.update(
        _database.appSettings,
      )..where((settings) => settings.id.equals(1))).write(
        AppSettingsCompanion(activeKeyId: Value(keyId), updatedAt: Value(at)),
      );
    });
  }

  @override
  Future<void> recordUsage(ApiUsageEvent event) {
    return _database
        .into(_database.apiKeyUsageEvents)
        .insert(
          ApiKeyUsageEventsCompanion.insert(
            id: _uuid.v4(),
            apiKeyMetadataId: event.keyId,
            localRequestId: event.requestId,
            operation: 'parse',
            outcome: event.success ? 'success' : 'failure',
            errorCategory: Value(event.category?.name),
            httpStatus: Value(event.httpStatus),
            latencyMs: Value(event.latency.inMilliseconds),
            promptTokens: Value(event.promptTokens),
            outputTokens: Value(event.outputTokens),
            modelId: const Value(ProviderConfig.model),
            createdAt: event.createdAt,
          ),
        );
  }

  ApiKeyHealth _health(String value) => switch (value) {
    'healthy' => ApiKeyHealth.healthy,
    'limited' => ApiKeyHealth.limited,
    'invalid' => ApiKeyHealth.invalid,
    'blocked' => ApiKeyHealth.blocked,
    'transient_error' => ApiKeyHealth.transientError,
    'secret_unavailable' => ApiKeyHealth.secretUnavailable,
    'disabled' => ApiKeyHealth.disabled,
    _ => ApiKeyHealth.untested,
  };

  String _healthValue(ApiKeyHealth health) => switch (health) {
    ApiKeyHealth.transientError => 'transient_error',
    ApiKeyHealth.secretUnavailable => 'secret_unavailable',
    _ => health.name,
  };
}
