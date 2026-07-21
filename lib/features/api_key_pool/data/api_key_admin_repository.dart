import 'package:drift/drift.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:uuid/uuid.dart';

class ApiKeyAdminRepository {
  ApiKeyAdminRepository(
    this.database,
    this.secretStore, {
    Uuid uuid = const Uuid(),
  }) : _uuid = uuid;

  final AppDatabase database;
  final SecretStore secretStore;
  final Uuid _uuid;

  Stream<List<ApiKeyMetadataData>> watchKeys() {
    return (database.select(
      database.apiKeyMetadata,
    )..orderBy([(row) => OrderingTerm.asc(row.priorityOrder)])).watch();
  }

  Future<List<ApiKeyMetadataData>> keys() {
    return (database.select(
      database.apiKeyMetadata,
    )..orderBy([(row) => OrderingTerm.asc(row.priorityOrder)])).get();
  }

  Future<String> add({
    required String alias,
    required String secret,
    ApiKeyHealth health = ApiKeyHealth.untested,
  }) async {
    final cleaned = secret.trim();
    if (cleaned.isEmpty) throw const FormatException('secret_empty');
    final id = _uuid.v4();
    final secureRef = id;
    await secretStore.write(secureRef, cleaned);
    try {
      final count = await database.apiKeyMetadata.count().getSingle();
      final now = DateTime.now().toUtc();
      await database.transaction(() async {
        await database
            .into(database.apiKeyMetadata)
            .insert(
              ApiKeyMetadataCompanion.insert(
                id: id,
                alias: _alias(alias, count + 1),
                secureRef: secureRef,
                maskedSuffix: maskApiKey(cleaned),
                priorityOrder: count + 1,
                isEnabled: true,
                healthStatus: _healthValue(health),
                createdAt: now,
                updatedAt: now,
              ),
            );
        final settings = await (database.select(
          database.appSettings,
        )..where((row) => row.id.equals(1))).getSingle();
        if (settings.activeKeyId == null && _isEligibleHealth(health)) {
          await (database.update(
            database.appSettings,
          )..where((row) => row.id.equals(1))).write(
            AppSettingsCompanion(activeKeyId: Value(id), updatedAt: Value(now)),
          );
        }
      });
      return id;
    } on Object {
      await secretStore.delete(secureRef);
      rethrow;
    }
  }

  Future<void> edit({
    required String id,
    required String alias,
    String? replacementSecret,
  }) async {
    final row = await _row(id);
    final oldSecret = replacementSecret == null
        ? null
        : await secretStore.read(row.secureRef);
    final cleaned = replacementSecret?.trim();
    if (replacementSecret != null && (cleaned == null || cleaned.isEmpty)) {
      throw const FormatException('secret_empty');
    }
    if (cleaned != null) await secretStore.write(row.secureRef, cleaned);
    try {
      await (database.update(
        database.apiKeyMetadata,
      )..where((item) => item.id.equals(id))).write(
        ApiKeyMetadataCompanion(
          alias: Value(_alias(alias, row.priorityOrder)),
          maskedSuffix: cleaned == null
              ? const Value.absent()
              : Value(maskApiKey(cleaned)),
          healthStatus: cleaned == null
              ? const Value.absent()
              : const Value('untested'),
          cooldownUntil: cleaned == null
              ? const Value.absent()
              : const Value(null),
          lastErrorCategory: cleaned == null
              ? const Value.absent()
              : const Value(null),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
    } on Object {
      if (cleaned != null) {
        if (oldSecret == null) {
          await secretStore.delete(row.secureRef);
        } else {
          await secretStore.write(row.secureRef, oldSecret);
        }
      }
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    final row = await _row(id);
    final secret = await secretStore.read(row.secureRef);
    await secretStore.delete(row.secureRef);
    try {
      await database.transaction(() async {
        await (database.delete(
          database.apiKeyMetadata,
        )..where((item) => item.id.equals(id))).go();
        await _normalizePriorities();
        await _ensureActiveKey();
      });
    } on Object {
      if (secret != null) await secretStore.write(row.secureRef, secret);
      rethrow;
    }
  }

  Future<void> setEnabled(String id, bool enabled) async {
    await (database.update(
      database.apiKeyMetadata,
    )..where((row) => row.id.equals(id))).write(
      ApiKeyMetadataCompanion(
        isEnabled: Value(enabled),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
    await database.transaction(_ensureActiveKey);
  }

  Future<void> setActive(String id) async {
    final row = await _row(id);
    if (!row.isEnabled) throw StateError('key_disabled');
    await (database.update(
      database.appSettings,
    )..where((settings) => settings.id.equals(1))).write(
      AppSettingsCompanion(
        activeKeyId: Value(id),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> reorder(List<String> orderedIds) async {
    final current = await keys();
    if (orderedIds.length != current.length ||
        orderedIds.toSet().length != current.length ||
        !orderedIds.toSet().containsAll(current.map((row) => row.id))) {
      throw const FormatException('invalid_key_order');
    }
    final now = DateTime.now().toUtc();
    await database.transaction(() async {
      for (var index = 0; index < orderedIds.length; index++) {
        await (database.update(database.apiKeyMetadata)
              ..where((row) => row.id.equals(orderedIds[index])))
            .write(ApiKeyMetadataCompanion(priorityOrder: Value(-index - 1)));
      }
      for (var index = 0; index < orderedIds.length; index++) {
        await (database.update(
          database.apiKeyMetadata,
        )..where((row) => row.id.equals(orderedIds[index]))).write(
          ApiKeyMetadataCompanion(
            priorityOrder: Value(index + 1),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  Future<void> updateHealth(String id, ApiKeyHealth health) {
    return (database.update(
      database.apiKeyMetadata,
    )..where((row) => row.id.equals(id))).write(
      ApiKeyMetadataCompanion(
        healthStatus: Value(_healthValue(health)),
        cooldownUntil: const Value(null),
        lastErrorCategory: const Value(null),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<String?> readSecret(String id) async {
    final row = await _row(id);
    return secretStore.read(row.secureRef);
  }

  Future<ApiKeyMetadataData> _row(String id) {
    return (database.select(
      database.apiKeyMetadata,
    )..where((row) => row.id.equals(id))).getSingle();
  }

  Future<void> _normalizePriorities() async {
    final values = await keys();
    for (var i = 0; i < values.length; i++) {
      await (database.update(database.apiKeyMetadata)
            ..where((row) => row.id.equals(values[i].id)))
          .write(ApiKeyMetadataCompanion(priorityOrder: Value(i + 1)));
    }
  }

  Future<void> _ensureActiveKey() async {
    final settings = await (database.select(
      database.appSettings,
    )..where((row) => row.id.equals(1))).getSingle();
    final values = await keys();
    final eligible = values
        .where((row) => row.isEnabled && _isEligibleStatus(row.healthStatus))
        .toList();
    final activeStillEligible = eligible.any(
      (row) => row.id == settings.activeKeyId,
    );
    if (!activeStillEligible) {
      await (database.update(
        database.appSettings,
      )..where((row) => row.id.equals(1))).write(
        AppSettingsCompanion(
          activeKeyId: Value(eligible.isEmpty ? null : eligible.first.id),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
    }
  }

  String _alias(String value, int fallback) {
    final cleaned = value.trim();
    return cleaned.isEmpty ? 'Key $fallback' : cleaned;
  }

  bool _isEligibleHealth(ApiKeyHealth health) => !{
    ApiKeyHealth.invalid,
    ApiKeyHealth.blocked,
    ApiKeyHealth.secretUnavailable,
    ApiKeyHealth.disabled,
  }.contains(health);

  bool _isEligibleStatus(String value) =>
      !{'invalid', 'blocked', 'secret_unavailable', 'disabled'}.contains(value);

  String _healthValue(ApiKeyHealth health) => switch (health) {
    ApiKeyHealth.transientError => 'transient_error',
    ApiKeyHealth.secretUnavailable => 'secret_unavailable',
    _ => health.name,
  };
}
