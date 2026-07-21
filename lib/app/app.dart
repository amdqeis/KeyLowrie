import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class KeySpaceApp extends ConsumerWidget {
  const KeySpaceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(bootstrapProvider);
    if (bootstrap.isLoading) {
      return _material(
        themeMode: ThemeMode.system,
        home: const _BootstrapScreen(),
      );
    }
    if (bootstrap.hasError) {
      return _material(
        themeMode: ThemeMode.system,
        home: _RecoveryScreen(onRetry: () => ref.invalidate(bootstrapProvider)),
      );
    }
    final settings = ref.watch(settingsStreamProvider);
    if (!settings.hasValue) {
      return _material(
        themeMode: ThemeMode.system,
        home: const _BootstrapScreen(),
      );
    }
    final value = settings.requireValue;
    final location = appRouter.routeInformationProvider.value.uri.path;
    if (!value.onboardingCompleted && location != AppRoutes.onboarding) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appRouter.go(AppRoutes.onboarding);
      });
    } else if (value.onboardingCompleted && location == AppRoutes.onboarding) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appRouter.go(AppRoutes.home);
      });
    }
    return MaterialApp.router(
      title: 'KeySpace',
      debugShowCheckedModeBanner: false,
      locale: const Locale('id'),
      supportedLocales: const [Locale('id')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: KeySpaceTheme.light,
      darkTheme: KeySpaceTheme.dark,
      themeMode: _themeMode(value.themeMode),
      routerConfig: appRouter,
    );
  }

  ThemeMode _themeMode(String value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  MaterialApp _material({required ThemeMode themeMode, required Widget home}) {
    return MaterialApp(
      title: 'KeySpace',
      debugShowCheckedModeBanner: false,
      locale: const Locale('id'),
      supportedLocales: const [Locale('id')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: KeySpaceTheme.light,
      darkTheme: KeySpaceTheme.dark,
      themeMode: themeMode,
      home: home,
    );
  }
}

class _BootstrapScreen extends StatelessWidget {
  const _BootstrapScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Semantics(
          liveRegion: true,
          label: 'Membuka data lokal KeySpace',
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _RecoveryScreen extends StatelessWidget {
  const _RecoveryScreen({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PEMULIHAN DATA')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const EmptyState(
            title: 'DATA LOKAL BELUM DAPAT DIBUKA',
            message:
                'Detail teknis disembunyikan agar data dan credential tidak bocor.',
          ),
          const SizedBox(height: 16),
          BrutalButton(
            label: 'COBA LAGI',
            icon: Icons.refresh,
            onPressed: onRetry,
          ),
          const SizedBox(height: 12),
          BrutalButton(
            label: 'RESTORE — FASE 1.1',
            icon: Icons.restore,
            secondary: true,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
