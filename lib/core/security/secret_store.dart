import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class SecretStore {
  Future<void> write(String reference, String secret);
  Future<String?> read(String reference);
  Future<void> delete(String reference);
  Future<void> deleteAll();
}

enum SecretStoreError { unavailable, accessDenied, unknown }

class SecretStoreException implements Exception {
  const SecretStoreException(this.error);

  final SecretStoreError error;

  @override
  String toString() => 'SecretStoreException(${error.name})';
}

class FlutterSecureSecretStore implements SecretStore {
  const FlutterSecureSecretStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const namespace = 'keyspace.api_key.';
  final FlutterSecureStorage _storage;

  @override
  Future<void> delete(String reference) =>
      _guard(() => _storage.delete(key: _key(reference)));

  @override
  Future<void> deleteAll() => _guard(_deleteNamespacedValues);

  @override
  Future<String?> read(String reference) =>
      _guard(() => _storage.read(key: _key(reference)));

  @override
  Future<void> write(String reference, String secret) =>
      _guard(() => _storage.write(key: _key(reference), value: secret));

  String _key(String reference) => '$namespace$reference';

  Future<void> _deleteNamespacedValues() async {
    final values = await _storage.readAll();
    for (final key in values.keys.where((key) => key.startsWith(namespace))) {
      await _storage.delete(key: key);
    }
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on PlatformException catch (error) {
      final code = error.code.toLowerCase();
      if (code.contains('denied') || code.contains('auth')) {
        throw const SecretStoreException(SecretStoreError.accessDenied);
      }
      if (code.contains('unavailable') || code.contains('not_available')) {
        throw const SecretStoreException(SecretStoreError.unavailable);
      }
      throw const SecretStoreException(SecretStoreError.unknown);
    }
  }
}

class InMemorySecretStore implements SecretStore {
  final Map<String, String> _values = {};

  @override
  Future<void> delete(String reference) async {
    _values.remove(reference);
  }

  @override
  Future<void> deleteAll() async {
    _values.clear();
  }

  @override
  Future<String?> read(String reference) async => _values[reference];

  @override
  Future<void> write(String reference, String secret) async {
    _values[reference] = secret;
  }
}

String maskApiKey(String secret) {
  final suffix = secret.length <= 4
      ? secret
      : secret.substring(secret.length - 4);
  return '••••••$suffix';
}
