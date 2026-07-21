import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/features/api_key_pool/presentation/api_key_pool_screen.dart';
import 'package:keyspace/features/dashboard/presentation/dashboard_screen.dart';
import 'package:keyspace/features/food_chat/presentation/chat_screen.dart';
import 'package:keyspace/features/food_log/presentation/food_log_editor_screen.dart';
import 'package:keyspace/features/history/presentation/history_screens.dart';
import 'package:keyspace/features/onboarding/presentation/onboarding_screen.dart';
import 'package:keyspace/features/settings/presentation/settings_screens.dart';
import 'package:keyspace/shared/widgets/placeholder_screen.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const chat = '/chat';
  static const history = '/history';
  static const historyDate = '/history/:date';
  static const foodLogEdit = '/food-log/:id/edit';
  static const insights = '/insights';
  static const settings = '/settings';
  static const apiKeys = '/settings/api-keys';
  static const reminders = '/settings/reminders';
  static const profile = '/settings/profile';
  static const data = '/settings/data';

  static const all = <String>[
    onboarding,
    home,
    chat,
    history,
    historyDate,
    foodLogEdit,
    insights,
    settings,
    apiKeys,
    reminders,
    profile,
    data,
  ];
}

GoRouter createAppRouter({String initialLocation = AppRoutes.onboarding}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.chat,
                builder: (context, state) => const ChatScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: ':date',
                    builder: (context, state) =>
                        HistoryDateScreen(date: state.pathParameters['date']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.insights,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'INSIGHT'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: 'api-keys',
                    builder: (context, state) => ApiKeyPoolScreen(
                      returnToPending:
                          state.uri.queryParameters['returnTo'] ==
                          'pendingRequest',
                    ),
                  ),
                  GoRoute(
                    path: 'reminders',
                    builder: (context, state) => const ReminderSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'profile',
                    builder: (context, state) => const TargetProfileScreen(),
                  ),
                  GoRoute(
                    path: 'data',
                    builder: (context, state) => const PrivacyDataScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.foodLogEdit,
        builder: (context, state) => FoodLogEditorScreen(
          id: state.pathParameters['id']!,
          initialDate: state.uri.queryParameters['date'],
        ),
      ),
    ],
  );
}

final appRouter = createAppRouter();

class _MainShell extends StatelessWidget {
  const _MainShell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: KeySpaceColors.ink, width: 3)),
        ),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          indicatorColor: KeySpaceColors.signalYellow,
          onDestinationSelected: (index) => shell.goBranch(
            index,
            initialLocation: index == shell.currentIndex,
          ),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.today), label: 'Hari Ini'),
            NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
            NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'),
            NavigationDestination(
              icon: Icon(Icons.bar_chart),
              label: 'Insight',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Pengaturan',
            ),
          ],
        ),
      ),
    );
  }
}
