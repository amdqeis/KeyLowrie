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
    final settings = bootstrap.hasValue
        ? ref.watch(settingsStreamProvider)
        : null;

    final themeMode = settings?.hasValue ?? false
        ? _themeMode(settings!.requireValue.themeMode)
        : ThemeMode.system;

    if (settings?.hasValue ?? false) {
      final value = settings!.requireValue;
      final location = appRouter.routeInformationProvider.value.uri.path;
      if (!value.onboardingCompleted && location != AppRoutes.onboarding) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          appRouter.go(AppRoutes.onboarding);
        });
      } else if (value.onboardingCompleted &&
          location == AppRoutes.onboarding) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          appRouter.go(AppRoutes.home);
        });
      }
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
      themeMode: themeMode,
      routerConfig: appRouter,
      builder: (context, routedChild) {
        if (bootstrap.isLoading) return const _BootstrapScreen();
        if (bootstrap.hasError) {
          return _RecoveryScreen(
            onRetry: () => ref.invalidate(bootstrapProvider),
          );
        }
        if (!(settings?.hasValue ?? false)) {
          return const _BootstrapScreen();
        }
        return routedChild ?? const _BootstrapScreen();
      },
    );
  }

  ThemeMode _themeMode(String value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
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
