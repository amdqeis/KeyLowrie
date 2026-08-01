import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/presentation/finance_ui.dart';
import 'package:keyspace/features/net_worth/domain/net_worth_models.dart';
import 'package:keyspace/features/net_worth/presentation/net_worth_providers.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';
import 'package:uuid/uuid.dart';

class NetWorthDashboardCard extends ConsumerWidget {
  const NetWorthDashboardCard({required this.period, super.key});

  final FinancialPeriod period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overview = ref.watch(netWorthOverviewProvider);
    return overview.when(
      loading: () => const BrutalCard(child: LinearProgressIndicator()),
      error: (_, _) => const BrutalCard(
        child: Text('Net worth belum dapat dimuat. Data lokal tetap aman.'),
      ),
      data: (value) {
        if (value == null) {
          return BrutalCard(
            color: const Color(0xFFFFE79A),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'NET WORTH BELUM DIATUR',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Atur nilai awal agar perubahan kekayaan dapat dihitung dari transaksi lokal.',
                ),
                const SizedBox(height: 12),
                BrutalButton(
                  label: 'ATUR SEKARANG',
                  icon: Icons.account_balance_wallet_outlined,
                  onPressed: () =>
                      showNetWorthInitializationDialog(context, ref),
                ),
              ],
            ),
          );
        }
        return FutureBuilder<int>(
          future: ref
              .read(netWorthRepositoryProvider)
              .calculateNetWorthChange(
                startDate: period.startDate,
                endDate: period.endDate.add(const Duration(days: 1)),
              ),
          builder: (context, change) => BrutalCard(
            color: const Color(0xFFBDE0FE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'TOTAL NET WORTH',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  formatIdr(value.currentNetWorth),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  change.hasData
                      ? 'Perubahan periode ini ${_signedIdr(change.data!)}'
                      : 'Menghitung perubahan periode…',
                ),
                Text(
                  'Diperbarui ${formatFinanceDate(value.lastUpdatedAt.toLocal())}',
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => context.push(AppRoutes.financeNetWorth),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('DETAIL'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => showNetWorthAdjustmentDialog(
                        context,
                        ref,
                        initialization: value.initialization,
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('PENYESUAIAN'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NetWorthScreen extends ConsumerWidget {
  const NetWorthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(netWorthDetailProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('DETAIL NET WORTH')),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const EmptyState(
          title: 'NET WORTH GAGAL DIMUAT',
          message: 'Coba kembali. Data lokal tidak berubah.',
        ),
        data: (value) {
          if (value == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: EmptyState(
                  title: 'NET WORTH BELUM DIATUR',
                  message: 'Masukkan nilai awal untuk memulai perhitungan.',
                  action: BrutalButton(
                    label: 'ATUR SEKARANG',
                    onPressed: () =>
                        showNetWorthInitializationDialog(context, ref),
                  ),
                ),
              ),
            );
          }
          final overview = value.overview;
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(netWorthDetailProvider),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                BrutalCard(
                  color: const Color(0xFFBDE0FE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatIdr(overview.currentNetWorth),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Nilai awal ${formatIdr(overview.initialization.initialAmount)}',
                      ),
                      Text(
                        'Sejak ${formatFinanceDate(overview.initialization.initializationDate)}',
                      ),
                      Text('Pemasukan ${formatIdr(overview.totalIncome)}'),
                      Text('Pengeluaran ${formatIdr(overview.totalExpense)}'),
                      Text(
                        'Penyesuaian ${_signedIdr(overview.totalAdjustments)}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () => showNetWorthInitializationDialog(
                        context,
                        ref,
                        existing: overview.initialization,
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text('EDIT INISIALISASI'),
                    ),
                    FilledButton.icon(
                      onPressed: () => showNetWorthAdjustmentDialog(
                        context,
                        ref,
                        initialization: overview.initialization,
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('TAMBAH PENYESUAIAN'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'HISTORI PENYESUAIAN',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                if (value.adjustments.isEmpty)
                  const EmptyState(
                    title: 'BELUM ADA PENYESUAIAN',
                    message: 'Perubahan non-transaksi akan tampil di sini.',
                  )
                else
                  ...value.adjustments.map(
                    (adjustment) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: BrutalCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(adjustment.name),
                          subtitle: Text(
                            '${formatFinanceDate(adjustment.adjustmentDate)}${adjustment.notes == null ? '' : ' • ${adjustment.notes}'}',
                          ),
                          trailing: Text(_signedIdr(adjustment.amount)),
                          onTap: () => showNetWorthAdjustmentDialog(
                            context,
                            ref,
                            initialization: overview.initialization,
                            existing: adjustment,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<void> showNetWorthInitializationDialog(
  BuildContext context,
  WidgetRef ref, {
  NetWorthInitializationModel? existing,
}) async {
  final amount = TextEditingController(
    text: existing?.initialAmount.toString() ?? '',
  );
  final notes = TextEditingController(text: existing?.notes ?? '');
  var date = existing?.initializationDate ?? DateTime.now();
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(existing == null ? 'ATUR NET WORTH' : 'EDIT NET WORTH'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (existing != null)
                const Text(
                  'Mengubah nilai atau tanggal awal akan menghitung ulang seluruh histori net worth.',
                ),
              TextField(
                controller: amount,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Nilai net worth awal',
                  prefixText: 'Rp ',
                ),
                onChanged: (_) => setState(() {}),
              ),
              TextField(
                controller: notes,
                decoration: const InputDecoration(labelText: 'Catatan'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  final selected = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                  if (selected != null) setState(() => date = selected);
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(formatFinanceDate(date)),
              ),
              const SizedBox(height: 8),
              Text(
                'Preview: ${formatIdr(int.tryParse(amount.text) ?? 0)} • IDR',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('BATAL'),
          ),
          FilledButton(
            onPressed: int.tryParse(amount.text) == null
                ? null
                : () => Navigator.pop(dialogContext, true),
            child: const Text('SIMPAN'),
          ),
        ],
      ),
    ),
  );
  if (saved != true || !context.mounted) return;
  final now = DateTime.now().toUtc();
  final model = NetWorthInitializationModel(
    id: NetWorthInitializationModel.singletonId,
    initialAmount: int.parse(amount.text),
    initializationDate: date,
    notes: notes.text,
    currencyCode: 'IDR',
    createdAt: existing?.createdAt ?? now,
    updatedAt: now,
  );
  final repository = ref.read(netWorthRepositoryProvider);
  if (existing == null) {
    await repository.saveInitialization(model);
  } else {
    final impact = await repository.countExcludedBefore(date);
    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('HITUNG ULANG HISTORI?'),
        content: Text(
          '${impact.transactions} transaksi dan ${impact.adjustments} penyesuaian sebelum tanggal baru tidak akan masuk perhitungan. Data tersebut tidak dihapus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('BATAL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('HITUNG ULANG'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await repository.updateInitialization(model);
  }
  ref.invalidate(netWorthDetailProvider);
}

Future<void> showNetWorthAdjustmentDialog(
  BuildContext context,
  WidgetRef ref, {
  required NetWorthInitializationModel initialization,
  NetWorthAdjustmentModel? existing,
}) async {
  final name = TextEditingController(text: existing?.name ?? '');
  final amount = TextEditingController(text: existing?.amount.toString() ?? '');
  final notes = TextEditingController(text: existing?.notes ?? '');
  var date = existing?.adjustmentDate ?? DateTime.now();
  final action = await showDialog<String>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(
          existing == null ? 'TAMBAH PENYESUAIAN' : 'EDIT PENYESUAIAN',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: amount,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Nilai perubahan (+/-)',
                  prefixText: 'Rp ',
                ),
              ),
              TextField(
                controller: notes,
                decoration: const InputDecoration(labelText: 'Catatan'),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  final selected = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate:
                        existing != null &&
                            existing.adjustmentDate.isBefore(
                              initialization.initializationDate,
                            )
                        ? existing.adjustmentDate
                        : initialization.initializationDate,
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                  if (selected != null) setState(() => date = selected);
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(formatFinanceDate(date)),
              ),
            ],
          ),
        ),
        actions: [
          if (existing != null)
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, 'delete'),
              child: const Text('HAPUS'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('BATAL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, 'save'),
            child: const Text('SIMPAN'),
          ),
        ],
      ),
    ),
  );
  if (action == null || !context.mounted) return;
  final repository = ref.read(netWorthRepositoryProvider);
  if (action == 'delete' && existing != null) {
    await repository.deleteAdjustment(existing.id);
  } else {
    final parsed = int.tryParse(amount.text);
    if (name.text.trim().isEmpty || parsed == null || parsed == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan nominal non-zero wajib diisi.')),
      );
      return;
    }
    final now = DateTime.now().toUtc();
    final model = NetWorthAdjustmentModel(
      id: existing?.id ?? const Uuid().v4(),
      name: name.text,
      amount: parsed,
      adjustmentDate: date,
      notes: notes.text,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    if (existing == null) {
      await repository.addAdjustment(model);
    } else {
      await repository.updateAdjustment(model);
    }
  }
  ref.invalidate(netWorthDetailProvider);
}

String _signedIdr(int value) => '${value >= 0 ? '+' : ''}${formatIdr(value)}';
