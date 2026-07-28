import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/features/finance/presentation/finance_ui.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class FinanceHistoryScreen extends ConsumerStatefulWidget {
  const FinanceHistoryScreen({super.key});

  @override
  ConsumerState<FinanceHistoryScreen> createState() =>
      _FinanceHistoryScreenState();
}

class _FinanceHistoryScreenState extends ConsumerState<FinanceHistoryScreen> {
  final _search = TextEditingController();
  String? _periodId;
  FinancialTransactionType? _type;
  String? _categoryId;
  bool? _isReimburse;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(activeFinancePeriodProvider);
    final periods = ref.watch(financePeriodsProvider);
    final categories = ref.watch(allFinanceCategoriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('RIWAYAT KEUANGAN'),
        actions: [
          IconButton(
            tooltip: 'Pengaturan keuangan',
            onPressed: () => context.push(AppRoutes.financeSettings),
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: periods.when(
        data: (values) {
          if (values.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_periodId == null ||
              !values.any((item) => item.id == _periodId)) {
            _periodId = values.first.id;
          }
          final selected = values.firstWhere((item) => item.id == _periodId);
          final categoryValues =
              categories.value ?? const <FinancialCategory>[];
          if (_categoryId != null &&
              !categoryValues.any((item) => item.id == _categoryId)) {
            _categoryId = null;
          }
          return _body(values, selected, categoryValues);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const EmptyState(
          title: 'RIWAYAT BELUM DAPAT DIBUKA',
          message: 'Coba kembali setelah data lokal selesai dimuat.',
        ),
      ),
    );
  }

  Widget _body(
    List<FinancialPeriod> periods,
    FinancialPeriod selected,
    List<FinancialCategory> categories,
  ) {
    final filter = FinanceTransactionFilter(
      periodId: selected.id,
      type: _type,
      categoryId: _categoryId,
      isReimburse: _isReimburse,
      search: _search.text,
    );
    final summary = ref.watch(financeSummaryProvider(selected.id));
    final breakdown = ref.watch(financeBreakdownProvider(selected.id));
    return ListView(
      key: const ValueKey('finance-history-list'),
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<String>(
          key: ValueKey('finance-period-${selected.id}'),
          isExpanded: true,
          initialValue: selected.id,
          decoration: const InputDecoration(labelText: 'Periode'),
          items: periods
              .map(
                (period) => DropdownMenuItem(
                  value: period.id,
                  child: Text('${period.name} • ${formatPeriodRange(period)}'),
                ),
              )
              .toList(growable: false),
          onChanged: (value) => setState(() => _periodId = value),
        ),
        const SizedBox(height: 12),
        summary.when(
          data: (value) => BrutalCard(
            color: const Color(0xFFFFD60A),
            child: Wrap(
              spacing: 20,
              runSpacing: 8,
              children: [
                Text('TOTAL EXPENSE ${formatIdr(value.totalExpense)}'),
                Text('TOTAL INCOME ${formatIdr(value.totalIncome)}'),
                Text(
                  'SALDO ${formatIdr(value.netBalance)}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('Total periode gagal dimuat.'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _search,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelText: 'Cari nama transaksi',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _search.text.isEmpty
                ? null
                : IconButton(
                    tooltip: 'Hapus pencarian',
                    onPressed: () {
                      _search.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.close),
                  ),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final fieldWidth = constraints.maxWidth >= 720
                ? (constraints.maxWidth - 24) / 3
                : constraints.maxWidth;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(width: fieldWidth, child: _typeFilter()),
                SizedBox(width: fieldWidth, child: _categoryFilter(categories)),
                SizedBox(width: fieldWidth, child: _reimburseFilter()),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                'TRANSAKSI',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            TextButton.icon(
              onPressed: () => context.go(AppRoutes.chat),
              icon: const Icon(Icons.add),
              label: const Text('CATAT VIA CHAT'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        StreamBuilder<List<FinanceTransactionRecord>>(
          stream: ref.read(financeRepositoryProvider).watchTransactions(filter),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const EmptyState(
                title: 'TRANSAKSI GAGAL DIMUAT',
                message: 'Ubah filter atau coba kembali.',
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final values = snapshot.data!;
            if (values.isEmpty) {
              return const EmptyState(
                title: 'TIDAK ADA HASIL',
                message: 'Belum ada transaksi yang sesuai filter ini.',
              );
            }
            return Column(
              children: values
                  .map(
                    (item) => FinanceTransactionTile(
                      transaction: item,
                      onDelete: () => _delete(item),
                    ),
                  )
                  .toList(growable: false),
            );
          },
        ),
        const SizedBox(height: 24),
        Text(
          'REKAP KATEGORI PENGELUARAN',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        breakdown.when(
          data: (values) => values.isEmpty
              ? const Text('Belum ada pengeluaran pada periode ini.')
              : BrutalCard(
                  child: Column(
                    children: values
                        .map(
                          (item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(item.categoryName),
                            trailing: Text(
                              formatIdr(item.total),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('Rekap kategori gagal dimuat.'),
        ),
      ],
    );
  }

  Widget _typeFilter() => DropdownButtonFormField<FinancialTransactionType?>(
    initialValue: _type,
    isExpanded: true,
    decoration: const InputDecoration(labelText: 'Tipe'),
    items: const [
      DropdownMenuItem(value: null, child: Text('Semua tipe')),
      DropdownMenuItem(
        value: FinancialTransactionType.expense,
        child: Text('Pengeluaran'),
      ),
      DropdownMenuItem(
        value: FinancialTransactionType.income,
        child: Text('Pemasukan'),
      ),
    ],
    onChanged: (value) => setState(() {
      _type = value;
      if (_categoryId != null) _categoryId = null;
    }),
  );

  Widget _categoryFilter(List<FinancialCategory> categories) {
    final eligible = categories
        .where((item) => _type == null || item.type == _type!.storageValue)
        .toList(growable: false);
    return DropdownButtonFormField<String?>(
      initialValue: _categoryId,
      isExpanded: true,
      decoration: const InputDecoration(labelText: 'Kategori'),
      items: [
        const DropdownMenuItem(value: null, child: Text('Semua kategori')),
        ...eligible.map(
          (item) => DropdownMenuItem(
            value: item.id,
            child: Text('${item.name}${item.isActive ? '' : ' (nonaktif)'}'),
          ),
        ),
      ],
      onChanged: (value) => setState(() => _categoryId = value),
    );
  }

  Widget _reimburseFilter() => DropdownButtonFormField<bool?>(
    initialValue: _isReimburse,
    isExpanded: true,
    decoration: const InputDecoration(labelText: 'Reimburse'),
    items: const [
      DropdownMenuItem(value: null, child: Text('Semua status')),
      DropdownMenuItem(value: true, child: Text('Reimburse')),
      DropdownMenuItem(value: false, child: Text('Bukan reimburse')),
    ],
    onChanged: (value) => setState(() => _isReimburse = value),
  );

  Future<void> _delete(FinanceTransactionRecord transaction) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('HAPUS TRANSAKSI?'),
        content: Text(
          '${transaction.name} sebesar ${formatIdr(transaction.amount)} akan dihapus permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('BATAL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('HAPUS'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(financeRepositoryProvider).deleteTransaction(transaction.id);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Transaksi dihapus.')));
  }
}
