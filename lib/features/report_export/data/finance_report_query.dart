import 'package:drift/drift.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/report_export/domain/report_date_range.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';

/// Query database untuk laporan keuangan berdasarkan rentang tanggal.
/// Tidak memanggil Gemini atau network.
class FinanceReportQuery {
  const FinanceReportQuery(this._db);

  final AppDatabase _db;

  /// Mengambil semua data yang diperlukan untuk laporan keuangan.
  Future<FinanceReportData> fetch(ReportDateRange range) async {
    final settings = await _fetchSettings();
    final periodName = range.periodName ?? range.formattedRange;

    // Budget: hanya tersedia jika rentang cocok dengan tepat satu periode
    final budget = await _fetchBudgetForRange(range);

    // Transaksi dalam rentang
    final transactions = await _fetchTransactions(range);

    // Hitung summary
    int totalExpense = 0;
    int totalIncome = 0;
    int totalReimburse = 0;
    int budgetUsage = 0;
    int expenseCount = 0;
    int incomeCount = 0;

    for (final tx in transactions) {
      if (tx.type == 'expense') {
        totalExpense += tx.amount;
        expenseCount++;
        if (tx.isReimburse) {
          totalReimburse += tx.amount;
        } else {
          budgetUsage += tx.amount;
        }
      } else {
        totalIncome += tx.amount;
        incomeCount++;
      }
    }

    final remainingBudget = budget - budgetUsage;
    final netBalance = totalIncome - totalExpense;

    // Breakdown kategori
    final expenseCategories = _buildCategoryBreakdown(
      transactions.where((t) => t.type == 'expense').toList(),
    );
    final incomeCategories = _buildCategoryBreakdown(
      transactions.where((t) => t.type == 'income').toList(),
    );

    return FinanceReportData(
      periodName: periodName,
      rangeStart: range.start,
      rangeEnd: range.end,
      generatedAt: DateTime.now(),
      currencyCode: settings.currencyCode,
      budgetAmount: budget,
      totalExpense: totalExpense,
      totalIncome: totalIncome,
      totalReimburse: totalReimburse,
      budgetUsage: budgetUsage,
      remainingBudget: remainingBudget,
      netBalance: netBalance,
      expenseCount: expenseCount,
      incomeCount: incomeCount,
      expenseCategories: expenseCategories,
      incomeCategories: incomeCategories,
      transactions: transactions
          .map(
            (tx) => FinanceTransactionRow(
              date: tx.transactionDate.toLocal(),
              type: tx.type,
              name: tx.name,
              categoryName: tx.categoryName,
              isReimburse: tx.isReimburse,
              amount: tx.amount,
            ),
          )
          .toList(),
    );
  }

  Future<FinanceSetting> _fetchSettings() {
    return (_db.select(
      _db.financeSettings,
    )..where((row) => row.id.equals(1))).getSingle();
  }

  Future<int> _fetchBudgetForRange(ReportDateRange range) async {
    // Coba ambil satu periode yang persis cocok dengan rentang
    final period =
        await (_db.select(_db.financialPeriods)..where(
              (row) =>
                  row.startDate.equals(range.start) &
                  row.endDate.equals(range.end),
            ))
            .getSingleOrNull();
    return period?.budgetAmount ?? 0;
  }

  Future<List<_TxRow>> _fetchTransactions(ReportDateRange range) async {
    // Normalisasi batas: start = awal hari, end = akhir hari (23:59:59 UTC)
    final startUtc = range.start.toUtc();
    final endUtc = DateTime(
      range.end.year,
      range.end.month,
      range.end.day,
      23,
      59,
      59,
    ).toUtc();

    final transactions = _db.financialTransactions;
    final categories = _db.financialCategories;

    final query =
        _db.select(transactions).join([
            innerJoin(
              categories,
              categories.id.equalsExp(transactions.categoryId),
            ),
          ])
          ..where(
            transactions.transactionDate.isBiggerOrEqualValue(startUtc) &
                transactions.transactionDate.isSmallerOrEqualValue(endUtc),
          )
          ..orderBy([
            OrderingTerm.desc(transactions.transactionDate),
            OrderingTerm.desc(transactions.createdAt),
          ]);

    final rows = await query.get();
    return rows.map((row) {
      final tx = row.readTable(transactions);
      final cat = row.readTable(categories);
      return _TxRow(
        type: tx.type,
        name: tx.name,
        amount: tx.amount,
        transactionDate: tx.transactionDate,
        categoryName: cat.name,
        isReimburse: tx.isReimburse,
      );
    }).toList();
  }

  List<FinanceCategoryRow> _buildCategoryBreakdown(List<_TxRow> txs) {
    final map = <String, _CatAgg>{};
    for (final tx in txs) {
      final agg = map.putIfAbsent(
        tx.categoryName,
        () => _CatAgg(tx.categoryName),
      );
      agg.total += tx.amount;
      agg.count++;
    }
    final result =
        map.values
            .map(
              (agg) => FinanceCategoryRow(
                categoryName: agg.name,
                transactionCount: agg.count,
                total: agg.total,
              ),
            )
            .toList()
          ..sort((a, b) => b.total.compareTo(a.total));
    return result;
  }
}

class _TxRow {
  _TxRow({
    required this.type,
    required this.name,
    required this.amount,
    required this.transactionDate,
    required this.categoryName,
    required this.isReimburse,
  });

  final String type;
  final String name;
  final int amount;
  final DateTime transactionDate;
  final String categoryName;
  final bool isReimburse;
}

class _CatAgg {
  _CatAgg(this.name);
  final String name;
  int total = 0;
  int count = 0;
}
