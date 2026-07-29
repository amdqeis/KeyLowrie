import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/app/app.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/providers/security_providers.dart';

void main() {
  testWidgets('bootstrap and settings updates keep one stable MaterialApp', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final settings = SettingsRepository(database);
    await settings.initialize();
    final bootstrap = Completer<void>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          secretStoreProvider.overrideWithValue(InMemorySecretStore()),
          bootstrapProvider.overrideWith((ref) => bootstrap.future),
        ],
        child: const KeySpaceApp(),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.takeException(), isNull);

    bootstrap.complete();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(tester.takeException(), isNull);

    await settings.setThemeMode('dark');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 1));
  });
}
