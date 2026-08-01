import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/features/finance/presentation/finance_ui.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

enum _AnalyticsPeriod { active, previous, sevenDays, thirtyDays, month, custom }

class FinanceAnalyticsScreen extends ConsumerStatefulWidget {
  const FinanceAnalyticsScreen({super.key});

  @override
  ConsumerState<FinanceAnalyticsScreen> createState() =>
      _FinanceAnalyticsScreenState();
}

class _FinanceAnalyticsScreenState
    extends ConsumerState<FinanceAnalyticsScreen> {
  _AnalyticsPeriod _period = _AnalyticsPeriod.active;
  FinanceAnalyticsType _type = FinanceAnalyticsType.all;
  DateTime? _customStart;
  DateTime? _customEnd;

  @override
  Widget build(BuildContext context) {
    final active = ref.watch(activeFinancePeriodProvider);
    final periods = ref.watch(financePeriodsProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: const Text('ANALITIK KEUANGAN')),
      body: active.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const EmptyState(
          title: 'ANALITIK BELUM DAPAT DIBUKA',
          message: 'Data lokal tetap aman. Coba kembali.',
        ),
        data: (activePeriod) {
          final filter = _filter(activePeriod, periods);
          final analytics = ref.watch(financeAnalyticsProvider(filter));
          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(financeAnalyticsProvider(filter)),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _filters(activePeriod, periods),
                const SizedBox(height: 16),
                analytics.when(
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, _) => const EmptyState(
                    title: 'DATA ANALITIK GAGAL DIMUAT',
                    message: 'Ubah filter atau coba kembali.',
                  ),
                  data: (data) => _content(data),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _filters(FinancialPeriod active, List<FinancialPeriod> periods) {
    return BrutalCard(
      color: const Color(0xFFFFE79A),
      child: Column(
        children: [
          DropdownButtonFormField<_AnalyticsPeriod>(
            initialValue: _period,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Periode'),
            items: const [
              DropdownMenuItem(
                value: _AnalyticsPeriod.active,
                child: Text('Periode aktif'),
              ),
              DropdownMenuItem(
                value: _AnalyticsPeriod.previous,
                child: Text('Periode sebelumnya'),
              ),
              DropdownMenuItem(
                value: _AnalyticsPeriod.sevenDays,
                child: Text('7 hari terakhir'),
              ),
              DropdownMenuItem(
                value: _AnalyticsPeriod.thirtyDays,
                child: Text('30 hari terakhir'),
              ),
              DropdownMenuItem(
                value: _AnalyticsPeriod.month,
                child: Text('Bulan kalender'),
              ),
              DropdownMenuItem(
                value: _AnalyticsPeriod.custom,
                child: Text('Rentang tanggal kustom'),
              ),
            ],
            onChanged: (value) async {
              if (value == null) return;
              if (value == _AnalyticsPeriod.custom) {
                await _pickCustomRange();
              }
              if (mounted) setState(() => _period = value);
            },
          ),
          const SizedBox(height: 12),
          SegmentedButton<FinanceAnalyticsType>(
            segments: const [
              ButtonSegment(
                value: FinanceAnalyticsType.all,
                label: Text('Semua'),
              ),
              ButtonSegment(
                value: FinanceAnalyticsType.expense,
                label: Text('Pengeluaran'),
              ),
              ButtonSegment(
                value: FinanceAnalyticsType.income,
                label: Text('Pemasukan'),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (value) => setState(() => _type = value.first),
          ),
        ],
      ),
    );
  }

  Widget _content(FinanceAnalyticsData data) {
    final hasExpense = _type != FinanceAnalyticsType.income;
    final hasIncome = _type != FinanceAnalyticsType.expense;
    final hasData =
        data.summary.totalExpense != 0 || data.summary.totalIncome != 0;
    if (!hasData) {
      return const EmptyState(
        title: 'BELUM ADA DATA',
        message: 'Tidak ada transaksi pada rentang dan tipe yang dipilih.',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth >= 700
                ? (constraints.maxWidth - 24) / 3
                : (constraints.maxWidth - 12) / 2;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                if (hasExpense)
                  _metric(
                    width,
                    'Total pengeluaran',
                    data.summary.totalExpense,
                  ),
                if (hasIncome)
                  _metric(width, 'Total pemasukan', data.summary.totalIncome),
                _metric(width, 'Saldo bersih', data.summary.netBalance),
                if (hasExpense)
                  _metric(
                    width,
                    'Rata-rata keluar/hari',
                    data.summary.averageExpensePerDay,
                  ),
                if (hasIncome)
                  _metric(
                    width,
                    'Rata-rata masuk/hari',
                    data.summary.averageIncomePerDay,
                  ),
                if (hasExpense)
                  _metric(
                    width,
                    'Total reimburse',
                    data.summary.totalReimburse,
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        BrutalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasExpense)
                Text(
                  'Kategori pengeluaran terbesar: ${data.summary.largestExpenseCategory?.categoryName ?? '-'}',
                ),
              if (hasIncome)
                Text(
                  'Kategori pemasukan terbesar: ${data.summary.largestIncomeCategory?.categoryName ?? '-'}',
                ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        if (hasExpense)
          _CategoryChart(
            title: 'PENGELUARAN PER KATEGORI',
            values: data.expensesByCategory,
            colors: _expenseColors,
            onCategory: (item) => _openCategory(data, item, 'expense'),
          ),
        if (hasIncome) ...[
          const SizedBox(height: 16),
          _CategoryChart(
            title: 'PEMASUKAN PER KATEGORI',
            values: data.incomeByCategory,
            colors: _incomeColors,
            onCategory: (item) => _openCategory(data, item, 'income'),
          ),
        ],
        const SizedBox(height: 16),
        _TrendChart(data: data),
        if (_type == FinanceAnalyticsType.all) ...[
          const SizedBox(height: 16),
          _ComparisonChart(summary: data.summary),
        ],
      ],
    );
  }

  Widget _metric(double width, String label, int amount) => SizedBox(
    width: width,
    child: FinanceMetricCard(
      label: label,
      value: formatIdr(amount),
      icon: Icons.analytics_outlined,
    ),
  );

  FinanceAnalyticsFilter _filter(
    FinancialPeriod active,
    List<FinancialPeriod> periods,
  ) {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    late DateTime start;
    late DateTime end;
    switch (_period) {
      case _AnalyticsPeriod.active:
        start = active.startDate;
        end = active.endDate.add(const Duration(days: 1));
      case _AnalyticsPeriod.previous:
        final previous = periods
            .where((item) => item.endDate.isBefore(active.startDate))
            .firstOrNull;
        start = previous?.startDate ?? active.startDate;
        end = (previous?.endDate ?? active.endDate).add(
          const Duration(days: 1),
        );
      case _AnalyticsPeriod.sevenDays:
        start = date.subtract(const Duration(days: 6));
        end = date.add(const Duration(days: 1));
      case _AnalyticsPeriod.thirtyDays:
        start = date.subtract(const Duration(days: 29));
        end = date.add(const Duration(days: 1));
      case _AnalyticsPeriod.month:
        start = DateTime(date.year, date.month);
        end = DateTime(date.year, date.month + 1);
      case _AnalyticsPeriod.custom:
        start = _customStart ?? date.subtract(const Duration(days: 6));
        end = (_customEnd ?? date).add(const Duration(days: 1));
    }
    return FinanceAnalyticsFilter(startDate: start, endDate: end, type: _type);
  }

  Future<void> _pickCustomRange() async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: now.add(const Duration(days: 3650)),
      initialDateRange: DateTimeRange(
        start: _customStart ?? now.subtract(const Duration(days: 6)),
        end: _customEnd ?? now,
      ),
    );
    if (range != null) {
      _customStart = range.start;
      _customEnd = range.end;
    }
  }

  void _openCategory(
    FinanceAnalyticsData data,
    CategoryFinanceSummary item,
    String type,
  ) {
    final start = _dateKey(data.filter.startDate);
    final end = _dateKey(data.filter.endDate);
    context.push(
      '${AppRoutes.financeHistory}?start=$start&end=$end&type=$type&categoryId=${Uri.encodeQueryComponent(item.categoryId)}',
    );
  }

  String _dateKey(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';
}

class _CategoryChart extends StatelessWidget {
  const _CategoryChart({
    required this.title,
    required this.values,
    required this.colors,
    required this.onCategory,
  });

  final String title;
  final List<CategoryFinanceSummary> values;
  final List<Color> colors;
  final ValueChanged<CategoryFinanceSummary> onCategory;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title, ${values.length} kategori',
      child: BrutalCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            SizedBox(
              height: values.length > 6 ? 320 : 220,
              child: values.length > 6
                  ? RotatedBox(quarterTurns: 1, child: _bar())
                  : _pie(),
            ),
            ...values.asMap().entries.map(
              (entry) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 7,
                  backgroundColor: colors[entry.key % colors.length],
                ),
                title: Text(entry.value.categoryName),
                subtitle: Text('${entry.value.percentage.toStringAsFixed(1)}%'),
                trailing: Text(formatIdr(entry.value.totalAmount)),
                onTap: () => onCategory(entry.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pie() => PieChart(
    PieChartData(
      sectionsSpace: 2,
      pieTouchData: PieTouchData(
        touchCallback: (event, response) {
          if (!event.isInterestedForInteractions) return;
          final index = response?.touchedSection?.touchedSectionIndex;
          if (index != null && index >= 0 && index < values.length) {
            onCategory(values[index]);
          }
        },
      ),
      sections: values
          .asMap()
          .entries
          .map(
            (entry) => PieChartSectionData(
              value: entry.value.totalAmount.toDouble(),
              color: colors[entry.key % colors.length],
              title: '${entry.value.percentage.round()}%',
              radius: 75,
              titleStyle: const TextStyle(fontWeight: FontWeight.w900),
            ),
          )
          .toList(growable: false),
    ),
  );

  Widget _bar() {
    final maxValue = values.fold<int>(
      0,
      (max, row) => math.max(max, row.totalAmount),
    );
    return BarChart(
      BarChartData(
        maxY: maxValue == 0 ? 1 : maxValue.toDouble(),
        barTouchData: BarTouchData(
          touchCallback: (event, response) {
            if (!event.isInterestedForInteractions) return;
            final index = response?.spot?.touchedBarGroupIndex;
            if (index != null && index >= 0 && index < values.length) {
              onCategory(values[index]);
            }
          },
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                BarTooltipItem(
                  formatIdr(values[group.x].totalAmount),
                  const TextStyle(fontWeight: FontWeight.w900),
                ),
          ),
        ),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        barGroups: values
            .asMap()
            .entries
            .map(
              (entry) => BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    toY: entry.value.totalAmount.toDouble(),
                    width: 18,
                    color: colors[entry.key % colors.length],
                  ),
                ],
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.data});
  final FinanceAnalyticsData data;

  @override
  Widget build(BuildContext context) {
    final expense = data.filter.type != FinanceAnalyticsType.income;
    final income = data.filter.type != FinanceAnalyticsType.expense;
    return BrutalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'TREN ${data.filter.granularity.name.toUpperCase()}',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: LineChart(
              LineChartData(
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: true),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => spots
                        .map(
                          (spot) => LineTooltipItem(
                            formatIdr(spot.y.round()),
                            const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
                lineBarsData: [
                  if (expense)
                    LineChartBarData(
                      color: const Color(0xFFE76F51),
                      spots: data.trend
                          .asMap()
                          .entries
                          .map(
                            (entry) => FlSpot(
                              entry.key.toDouble(),
                              entry.value.expenseAmount.toDouble(),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  if (income)
                    LineChartBarData(
                      color: const Color(0xFF2A9D8F),
                      spots: data.trend
                          .asMap()
                          .entries
                          .map(
                            (entry) => FlSpot(
                              entry.key.toDouble(),
                              entry.value.incomeAmount.toDouble(),
                            ),
                          )
                          .toList(growable: false),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonChart extends StatelessWidget {
  const _ComparisonChart({required this.summary});
  final FinanceAnalyticsSummary summary;

  @override
  Widget build(BuildContext context) => BrutalCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'PERBANDINGAN PENGELUARAN & PEMASUKAN',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: BarChart(
            BarChartData(
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                      BarTooltipItem(
                        formatIdr(rod.toY.round()),
                        const TextStyle(fontWeight: FontWeight.w900),
                      ),
                ),
              ),
              barGroups: [
                _group(0, summary.totalExpense, const Color(0xFFE76F51)),
                _group(1, summary.totalIncome, const Color(0xFF2A9D8F)),
                _group(2, summary.netBalance, const Color(0xFF457B9D)),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  BarChartGroupData _group(int index, int amount, Color color) =>
      BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(toY: amount.toDouble(), color: color, width: 28),
        ],
      );
}

const _expenseColors = [
  Color(0xFFE76F51),
  Color(0xFFF4A261),
  Color(0xFFE9C46A),
  Color(0xFF9B5DE5),
  Color(0xFFF15BB5),
  Color(0xFFFF6B6B),
];

const _incomeColors = [
  Color(0xFF2A9D8F),
  Color(0xFF52B788),
  Color(0xFF90BE6D),
  Color(0xFF43AA8B),
  Color(0xFF4D908E),
  Color(0xFF577590),
];
