import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/features/api_key_pool/presentation/api_key_pool_screen.dart';
import 'package:keyspace/features/dashboard/presentation/dashboard_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_analytics_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_dashboard_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_history_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_settings_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_transaction_screen.dart';
import 'package:keyspace/features/food_chat/presentation/chat_screen.dart';
import 'package:keyspace/features/food_log/presentation/food_log_editor_screen.dart';
import 'package:keyspace/features/history/presentation/history_screens.dart';
import 'package:keyspace/features/net_worth/presentation/net_worth_screen.dart';
import 'package:keyspace/features/onboarding/presentation/onboarding_screen.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';
import 'package:keyspace/features/scheduler/presentation/scheduler_screens.dart';
import 'package:keyspace/features/settings/presentation/settings_screens.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const chat = '/chat';
  static const history = '/history';
  static const historyDate = '/history/:date';
  static const foodLogEdit = '/food-log/:id/edit';
  static const insights = '/insights';
  static const scheduler = '/scheduler';
  static const schedulerNew = '/scheduler/new';
  static const schedulerDetail = '/scheduler/:id';
  static const schedulerEdit = '/scheduler/:id/edit';
  static const finance = '/finance';
  static const financeHistory = '/finance/history';
  static const financeTransaction = '/finance/transaction/:id';
  static const financeAnalytics = '/finance/analytics';
  static const financeNetWorth = '/finance/net-worth';
  static const settings = '/settings';
  static const apiKeys = '/settings/api-keys';
  static const reminders = '/settings/reminders';
  static const profile = '/settings/profile';
  static const data = '/settings/data';
  static const financeSettings = '/settings/finance';

  static String financeTransactionPath(String id) => '/finance/transaction/$id';
  static String schedulerDetailPath(String id) => '/scheduler/$id';
  static String schedulerEditPath(String id) => '/scheduler/$id/edit';

  static const all = <String>[
    onboarding,
    home,
    chat,
    history,
    historyDate,
    foodLogEdit,
    insights,
    scheduler,
    schedulerNew,
    schedulerDetail,
    schedulerEdit,
    finance,
    financeHistory,
    financeTransaction,
    financeAnalytics,
    financeNetWorth,
    settings,
    apiKeys,
    reminders,
    profile,
    data,
    financeSettings,
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
                path: AppRoutes.scheduler,
                builder: (context, state) => const SchedulerScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (context, state) => ScheduleEditorScreen(
                      initialDraft: state.extra is ScheduleDraft
                          ? state.extra! as ScheduleDraft
                          : null,
                    ),
                  ),
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        ScheduleDetailScreen(id: state.pathParameters['id']!),
                    routes: [
                      GoRoute(
                        path: 'edit',
                        builder: (context, state) => ScheduleEditorScreen(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.finance,
                builder: (context, state) => const FinanceDashboardScreen(),
                routes: [
                  GoRoute(
                    path: 'history',
                    builder: (context, state) => FinanceHistoryScreen(
                      initialStartDate: DateTime.tryParse(
                        state.uri.queryParameters['start'] ?? '',
                      ),
                      initialEndDate: DateTime.tryParse(
                        state.uri.queryParameters['end'] ?? '',
                      ),
                      initialType: state.uri.queryParameters['type'],
                      initialCategoryId:
                          state.uri.queryParameters['categoryId'],
                    ),
                  ),
                  GoRoute(
                    path: 'analytics',
                    builder: (context, state) => const FinanceAnalyticsScreen(),
                  ),
                  GoRoute(
                    path: 'net-worth',
                    builder: (context, state) => const NetWorthScreen(),
                  ),
                  GoRoute(
                    path: 'transaction/:id',
                    builder: (context, state) => FinanceTransactionScreen(
                      id: state.pathParameters['id']!,
                    ),
                  ),
                ],
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
                  GoRoute(
                    path: 'finance',
                    builder: (context, state) => const FinanceSettingsScreen(),
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
      GoRoute(
        path: AppRoutes.insights,
        redirect: (context, state) => AppRoutes.scheduler,
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
    final ink = Theme.of(context).colorScheme.onSurface;
    final paper = Theme.of(context).scaffoldBackgroundColor;

    final destinations = [
      (Icons.today_outlined, Icons.today, 'HARI INI'),
      (Icons.chat_bubble_outline, Icons.chat_bubble, 'CHAT'),
      (Icons.history, Icons.history, 'RIWAYAT'),
      (Icons.calendar_month_outlined, Icons.calendar_month, 'JADWAL'),
      (
        Icons.account_balance_wallet_outlined,
        Icons.account_balance_wallet,
        'KEUANGAN',
      ),
      (Icons.settings_outlined, Icons.settings, 'PENGATURAN'),
    ];

    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: paper,
          border: Border(top: BorderSide(color: ink, width: 3)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: destinations.asMap().entries.map((entry) {
                final i = entry.key;
                final (outIcon, activeIcon, label) = entry.value;
                final isActive = shell.currentIndex == i;
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => shell.goBranch(
                      i,
                      initialLocation: i == shell.currentIndex,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? KeySpaceColors.signalYellow
                            : Colors.transparent,
                        border: Border.all(
                          color: isActive ? ink : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isActive ? activeIcon : outIcon,
                            size: 20,
                            color: ink,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.4,
                              color: ink,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
