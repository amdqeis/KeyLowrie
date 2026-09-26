import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/features/finance/presentation/finance_ui.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class InstallmentDetailScreen extends ConsumerWidget {
  const InstallmentDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(installmentPlanDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('DETAIL CICILAN')),
      body: plan.when(
        data: (value) => value == null
            ? const EmptyState(
                title: 'CICILAN TIDAK DITEMUKAN',
                message: 'Data mungkin telah dihapus.',
              )
            : _DetailBody(plan: value),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const EmptyState(
          title: 'DETAIL BELUM DAPAT DIBUKA',
          message: 'Coba kembali dari halaman sebelumnya.',
        ),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.plan});

  final InstallmentPlanRecord plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(installmentTransactionsProvider(plan.id));
    final progress = plan.totalInstallments > 0
        ? plan.generatedCount / plan.totalInstallments
        : 0.0;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BrutalCard(
          color: _statusColor(plan.status),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  _StatusBadge(status: plan.status),
                ],
              ),
              const SizedBox(height: 12),
              Text('Total: ${formatIdr(plan.totalAmount)}'),
              Text('Cicilan per bulan: ${formatIdr(plan.monthlyAmount)}'),
              Text('Kategori: ${plan.categoryName}'),
              Text(
                'Tipe: ${plan.installmentType == InstallmentType.evenSplit ? 'Bagi Rata' : 'Tetap per Bulan'}',
              ),
              Text('Tanggal jatuh tempo: setiap tanggal ${plan.dayOfMonth}'),
              if (plan.notes != null && plan.notes!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  plan.notes!,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        BrutalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PROGRESS',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${plan.generatedCount}/${plan.totalInstallments} CICILAN',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Text('${(progress * 100).round()}%'),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: progress.clamp(0, 1),
                minHeight: 14,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 8),
              Text('Sudah dibayar: ${formatIdr(plan.paidAmount)}'),
              Text('Sisa: ${formatIdr(plan.remainingAmount)}'),
              if (plan.remainingInstallments > 0)
                Text('Sisa cicilan: ${plan.remainingInstallments} bulan'),
            ],
          ),
        ),
        if (plan.isActive) ...[
          const SizedBox(height: 16),
          BrutalButton(
            label: 'BATALKAN CICILAN',
            icon: Icons.cancel_outlined,
            secondary: true,
            onPressed: () => _cancelPlan(context, ref),
          ),
        ],
        const SizedBox(height: 24),
        const Text(
          'RIWAYAT PEMBAYARAN',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        const SizedBox(height: 10),
        transactions.when(
          data: (values) => values.isEmpty
              ? const EmptyState(
                  title: 'BELUM ADA TRANSAKSI',
                  message: 'Cicilan pertama akan muncul saat dibuat.',
                )
              : Column(
                  children: values
                      .map(
                        (item) => FinanceTransactionTile(transaction: item),
                      )
                      .toList(growable: false),
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => const Text('Riwayat pembayaran gagal dimuat.'),
        ),
      ],
    );
  }

  Color _statusColor(InstallmentPlanStatus status) => switch (status) {
    InstallmentPlanStatus.active => const Color(0xFFB7E4C7),
    InstallmentPlanStatus.completed => const Color(0xFFD0D0D0),
    InstallmentPlanStatus.cancelled => const Color(0xFFFFD6A5),
  };

  Future<void> _cancelPlan(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('BATALKAN CICILAN?'),
        content: const Text(
          'Cicilan yang sudah dibayar tetap tercatat. '
          'Cicilan berikutnya tidak akan di-generate.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('KEMBALI'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('BATALKAN'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await ref
          .read(financeRepositoryProvider)
          .cancelInstallmentPlan(plan.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cicilan dibatalkan.')),
        );
      }
    } on Object {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cicilan belum dapat dibatalkan.')),
      );
    }
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final InstallmentPlanStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      InstallmentPlanStatus.active => ('AKTIF', Colors.green),
      InstallmentPlanStatus.completed => ('LUNAS', Colors.grey),
      InstallmentPlanStatus.cancelled => ('DIBATALKAN', Colors.orange),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12,
          color: color,
        ),
      ),
    );
  }
}
