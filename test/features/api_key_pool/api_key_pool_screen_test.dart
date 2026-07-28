import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/api_key_pool/data/api_key_admin_repository.dart';
import 'package:keyspace/features/api_key_pool/presentation/api_key_pool_screen.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/providers/security_providers.dart';

void main() {
  testWidgets('valid key test shows success and updates health', (
    tester,
  ) async {
    final fixture = await _Fixture.create(_ImmediateClient(_success()));
    addTearDown(fixture.close);
    await tester.pumpWidget(fixture.widget);
    await tester.pumpAndSettle();

    await tester.tap(find.text('TES'));
    await tester.pumpAndSettle();

    expect(find.text('API key siap digunakan.'), findsOneWidget);
    expect((await fixture.repository.keys()).single.healthStatus, 'healthy');
    expect(tester.takeException(), isNull);
    await _disposeWidget(tester);
  });

  testWidgets('invalid key shows actionable error without crashing', (
    tester,
  ) async {
    final fixture = await _Fixture.create(
      _ImmediateClient(_failure(GeminiFailureCategory.invalidKey)),
    );
    addTearDown(fixture.close);
    await tester.pumpWidget(fixture.widget);
    await tester.pumpAndSettle();

    await tester.tap(find.text('TES'));
    await tester.pumpAndSettle();

    expect(
      find.text('API key tidak valid. Periksa kembali key yang dimasukkan.'),
      findsOneWidget,
    );
    expect((await fixture.repository.keys()).single.healthStatus, 'invalid');
    expect(tester.takeException(), isNull);
    await _disposeWidget(tester);
  });

  testWidgets('repeated taps start one request and disposal stays safe', (
    tester,
  ) async {
    final client = _DeferredClient();
    final fixture = await _Fixture.create(client);
    addTearDown(fixture.close);
    await tester.pumpWidget(fixture.widget);
    await tester.pumpAndSettle();

    final testButton = find.text('TES');
    await tester.tap(testButton);
    await tester.tap(testButton);
    await tester.pump();

    expect(client.calls, 1);
    expect(find.text('MENGUJI'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 1));

    expect(client.cancelled, isTrue);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _disposeWidget(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pump(const Duration(milliseconds: 1));
}

class _Fixture {
  _Fixture({
    required this.database,
    required this.repository,
    required this.widget,
  });

  final AppDatabase database;
  final ApiKeyAdminRepository repository;
  final Widget widget;

  static Future<_Fixture> create(GeminiClient client) async {
    final database = AppDatabase(NativeDatabase.memory());
    final secrets = InMemorySecretStore();
    await SettingsRepository(database).initialize();
    final repository = ApiKeyAdminRepository(database, secrets);
    await repository.add(alias: 'Utama', secret: 'private-test-value');
    final widget = ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
        secretStoreProvider.overrideWithValue(secrets),
        geminiClientProvider.overrideWithValue(client),
      ],
      child: const MaterialApp(home: ApiKeyPoolScreen()),
    );
    return _Fixture(database: database, repository: repository, widget: widget);
  }

  Future<void> close() => database.close();
}

class _ImmediateClient implements GeminiClient {
  const _ImmediateClient(this.result);

  final GeminiCallResult result;

  @override
  Future<GeminiCallResult> parseFood({
    required String secret,
    required String input,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) async => result;

  @override
  Future<GeminiCallResult> parseChat({
    required String secret,
    required String input,
    required ChatParseContext context,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) async => result;
}

class _DeferredClient implements GeminiClient {
  final Completer<GeminiCallResult> _completer = Completer<GeminiCallResult>();
  int calls = 0;
  bool cancelled = false;

  @override
  Future<GeminiCallResult> parseFood({
    required String secret,
    required String input,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) {
    calls++;
    cancellation?.onCancel(() {
      cancelled = true;
      if (!_completer.isCompleted) {
        _completer.complete(_failure(GeminiFailureCategory.cancelled));
      }
    });
    return _completer.future;
  }

  @override
  Future<GeminiCallResult> parseChat({
    required String secret,
    required String input,
    required ChatParseContext context,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) {
    calls++;
    cancellation?.onCancel(() {
      cancelled = true;
      if (!_completer.isCompleted) {
        _completer.complete(_failure(GeminiFailureCategory.cancelled));
      }
    });
    return _completer.future;
  }
}

GeminiCallSuccess _success() => const GeminiCallSuccess(
  data: <String, dynamic>{},
  latency: Duration(milliseconds: 1),
);

GeminiCallFailure _failure(GeminiFailureCategory category) => GeminiCallFailure(
  failure: GeminiFailure(category: category),
  latency: const Duration(milliseconds: 1),
);
