import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/reminders/domain/reminder_scheduler.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/providers/security_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

void main() {
  testWidgets('seluruh route SRS membuka layar Fase 1', (tester) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await SettingsRepository(database).initialize();
    final cases = <String, String>{
      '/onboarding': 'CATAT MAKANAN',
      '/home': 'HARI INI',
      '/chat': 'CHAT TERPADU',
      '/history': 'RIWAYAT HARIAN',
      '/history/2026-07-21': 'RIWAYAT 2026-07-21',
      '/food-log/log-1/edit': 'EDIT FOOD LOG',
      '/insights': 'JADWAL',
      '/scheduler': 'JADWAL',
      '/scheduler/new': 'BUAT JADWAL',
      '/scheduler/missing': 'Jadwal tidak ditemukan',
      '/finance': 'KEUANGAN',
      '/finance/history': 'RIWAYAT KEUANGAN',
      '/finance/transaction/missing': 'DETAIL TRANSAKSI',
      '/settings': 'PENGATURAN',
      '/settings/api-keys': 'API KEY POOL',
      '/settings/reminders': 'REMINDER DASAR',
      '/settings/profile': 'TARGET & PROFIL',
      '/settings/data': 'PRIVASI & DATA',
      '/settings/finance': 'PENGATURAN KEUANGAN',
    };

    for (final entry in cases.entries) {
      final router = createAppRouter(initialLocation: entry.key);
      await tester.pumpWidget(_testApp(database, router));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text(entry.value), findsWidgets, reason: entry.key);
      expect(tester.takeException(), isNull, reason: entry.key);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      router.dispose();
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(milliseconds: 1));
    }
  });

  testWidgets('baseline neo-brutalist memakai paper dan hard border', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await SettingsRepository(database).initialize();
    final router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(database, router));
    await tester.pump(const Duration(seconds: 1));

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
    final theme = Theme.of(tester.element(find.byType(Scaffold).first));
    final shape = theme.cardTheme.shape! as RoundedRectangleBorder;

    expect(scaffold.backgroundColor, isNull);
    expect(theme.scaffoldBackgroundColor, KeySpaceColors.paper);
    expect(theme.cardTheme.elevation, 0);
    expect(shape.side.width, 3);
    expect(shape.side.color, KeySpaceColors.ink);
    expect(find.byType(BrutalCard), findsOneWidget);
  });
}

Widget _testApp(AppDatabase database, GoRouter router) {
  return ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(database),
      secretStoreProvider.overrideWithValue(InMemorySecretStore()),
      networkStatusProvider.overrideWithValue(const StaticNetworkStatus(false)),
      reminderSchedulerProvider.overrideWithValue(
        const NoopReminderScheduler(),
      ),
    ],
    child: MaterialApp.router(
      title: 'KeySpace Test',
      theme: KeySpaceTheme.light,
      darkTheme: KeySpaceTheme.dark,
      routerConfig: router,
    ),
  );
}
