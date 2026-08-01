import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/features/finance/presentation/finance_ui.dart';
import 'package:keyspace/features/net_worth/presentation/net_worth_screen.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';
import 'package:keyspace/features/report_export/presentation/export_config_sheet.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class FinanceDashboardScreen extends ConsumerWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePeriod = ref.watch(activeFinancePeriodProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('KEUANGAN'),
        actions: [
          IconButton(
            tooltip: 'Lihat Analitik',
            onPressed: () => context.push(AppRoutes.financeAnalytics),
            icon: const Icon(Icons.analytics_outlined),
          ),
          IconButton(
            tooltip: 'Export PDF',
            onPressed: () =>
                showExportConfigSheet(context, initialType: ReportType.finance),
            icon: const Icon(Icons.picture_as_pdf_outlined),
          ),
          IconButton(
            tooltip: 'Pengaturan keuangan',
            onPressed: () => context.push(AppRoutes.financeSettings),
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: activePeriod.when(
        data: (period) => _FinanceDashboardBody(period: period),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => EmptyState(
          title: 'RINGKASAN BELUM DAPAT DIBUKA',
          message: 'Data lokal tetap aman. Coba muat ulang halaman ini.',
          action: BrutalButton(
            label: 'COBA LAGI',
            icon: Icons.refresh,
            onPressed: () => ref.invalidate(activeFinancePeriodProvider),
          ),
        ),
      ),
    );
  }
}

class _FinanceDashboardBody extends ConsumerWidget {
  const _FinanceDashboardBody({required this.period});

  final FinancialPeriod period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(financeSummaryProvider(period.id));
    final breakdown = ref.watch(financeBreakdownProvider(period.id));
    final recent = ref.watch(recentFinanceTransactionsProvider(period.id));
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(financeSummaryProvider(period.id));
        ref.invalidate(financeBreakdownProvider(period.id));
        ref.invalidate(recentFinanceTransactionsProvider(period.id));
      },
      child: ListView(
        key: const ValueKey('finance-dashboard-list'),
        padding: const EdgeInsets.all(16),
        children: [
          BrutalCard(
            color: const Color(0xFFFFD60A),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  period.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(formatPeriodRange(period)),
                const SizedBox(height: 12),
                summary.when(
                  data: (value) => _BudgetProgress(
                    summary: value,
                    budget: period.budgetAmount,
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (_, _) =>
                      const Text('Ringkasan periode gagal dimuat.'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          NetWorthDashboardCard(period: period),
          const SizedBox(height: 16),
          summary.when(
            data: (value) => LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth >= 700
                    ? (constraints.maxWidth - 24) / 3
                    : (constraints.maxWidth - 12) / 2;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: width,
                      child: FinanceMetricCard(
                        label: 'Pengeluaran',
                        value: formatIdr(value.totalExpense),
                        icon: Icons.south_west,
                        color: const Color(0xFFFFD6A5),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: FinanceMetricCard(
                        label: 'Pemasukan',
                        value: formatIdr(value.totalIncome),
                        icon: Icons.north_east,
                        color: const Color(0xFFB7E4C7),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: FinanceMetricCard(
                        label: 'Saldo bersih',
                        value: formatIdr(value.netBalance),
                        icon: Icons.account_balance_wallet,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: FinanceMetricCard(
                        label: 'Reimburse',
                        value: formatIdr(value.totalReimburse),
                        icon: Icons.receipt_long,
                      ),
                    ),
                  ],
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          BrutalButton(
            label: 'LIHAT ANALITIK',
            icon: Icons.analytics_outlined,
            secondary: true,
            onPressed: () => context.push(AppRoutes.financeAnalytics),
          ),
          const SizedBox(height: 24),
          _SectionHeader(
            title: 'BREAKDOWN KATEGORI',
            action: 'RIWAYAT',
            onPressed: () => context.push(AppRoutes.financeHistory),
          ),
          const SizedBox(height: 10),
          breakdown.when(
            data: (values) => values.isEmpty
                ? const EmptyState(
                    title: 'BELUM ADA PENGELUARAN',
                    message: 'Catat transaksi melalui Chat atau riwayat.',
                  )
                : BrutalCard(
                    child: Column(
                      children: values
                          .map(
                            (item) => Semantics(
                              label:
                                  '${item.categoryName}, ${formatIdr(item.total)}',
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(item.categoryName),
                                trailing: Text(
                                  formatIdr(item.total),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ),
            loading: () => const LinearProgressIndicator(),
            error: (_, _) => const Text('Breakdown belum dapat dibuka.'),
          ),
          const SizedBox(height: 24),
          _SectionHeader(
            title: 'TRANSAKSI TERBARU',
            action: 'LIHAT SEMUA',
            onPressed: () => context.push(AppRoutes.financeHistory),
          ),
          const SizedBox(height: 10),
          recent.when(
            data: (values) => values.isEmpty
                ? EmptyState(
                    title: 'BELUM ADA TRANSAKSI',
                    message: 'Gunakan Chat terpadu untuk pencatatan pertama.',
                    action: BrutalButton(
                      label: 'BUKA CHAT',
                      icon: Icons.chat,
                      onPressed: () => context.go(AppRoutes.chat),
                    ),
                  )
                : Column(
                    children: values
                        .map(
                          (item) => FinanceTransactionTile(transaction: item),
                        )
                        .toList(growable: false),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const Text('Transaksi belum dapat dibuka.'),
          ),
        ],
      ),
    );
  }
}

class _BudgetProgress extends StatelessWidget {
  const _BudgetProgress({required this.summary, required this.budget});

  final FinanceSummary summary;
  final int budget;

  @override
  Widget build(BuildContext context) {
    final rawPercent = budget == 0 ? 0.0 : summary.budgetUsage / budget;
    final percent = rawPercent * 100;
    final overBudget = summary.remainingBudget < 0;
    return Semantics(
      label:
          'Budget ${formatIdr(budget)}, terpakai ${formatIdr(summary.budgetUsage)}, sisa ${formatIdr(summary.remainingBudget)}, ${percent.round()} persen',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'TERPAKAI ${formatIdr(summary.budgetUsage)}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              Text('${percent.round()}%'),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: rawPercent.clamp(0, 1),
            minHeight: 14,
            color: overBudget ? KeySpaceColors.error : KeySpaceColors.ink,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 8),
          Text('BUDGET ${formatIdr(budget)}'),
          Text(
            overBudget
                ? 'OVER BUDGET ${formatIdr(-summary.remainingBudget)}'
                : 'SISA ${formatIdr(summary.remainingBudget)}',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: overBudget ? KeySpaceColors.error : KeySpaceColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.action,
    required this.onPressed,
  });

  final String title;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        TextButton(onPressed: onPressed, child: Text(action)),
      ],
    );
  }
}
