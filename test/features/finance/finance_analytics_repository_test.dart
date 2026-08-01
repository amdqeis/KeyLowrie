import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/data/finance_repository.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';

void main() {
  late AppDatabase database;
  late FinanceRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = FinanceRepository(database);
  });

  tearDown(() => database.close());

  test('aggregates category, totals, averages, and reimburse in SQL', () async {
    await repository.saveBatch([
      _input('food', 200000, DateTime(2026, 8, 1), 'expense-food-drink'),
      _input(
        'transport',
        100000,
        DateTime(2026, 8, 2),
        'expense-transport',
        reimburse: true,
      ),
      _input(
        'salary',
        900000,
        DateTime(2026, 8, 2),
        'income-salary',
        type: FinancialTransactionType.income,
      ),
    ]);
    final data = await repository.getAnalytics(
      FinanceAnalyticsFilter(
        startDate: DateTime(2026, 8, 1),
        endDate: DateTime(2026, 8, 4),
      ),
    );

    expect(data.summary.totalExpense, 300000);
    expect(data.summary.totalIncome, 900000);
    expect(data.summary.netBalance, 600000);
    expect(data.summary.averageExpensePerDay, 100000);
    expect(data.summary.averageIncomePerDay, 300000);
    expect(data.summary.totalReimburse, 100000);
    expect(data.expensesByCategory.first.categoryName, 'Makanan dan Minuman');
    expect(data.expensesByCategory.first.percentage, closeTo(66.67, 0.01));
    expect(data.trend, hasLength(2));
  });

  test('type filter applies to summary, categories, and trend', () async {
    await repository.saveBatch([
      _input('expense', 100, DateTime(2026, 8, 1), 'expense-food-drink'),
      _input(
        'income',
        300,
        DateTime(2026, 8, 1),
        'income-salary',
        type: FinancialTransactionType.income,
      ),
    ]);
    final data = await repository.getAnalytics(
      FinanceAnalyticsFilter(
        startDate: DateTime(2026, 8, 1),
        endDate: DateTime(2026, 8, 2),
        type: FinanceAnalyticsType.expense,
      ),
    );

    expect(data.summary.totalExpense, 100);
    expect(data.summary.totalIncome, 0);
    expect(data.incomeByCategory, isEmpty);
    expect(data.trend.single.incomeAmount, 0);
  });

  test('selects day, week, and month granularity by calendar span', () {
    expect(
      FinanceAnalyticsFilter(
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 2, 1),
      ).granularity,
      FinanceTrendGranularity.day,
    );
    expect(
      FinanceAnalyticsFilter(
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 3, 1),
      ).granularity,
      FinanceTrendGranularity.week,
    );
    expect(
      FinanceAnalyticsFilter(
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2027, 1, 1),
      ).granularity,
      FinanceTrendGranularity.month,
    );
  });
}

FinanceTransactionInput _input(
  String id,
  int amount,
  DateTime date,
  String categoryId, {
  FinancialTransactionType type = FinancialTransactionType.expense,
  bool reimburse = false,
}) => FinanceTransactionInput(
  id: id,
  type: type,
  name: id,
  amount: amount,
  transactionDate: date,
  categoryId: categoryId,
  isReimburse: reimburse,
);
