import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/core/security/secret_store.dart';

void main() {
  group('SecretStore contract', () {
    test('in-memory implementation supports CRUD and delete-all', () async {
      final store = InMemorySecretStore();
      await store.write('a', 'value-a');
      await store.write('b', 'value-b');
      expect(await store.read('a'), 'value-a');
      await store.delete('a');
      expect(await store.read('a'), isNull);
      await store.deleteAll();
      expect(await store.read('b'), isNull);
    });

    test('mask exposes at most the final four characters', () {
      expect(maskApiKey('long-secret-A1B2'), '••••••A1B2');
      expect(maskApiKey('A1'), '••••••A1');
    });

    test(
      'production adapter maps platform errors without raw detail',
      () async {
        final store = FlutterSecureSecretStore(storage: _ThrowingStorage());
        await expectLater(
          store.read('ref'),
          throwsA(
            isA<SecretStoreException>().having(
              (error) => error.error,
              'error',
              SecretStoreError.accessDenied,
            ),
          ),
        );
      },
    );
  });
}

class _ThrowingStorage extends FlutterSecureStorage {
  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) {
    throw PlatformException(code: 'access_denied', message: 'redacted');
  }
}
