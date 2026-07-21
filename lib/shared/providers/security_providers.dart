import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/core/security/secret_store.dart';

final secretStoreProvider = Provider<SecretStore>(
  (ref) => const FlutterSecureSecretStore(),
);
