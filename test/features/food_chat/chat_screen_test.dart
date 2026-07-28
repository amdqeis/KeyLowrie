import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/data/chat_draft_repository.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/gemini_failover_service.dart';
import 'package:keyspace/features/food_chat/presentation/chat_screen.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';
import 'package:keyspace/features/voice_input/domain/voice_input_models.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/providers/security_providers.dart';

import '../../helpers/fakes.dart';

void main() {
  testWidgets(
    'all failed keys show recovery actions without navigation crash',
    (tester) async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      await SettingsRepository(database).initialize();
      final secrets = InMemorySecretStore();
      await secrets.write('A', 'secret-A');
      await secrets.write('B', 'secret-B');
      final service = GeminiFailoverService(
        client: FakeGeminiClient([
          _failure(GeminiFailureCategory.invalidKey),
          _failure(GeminiFailureCategory.permission),
        ]),
        keyPool: FakeKeyPoolRepository(
          keys: const [
            ApiKeyCandidate(
              id: 'A',
              secureRef: 'A',
              priorityOrder: 1,
              isEnabled: true,
              health: ApiKeyHealth.untested,
            ),
            ApiKeyCandidate(
              id: 'B',
              secureRef: 'B',
              priorityOrder: 2,
              isEnabled: true,
              health: ApiKeyHealth.untested,
            ),
          ],
          activeId: 'A',
        ),
        pendingRequests: FakePendingRequestRepository(),
        secretStore: secrets,
        networkStatus: const StaticNetworkStatus(true),
        clock: FixedClock(DateTime.utc(2026, 7, 22)),
        createRequestId: () => 'request-screen',
      );
      final router = GoRouter(
        initialLocation: AppRoutes.chat,
        routes: [
          GoRoute(
            path: AppRoutes.chat,
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: AppRoutes.apiKeys,
            builder: (context, state) =>
                const Scaffold(body: Text('KEY MANAGEMENT TARGET')),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(database),
            secretStoreProvider.overrideWithValue(secrets),
            geminiFailoverServiceProvider.overrideWithValue(service),
            localTimezoneProvider.overrideWith((_) async => 'Asia/Jakarta'),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextField).last,
        'nasi goreng dan telur',
      );
      await tester.tap(find.byTooltip('Kirim'));
      await tester.pumpAndSettle();

      final dialog = find.byType(AlertDialog);
      expect(
        find.text('SEMUA API KEY GAGAL'),
        findsOneWidget,
        reason: tester
            .widgetList<Text>(find.byType(Text))
            .map((widget) => widget.data)
            .whereType<String>()
            .join(' | '),
      );
      expect(
        find.descendant(of: dialog, matching: find.text('TAMBAH API KEY')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('KELOLA')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('CATAT MANUAL')),
        findsOneWidget,
      );
      expect(
        (await ChatDraftRepository(database).latest())?.draftText,
        'nasi goreng dan telur',
      );
      expect(tester.takeException(), isNull);

      await tester.tap(
        find.descendant(of: dialog, matching: find.text('KELOLA')),
      );
      await tester.pumpAndSettle();
      expect(find.text('KEY MANAGEMENT TARGET'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(milliseconds: 1));
    },
  );

  testWidgets(
    'voice disclosure tampil sekali dan hasil hanya menjadi editable draft',
    (tester) async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final settings = SettingsRepository(database);
      await settings.initialize();
      final speech = FakeSpeechRecognitionService();
      final client = FakeGeminiClient([]);
      final router = GoRouter(
        initialLocation: AppRoutes.chat,
        routes: [
          GoRoute(path: AppRoutes.chat, builder: (_, _) => const ChatScreen()),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(database),
            speechRecognitionServiceProvider.overrideWithValue(speech),
            geminiClientProvider.overrideWithValue(client),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Mulai input suara'), findsOneWidget);
      await tester.tap(find.byTooltip('Mulai input suara'));
      await tester.pumpAndSettle();

      const disclosure =
          'Fitur suara mengubah ucapan menjadi teks. Bergantung pada layanan\n'
          'speech recognition perangkat, audio dapat diproses secara online\n'
          'oleh penyedia sistem operasi. KeySpace tidak menyimpan rekaman audio.';
      expect(find.text(disclosure), findsOneWidget);
      await tester.tap(find.text('LANJUTKAN'));
      await tester.pumpAndSettle();

      expect(speech.startCalls, 1);
      expect(find.text('STOP SUARA'), findsOneWidget);
      final send = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.send),
      );
      expect(send.onPressed, isNull);

      speech.emitResult('makan nasi', isFinal: false);
      await tester.pump();
      speech.emitResult('makan nasi dan ayam', isFinal: true);
      speech.emitStatus('done');
      await tester.pump();

      final composer = tester.widget<TextField>(find.byType(TextField).last);
      expect(composer.controller?.text, 'makan nasi dan ayam');
      expect(composer.focusNode?.hasFocus, isTrue);
      expect(client.calls, isEmpty, reason: 'voice tidak boleh auto-send');
      expect(
        (await settings.getSettings()).voiceDisclosureAcknowledged,
        isTrue,
      );

      await tester.enterText(
        find.byType(TextField).last,
        'makan nasi dan ayam bakar',
      );
      expect(
        tester.widget<TextField>(find.byType(TextField).last).controller?.text,
        'makan nasi dan ayam bakar',
      );

      await tester.tap(find.byTooltip('Mulai input suara'));
      await tester.pump();
      expect(find.text('PRIVASI INPUT SUARA'), findsNothing);
      expect(speech.startCalls, 2);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(milliseconds: 1));
      expect(
        speech.cancelCalls,
        greaterThanOrEqualTo(1),
        reason: 'halaman ditutup harus membatalkan sesi aktif',
      );
    },
  );

  testWidgets('permission denied tetap menyediakan input dan app settings', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final settings = SettingsRepository(database);
    await settings.initialize();
    await settings.acknowledgeVoiceDisclosure();
    final speech = FakeSpeechRecognitionService()
      ..permission = VoicePermissionState.denied
      ..requestedPermission = VoicePermissionState.permanentlyDenied;
    final router = GoRouter(
      initialLocation: AppRoutes.chat,
      routes: [
        GoRoute(path: AppRoutes.chat, builder: (_, _) => const ChatScreen()),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          speechRecognitionServiceProvider.overrideWithValue(speech),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Mulai input suara'));
    await tester.pumpAndSettle();

    expect(find.textContaining('IZIN MIKROFON DITOLAK'), findsOneWidget);
    expect(find.text('BUKA PENGATURAN APLIKASI'), findsOneWidget);
    expect(find.bySemanticsLabel('Input suara, izin ditolak'), findsOneWidget);
    await tester.enterText(
      find.byType(TextField).last,
      'input manual tetap ada',
    );
    expect(find.text('input manual tetap ada'), findsOneWidget);

    await tester.tap(find.text('BUKA PENGATURAN APLIKASI'));
    await tester.pump();
    expect(speech.settingsCalls, 1);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 1));
  });

  testWidgets(
    'financial review supports reimburse, conversion, deletion, and atomic save',
    (tester) async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      await SettingsRepository(database).initialize();
      final service = await _unifiedService([
        GeminiCallSuccess(
          data: _expenseResponse(),
          latency: const Duration(milliseconds: 1),
        ),
      ]);
      final router = GoRouter(
        initialLocation: AppRoutes.chat,
        routes: [
          GoRoute(path: AppRoutes.chat, builder: (_, _) => const ChatScreen()),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(database),
            geminiFailoverServiceProvider.overrideWithValue(service),
            localTimezoneProvider.overrideWith((_) async => 'Asia/Jakarta'),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pengeluaran').first);
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('composer-reimburse-toggle')));
      await tester.enterText(
        find.byType(TextField).last,
        'bensin 100 ribu dan makan 35 ribu',
      );
      await tester.tap(find.byTooltip('Kirim'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('REVIEW TRANSAKSI — EDIT LANGSUNG'),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      expect(
        find.text('REVIEW TRANSAKSI — EDIT LANGSUNG'),
        findsOneWidget,
        reason: tester
            .widgetList<Text>(find.byType(Text))
            .map((widget) => widget.data)
            .whereType<String>()
            .join(' | '),
      );
      final reviewSwitches = tester
          .widgetList<Switch>(find.byType(Switch))
          .where((widget) => widget.value)
          .length;
      expect(reviewSwitches, greaterThanOrEqualTo(2));

      final typeKey = _keyStarting('review-type-').first;
      await _centerInViewport(tester, typeKey);
      await tester.tap(typeKey);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pemasukan').last);
      await tester.pumpAndSettle();

      final name = _keyStarting('review-name-').first;
      await _centerInViewport(tester, name);
      await tester.enterText(name, 'Refund bensin');
      final amount = _keyStarting('review-amount-').first;
      await _centerInViewport(tester, amount);
      await tester.enterText(amount, '125000');
      final deleteSecond = find.byTooltip('Hapus item 2');
      await _centerInViewport(tester, deleteSecond);
      final deleteButton = tester.widget<IconButton>(
        find.ancestor(
          of: find.byIcon(Icons.delete_outline).last,
          matching: find.byType(IconButton),
        ),
      );
      deleteButton.onPressed!();
      await tester.pumpAndSettle();
      expect(find.byTooltip('Hapus item 2'), findsNothing);

      final save = find.text('SIMPAN SEMUA');
      await _centerInViewport(tester, save);
      await tester.tap(save);
      await tester.pumpAndSettle();

      final rows = await database.select(database.financialTransactions).get();
      expect(rows, hasLength(1));
      expect(rows.single.type, 'income');
      expect(rows.single.name, 'Refund bensin');
      expect(rows.single.amount, 125000);
      expect(rows.single.isReimburse, isFalse);
      expect(await ChatDraftRepository(database).latest(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(milliseconds: 1));
    },
  );

  testWidgets('unified nutrition still previews and confirms Food Log', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await SettingsRepository(database).initialize();
    await _seedApiKeyMetadata(database);
    final food = validFoodResponse();
    final service = await _unifiedService([
      GeminiCallSuccess(
        data: {
          'detected_domain': 'nutrition',
          'confidence': 0.9,
          'requires_clarification': false,
          'clarification_question': null,
          'items': food['items'],
          'nutrition_summary': food['summary'],
        },
        latency: const Duration(milliseconds: 1),
      ),
    ], requestId: 'request-nutrition');
    final router = GoRouter(
      initialLocation: AppRoutes.chat,
      routes: [
        GoRoute(path: AppRoutes.chat, builder: (_, _) => const ChatScreen()),
        GoRoute(
          path: '/food-log/:id/edit',
          builder: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          geminiFailoverServiceProvider.overrideWithValue(service),
          localTimezoneProvider.overrideWith((_) async => 'Asia/Jakarta'),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'nasi goreng');
    await tester.tap(find.byTooltip('Kirim'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('PREVIEW — TINJAU DULU'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('PREVIEW — TINJAU DULU'), findsOneWidget);

    await tester.tap(find.text('SIMPAN').last);
    await tester.pumpAndSettle();
    final logs = await database.select(database.foodLogs).get();
    expect(logs.single.status, 'confirmed');
    expect(logs.single.totalCaloriesKcal, 640);
    expect(await ChatDraftRepository(database).latest(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 1));
  });
}

GeminiCallFailure _failure(GeminiFailureCategory category) => GeminiCallFailure(
  failure: GeminiFailure(category: category),
  latency: const Duration(milliseconds: 1),
);

Future<GeminiFailoverService> _unifiedService(
  List<GeminiCallResult> results, {
  String requestId = 'request-finance',
}) async {
  final secrets = InMemorySecretStore();
  await secrets.write('ref-A', 'secret-A');
  return GeminiFailoverService(
    client: FakeGeminiClient(results),
    keyPool: FakeKeyPoolRepository(
      keys: const [
        ApiKeyCandidate(
          id: 'A',
          secureRef: 'ref-A',
          priorityOrder: 1,
          isEnabled: true,
          health: ApiKeyHealth.healthy,
        ),
      ],
      activeId: 'A',
    ),
    pendingRequests: FakePendingRequestRepository(),
    secretStore: secrets,
    networkStatus: const StaticNetworkStatus(true),
    clock: FixedClock(DateTime.utc(2026, 7, 22)),
    createRequestId: () => requestId,
  );
}

Future<void> _seedApiKeyMetadata(AppDatabase database) async {
  final now = DateTime.utc(2026, 7, 22);
  await database
      .into(database.apiKeyMetadata)
      .insert(
        ApiKeyMetadataCompanion.insert(
          id: 'A',
          alias: 'Test key',
          secureRef: 'ref-A',
          maskedSuffix: '...t-A',
          priorityOrder: 1,
          isEnabled: true,
          healthStatus: 'healthy',
          createdAt: now,
          updatedAt: now,
        ),
      );
}

Map<String, dynamic> _expenseResponse() => {
  'detected_domain': 'expense',
  'confidence': 0.95,
  'requires_clarification': false,
  'clarification_question': null,
  'items': [
    {
      'name': 'Bensin',
      'amount': 100000,
      'currency': 'IDR',
      'transaction_date': '2026-07-22',
      'category': 'Transportasi',
    },
    {
      'name': 'Makan',
      'amount': 35000,
      'currency': 'IDR',
      'transaction_date': '2026-07-22',
      'category': 'Makanan dan Minuman',
    },
  ],
  'nutrition_summary': null,
};

Finder _keyStarting(String prefix) {
  return find.byWidgetPredicate((widget) {
    final key = widget.key;
    return key is ValueKey<String> && key.value.startsWith(prefix);
  });
}

Future<void> _centerInViewport(WidgetTester tester, Finder finder) async {
  await Scrollable.ensureVisible(
    tester.element(finder),
    alignment: 0.5,
    duration: Duration.zero,
  );
  await tester.pumpAndSettle();
}
