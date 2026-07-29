import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';

void main() {
  group('FinanceReportData', () {
    test('budgetUsage tidak termasuk reimburse', () {
      // Reimburse = true → masuk totalExpense tapi TIDAK ke budgetUsage
      final data = FinanceReportData(
        periodName: 'Tes',
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 31),
        generatedAt: DateTime.utc(2025, 2, 1),
        currencyCode: 'IDR',
        budgetAmount: 5000000,
        totalExpense: 3000000,
        totalIncome: 1000000,
        totalReimburse: 500000,
        budgetUsage: 2500000, // totalExpense - totalReimburse
        remainingBudget: 2500000,
        netBalance: -2000000,
        expenseCount: 5,
        incomeCount: 2,
        expenseCategories: [],
        incomeCategories: [],
        transactions: [],
      );

      expect(data.budgetUsage, 2500000);
      expect(data.totalExpense, 3000000);
      expect(data.totalReimburse, 500000);
      expect(data.budgetUsage, data.totalExpense - data.totalReimburse);
    });

    test('netBalance = totalIncome - totalExpense', () {
      final data = FinanceReportData(
        periodName: 'Tes',
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 31),
        generatedAt: DateTime.utc(2025, 2, 1),
        currencyCode: 'IDR',
        budgetAmount: 5000000,
        totalExpense: 3000000,
        totalIncome: 4000000,
        totalReimburse: 0,
        budgetUsage: 3000000,
        remainingBudget: 2000000,
        netBalance: 1000000,
        expenseCount: 3,
        incomeCount: 1,
        expenseCategories: [],
        incomeCategories: [],
        transactions: [],
      );

      expect(data.netBalance, data.totalIncome - data.totalExpense);
      expect(data.netBalance, 1000000);
    });

    test('remainingBudget negatif saat over budget', () {
      final data = FinanceReportData(
        periodName: 'Tes',
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 31),
        generatedAt: DateTime.utc(2025, 2, 1),
        currencyCode: 'IDR',
        budgetAmount: 1000000,
        totalExpense: 1500000,
        totalIncome: 0,
        totalReimburse: 0,
        budgetUsage: 1500000,
        remainingBudget: -500000, // over budget
        netBalance: -1500000,
        expenseCount: 2,
        incomeCount: 0,
        expenseCategories: [],
        incomeCategories: [],
        transactions: [],
      );

      expect(data.remainingBudget, isNegative);
      expect(data.remainingBudget, data.budgetAmount - data.budgetUsage);
    });

    test('isEmpty true jika tidak ada transaksi', () {
      final data = FinanceReportData(
        periodName: 'Kosong',
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 31),
        generatedAt: DateTime.utc(2025, 2, 1),
        currencyCode: 'IDR',
        budgetAmount: 0,
        totalExpense: 0,
        totalIncome: 0,
        totalReimburse: 0,
        budgetUsage: 0,
        remainingBudget: 0,
        netBalance: 0,
        expenseCount: 0,
        incomeCount: 0,
        expenseCategories: [],
        incomeCategories: [],
        transactions: [],
      );
      expect(data.isEmpty, isTrue);
    });
  });
}
