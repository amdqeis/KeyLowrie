import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/data/finance_repository.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_analytics_screen.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';

void main() {
  testWidgets('analytics renders local charts and type filter', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = FinanceRepository(database);
    await repository.saveBatch([
      FinanceTransactionInput(
        id: 'analytics-expense',
        type: FinancialTransactionType.expense,
        name: 'Makan',
        amount: 100000,
        transactionDate: DateTime.now(),
        categoryId: 'expense-food-drink',
      ),
      FinanceTransactionInput(
        id: 'analytics-income',
        type: FinancialTransactionType.income,
        name: 'Gaji',
        amount: 500000,
        transactionDate: DateTime.now(),
        categoryId: 'income-salary',
      ),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          financeRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          theme: KeySpaceTheme.light,
          home: const FinanceAnalyticsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('PENGELUARAN PER KATEGORI'), findsOneWidget);
    expect(find.text('PEMASUKAN PER KATEGORI'), findsOneWidget);
    expect(find.textContaining('TREN'), findsOneWidget);
    await tester.tap(find.text('Pengeluaran'));
    await tester.pumpAndSettle();
    expect(find.text('PEMASUKAN PER KATEGORI'), findsNothing);
    expect(find.text('PENGELUARAN PER KATEGORI'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
  });
}
