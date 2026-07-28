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
    repository = FinanceRepository(
      database,
      now: () => DateTime.utc(2026, 7, 22, 12),
    );
  });

  tearDown(() => database.close());

  test('get-or-create is stable and uses default period budget', () async {
    await repository.updateDefaultBudget(5000000);

    final first = await repository.getOrCreatePeriod(DateTime(2026, 7, 22));
    final second = await repository.getOrCreatePeriod(DateTime(2026, 7, 24));

    expect(second.id, first.id);
    expect(first.startDate, DateTime(2026, 6, 25));
    expect(first.endDate, DateTime(2026, 7, 24));
    expect(first.name, 'Periode Juli 2026');
    expect(first.budgetAmount, 5000000);
    expect(await _count(database, 'financial_periods'), 1);
  });

  test('concurrent get-or-create requests produce one period', () async {
    final periods = await Future.wait(
      List.generate(
        8,
        (_) => repository.getOrCreatePeriod(DateTime(2026, 7, 22)),
      ),
    );

    expect(periods.map((period) => period.id).toSet(), hasLength(1));
    expect(await _count(database, 'financial_periods'), 1);
  });

  test('cycle change preserves old period and creates bridge', () async {
    final old = await repository.getOrCreatePeriod(DateTime(2026, 7, 22));
    await repository.updateCycleStartDay(
      10,
      effectiveDate: DateTime(2026, 7, 22),
    );

    final historical = await repository.getOrCreatePeriod(
      DateTime(2026, 7, 23),
    );
    final bridge = await repository.getOrCreatePeriod(DateTime(2026, 7, 30));
    final complete = await repository.getOrCreatePeriod(DateTime(2026, 8, 10));

    expect(historical.id, old.id);
    expect(bridge.startDate, DateTime(2026, 7, 25));
    expect(bridge.endDate, DateTime(2026, 8, 9));
    expect(bridge.cycleStartDay, 10);
    expect(complete.startDate, DateTime(2026, 8, 10));
    expect(complete.endDate, DateTime(2026, 9, 9));
    expect(old.endDate, DateTime(2026, 7, 24));
  });

  test('aggregates budget and reimburse formulas in SQL', () async {
    final period = await repository.getOrCreatePeriod(DateTime(2026, 7, 22));
    await repository.updatePeriodBudget(period.id, 5000000);
    await repository.saveBatch([
      _input(
        id: 'expense-normal',
        amount: 2250000,
        categoryId: 'expense-food-drink',
      ),
      _input(
        id: 'expense-reimburse',
        amount: 1200000,
        categoryId: 'expense-transport',
        reimburse: true,
      ),
      _input(
        id: 'income',
        amount: 8000000,
        categoryId: 'income-salary',
        type: FinancialTransactionType.income,
      ),
    ]);

    final summary = await repository.getSummary(period.id);

    expect(summary.totalExpense, 3450000);
    expect(summary.totalIncome, 8000000);
    expect(summary.totalReimburse, 1200000);
    expect(summary.budgetUsage, 2250000);
    expect(summary.remainingBudget, 2750000);
    expect(summary.netBalance, 4550000);

    final breakdown = await repository.watchExpenseBreakdown(period.id).first;
    expect(
      breakdown.map((item) => item.categoryName),
      containsAll(['Makanan dan Minuman', 'Transportasi']),
    );
  });

  test('summary stream reacts to reimburse edit and delete', () async {
    final period = await repository.getOrCreatePeriod(DateTime(2026, 7, 22));
    await repository.updatePeriodBudget(period.id, 500000);
    await repository.saveBatch([
      _input(id: 'reactive', amount: 200000, categoryId: 'expense-food-drink'),
    ]);
    expect(
      await repository.watchSummary(period.id).first,
      isA<FinanceSummary>().having(
        (summary) => summary.remainingBudget,
        'remainingBudget',
        300000,
      ),
    );

    await repository.updateTransaction(
      'reactive',
      _input(amount: 200000, categoryId: 'expense-food-drink', reimburse: true),
    );
    final reimbursed = await repository.watchSummary(period.id).first;
    expect(reimbursed.totalExpense, 200000);
    expect(reimbursed.totalReimburse, 200000);
    expect(reimbursed.remainingBudget, 500000);

    await repository.deleteTransaction('reactive');
    final deleted = await repository.watchSummary(period.id).first;
    expect(deleted.totalExpense, 0);
    expect(deleted.totalReimburse, 0);
    expect(deleted.remainingBudget, 500000);
  });

  test('batch save rolls back every item when one item fails', () async {
    await expectLater(
      repository.saveBatch([
        _input(
          id: 'valid-first',
          amount: 100000,
          categoryId: 'expense-food-drink',
        ),
        _input(
          id: 'invalid-second',
          amount: 50000,
          categoryId: 'income-salary',
        ),
      ]),
      throwsFormatException,
    );

    expect(await _count(database, 'financial_transactions'), 0);
  });

  test('editing date moves transaction to the correct period', () async {
    await repository.saveBatch([
      _input(
        id: 'moving',
        amount: 100000,
        categoryId: 'expense-food-drink',
        date: DateTime(2026, 7, 24),
      ),
    ]);
    final oldPeriod = await repository.getOrCreatePeriod(DateTime(2026, 7, 24));

    await repository.updateTransaction(
      'moving',
      _input(
        amount: 100000,
        categoryId: 'expense-food-drink',
        date: DateTime(2026, 7, 25),
      ),
    );
    final newPeriod = await repository.getOrCreatePeriod(DateTime(2026, 7, 25));
    final transaction = await (database.select(
      database.financialTransactions,
    )..where((row) => row.id.equals('moving'))).getSingle();

    expect(transaction.financialPeriodId, newPeriod.id);
    expect(transaction.financialPeriodId, isNot(oldPeriod.id));
  });

  test('inactive category keeps its historical display name', () async {
    final period = await repository.getOrCreatePeriod(DateTime(2026, 7, 22));
    await repository.saveBatch([
      _input(id: 'historical', amount: 100000, categoryId: 'expense-transport'),
    ]);
    await repository.setCategoryActive('expense-transport', isActive: false);

    final records = await repository
        .watchTransactions(FinanceTransactionFilter(periodId: period.id))
        .first;

    expect(records.single.categoryName, 'Transportasi');
    await expectLater(
      repository.saveBatch([
        _input(amount: 200000, categoryId: 'expense-transport'),
      ]),
      throwsFormatException,
    );
  });

  test(
    'system categories cannot be deleted but custom categories can',
    () async {
      await expectLater(
        repository.deleteCategory('expense-food-drink'),
        throwsStateError,
      );

      final customId = await repository.createCategory(
        name: 'Hobi Khusus',
        type: FinancialTransactionType.expense,
        iconKey: 'palette',
      );
      await repository.deleteCategory(customId);

      expect(
        await (database.select(
          database.financialCategories,
        )..where((row) => row.id.equals(customId))).getSingleOrNull(),
        isNull,
      );
    },
  );

  test('filter and search execute through repository query', () async {
    final period = await repository.getOrCreatePeriod(DateTime(2026, 7, 22));
    await repository.saveBatch([
      _input(
        id: 'bensin',
        name: 'Bensin motor',
        amount: 150000,
        categoryId: 'expense-transport',
        reimburse: true,
      ),
      _input(
        id: 'makan',
        name: 'Makan siang',
        amount: 35000,
        categoryId: 'expense-food-drink',
      ),
    ]);

    final records = await repository
        .watchTransactions(
          FinanceTransactionFilter(
            periodId: period.id,
            type: FinancialTransactionType.expense,
            isReimburse: true,
            search: 'BENSIN',
          ),
        )
        .first;

    expect(records.map((record) => record.id), ['bensin']);
  });

  test(
    'period and transaction lookup streams retain historical data',
    () async {
      await repository.saveBatch([
        _input(
          id: 'historical-stream',
          amount: 90000,
          categoryId: 'expense-transport',
          date: DateTime(2026, 5, 12),
        ),
        _input(
          id: 'current-stream',
          amount: 120000,
          categoryId: 'expense-food-drink',
        ),
      ]);

      final periods = await repository.watchPeriods().first;
      final transaction = await repository
          .watchTransaction('historical-stream')
          .first;

      expect(periods, hasLength(2));
      expect(periods.first.startDate.isAfter(periods.last.startDate), isTrue);
      expect(transaction?.categoryName, 'Transportasi');
      expect(transaction?.amount, 90000);
    },
  );
}

FinanceTransactionInput _input({
  String? id,
  String name = 'Transaksi',
  required int amount,
  required String categoryId,
  FinancialTransactionType type = FinancialTransactionType.expense,
  DateTime? date,
  bool reimburse = false,
}) {
  return FinanceTransactionInput(
    id: id,
    type: type,
    name: name,
    amount: amount,
    transactionDate: date ?? DateTime(2026, 7, 22),
    categoryId: categoryId,
    isReimburse: reimburse,
  );
}

Future<int> _count(AppDatabase database, String table) async {
  final row = await database
      .customSelect('SELECT COUNT(*) AS total FROM $table')
      .getSingle();
  return row.read<int>('total');
}
