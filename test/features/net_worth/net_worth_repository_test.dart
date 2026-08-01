import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/data/finance_repository.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/net_worth/data/net_worth_repository.dart';
import 'package:keyspace/features/net_worth/domain/net_worth_models.dart';

void main() {
  late AppDatabase database;
  late FinanceRepository finance;
  late DriftNetWorthRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    finance = FinanceRepository(
      database,
      now: () => DateTime.utc(2026, 8, 1, 12),
    );
    repository = DriftNetWorthRepository(database);
  });

  tearDown(() => database.close());

  NetWorthInitializationModel initialization({
    int amount = 1000000,
    DateTime? date,
  }) => NetWorthInitializationModel(
    id: NetWorthInitializationModel.singletonId,
    initialAmount: amount,
    initializationDate: date ?? DateTime(2026, 8, 1),
    currencyCode: 'IDR',
    createdAt: DateTime.utc(2026, 8, 1),
    updatedAt: DateTime.utc(2026, 8, 1),
  );

  test(
    'supports positive, zero, negative, and singleton initialization',
    () async {
      await repository.saveInitialization(initialization(amount: 100));
      expect(await repository.calculateCurrentNetWorth(), 100);
      await repository.updateInitialization(initialization(amount: 0));
      expect(await repository.calculateCurrentNetWorth(), 0);
      await repository.updateInitialization(initialization(amount: -100));
      expect(await repository.calculateCurrentNetWorth(), -100);
      await expectLater(
        repository.saveInitialization(initialization()),
        throwsStateError,
      );
    },
  );

  test(
    'calculates cash-flow net worth with reimburse and adjustments',
    () async {
      await repository.saveInitialization(initialization());
      await finance.saveBatch([
        FinanceTransactionInput(
          id: 'expense-before',
          type: FinancialTransactionType.expense,
          name: 'Sebelum',
          amount: 999999,
          transactionDate: DateTime(2026, 7, 31),
          categoryId: 'expense-food-drink',
        ),
        FinanceTransactionInput(
          id: 'expense-reimburse',
          type: FinancialTransactionType.expense,
          name: 'Reimburse keluar',
          amount: 200000,
          transactionDate: DateTime(2026, 8, 2),
          categoryId: 'expense-transport',
          isReimburse: true,
        ),
        FinanceTransactionInput(
          id: 'income',
          type: FinancialTransactionType.income,
          name: 'Gaji',
          amount: 500000,
          transactionDate: DateTime(2026, 8, 3),
          categoryId: 'income-salary',
        ),
      ]);
      await repository.addAdjustment(
        NetWorthAdjustmentModel(
          id: 'gain',
          name: 'Investasi naik',
          amount: 100000,
          adjustmentDate: DateTime(2026, 8, 4),
          createdAt: DateTime.utc(2026, 8, 4),
          updatedAt: DateTime.utc(2026, 8, 4),
        ),
      );
      await repository.addAdjustment(
        NetWorthAdjustmentModel(
          id: 'debt',
          name: 'Utang naik',
          amount: -50000,
          adjustmentDate: DateTime(2026, 8, 5),
          createdAt: DateTime.utc(2026, 8, 5),
          updatedAt: DateTime.utc(2026, 8, 5),
        ),
      );

      expect(await repository.calculateCurrentNetWorth(), 1350000);
      expect(
        await repository.calculateNetWorthChange(
          startDate: DateTime(2026, 8, 1),
          endDate: DateTime(2026, 8, 6),
        ),
        350000,
      );
    },
  );

  test('edit initialization recalculates without deleting old data', () async {
    await repository.saveInitialization(initialization());
    await finance.saveBatch([
      FinanceTransactionInput(
        id: 'old-income',
        type: FinancialTransactionType.income,
        name: 'Lama',
        amount: 400000,
        transactionDate: DateTime(2026, 8, 2),
        categoryId: 'income-salary',
      ),
    ]);
    await repository.updateInitialization(
      initialization(amount: -100000, date: DateTime(2026, 8, 3)),
    );

    expect(await repository.calculateCurrentNetWorth(), -100000);
    expect(
      await database.select(database.financialTransactions).get(),
      hasLength(1),
    );
  });

  test('rejects zero and pre-initialization adjustments', () async {
    await repository.saveInitialization(initialization());
    NetWorthAdjustmentModel adjustment(int amount, DateTime date) =>
        NetWorthAdjustmentModel(
          id: '$amount-$date',
          name: 'Koreksi',
          amount: amount,
          adjustmentDate: date,
          createdAt: DateTime.utc(2026, 8, 1),
          updatedAt: DateTime.utc(2026, 8, 1),
        );

    await expectLater(
      repository.addAdjustment(adjustment(0, DateTime(2026, 8, 1))),
      throwsFormatException,
    );
    await expectLater(
      repository.addAdjustment(adjustment(1, DateTime(2026, 7, 31))),
      throwsFormatException,
    );
  });
}
