import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

String formatIdr(int amount) {
  final negative = amount < 0;
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) buffer.write('.');
    buffer.write(digits[index]);
  }
  return '${negative ? '-' : ''}Rp ${buffer.toString()}';
}

String formatFinanceDate(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${value.day} ${months[value.month - 1]} ${value.year}';
}

String formatPeriodRange(FinancialPeriod period) =>
    '${formatFinanceDate(period.startDate)} – ${formatFinanceDate(period.endDate)}';

class FinanceMetricCard extends StatelessWidget {
  const FinanceMetricCard({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
    this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label, $value',
      child: BrutalCard(
        color: color,
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinanceTransactionTile extends StatelessWidget {
  const FinanceTransactionTile({
    required this.transaction,
    super.key,
    this.onDelete,
  });

  final FinanceTransactionRecord transaction;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final expense = transaction.type == FinancialTransactionType.expense;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: BrutalCard(
        child: LayoutBuilder(
          builder: (context, constraints) => constraints.maxWidth < 440
              ? _compact(context, expense)
              : _wide(context, expense),
        ),
      ),
    );
  }

  Widget _wide(BuildContext context, bool expense) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: expense
            ? KeySpaceColors.warning
            : KeySpaceColors.healthy,
        foregroundColor: KeySpaceColors.ink,
        child: Icon(expense ? Icons.south_west : Icons.north_east),
      ),
      title: Text(
        transaction.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
      subtitle: Text(
        '${transaction.categoryName} • ${formatFinanceDate(transaction.transactionDate)}'
        '${transaction.isReimburse ? ' • REIMBURSE' : ''}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${expense ? '-' : '+'}${formatIdr(transaction.amount)}',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          if (onDelete != null)
            IconButton(
              tooltip: 'Hapus ${transaction.name}',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      onTap: () =>
          context.push(AppRoutes.financeTransactionPath(transaction.id)),
    );
  }

  Widget _compact(BuildContext context, bool expense) {
    return InkWell(
      onTap: () =>
          context.push(AppRoutes.financeTransactionPath(transaction.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: expense
                    ? KeySpaceColors.warning
                    : KeySpaceColors.healthy,
                foregroundColor: KeySpaceColors.ink,
                child: Icon(expense ? Icons.south_west : Icons.north_east),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  transaction.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${expense ? '-' : '+'}${formatIdr(transaction.amount)}',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          Text(
            '${transaction.categoryName} • ${formatFinanceDate(transaction.transactionDate)}'
            '${transaction.isReimburse ? ' • REIMBURSE' : ''}',
          ),
          if (onDelete != null)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                tooltip: 'Hapus ${transaction.name}',
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
              ),
            ),
        ],
      ),
    );
  }
}
