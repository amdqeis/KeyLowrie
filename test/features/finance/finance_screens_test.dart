import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/data/finance_repository.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_dashboard_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_history_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_settings_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_transaction_screen.dart';
import 'package:keyspace/features/finance/presentation/finance_ui.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';

void main() {
  testWidgets('dashboard reacts immediately to create, edit, and delete', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = FinanceRepository(database);
    final today = DateTime.now();
    final period = await repository.getOrCreatePeriod(today);
    await repository.updatePeriodBudget(period.id, 500000);
    await repository.saveBatch([
      _input(
        id: 'reactive-dashboard',
        name: 'Belanja awal',
        amount: 200000,
        date: today,
      ),
    ]);

    await tester.pumpWidget(
      _app(database, repository, const FinanceDashboardScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.text('SISA ${formatIdr(300000)}'), findsOneWidget);

    await repository.saveBatch([
      _input(
        id: 'income-dashboard',
        name: 'Bonus proyek',
        amount: 800000,
        type: FinancialTransactionType.income,
        categoryId: 'income-salary',
        date: today,
      ),
    ]);
    await tester.pumpAndSettle();
    expect(find.text(formatIdr(800000)), findsWidgets);

    await repository.updateTransaction(
      'reactive-dashboard',
      _input(
        name: 'Belanja direimburse',
        amount: 200000,
        date: today,
        reimburse: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('SISA ${formatIdr(500000)}'), findsOneWidget);
    expect(find.text('Belanja direimburse'), findsOneWidget);

    await repository.deleteTransaction('reactive-dashboard');
    await tester.pumpAndSettle();
    expect(find.text('Belanja direimburse'), findsNothing);
    await _disposeWidget(tester);
  });

  testWidgets('history search and period selection expose old periods', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = FinanceRepository(database);
    final today = DateTime.now();
    final oldDate = today.subtract(const Duration(days: 70));
    await repository.saveBatch([
      _input(
        id: 'current-bensin',
        name: 'Bensin kantor',
        amount: 150000,
        date: today,
        reimburse: true,
        categoryId: 'expense-transport',
      ),
      _input(
        id: 'current-makan',
        name: 'Makan siang',
        amount: 35000,
        date: today,
      ),
      _input(
        id: 'old-transaction',
        name: 'Transaksi periode lama',
        amount: 45000,
        date: oldDate,
      ),
    ]);

    await tester.pumpWidget(
      _app(database, repository, const FinanceHistoryScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Bensin kantor'), findsOneWidget);
    expect(find.text('Makan siang'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Cari nama transaksi'),
      'bensin',
    );
    await tester.pumpAndSettle();
    expect(find.text('Bensin kantor'), findsOneWidget);
    expect(find.text('Makan siang'), findsNothing);

    final periods = await repository.getPeriods();
    final oldPeriod = periods.last;
    final periodDropdown = find.byType(DropdownButtonFormField<String>).first;
    await tester.tap(periodDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining(oldPeriod.name).last);
    await tester.pumpAndSettle();
    expect(find.text('TIDAK ADA HASIL'), findsOneWidget);

    await tester.tap(find.byTooltip('Hapus pencarian'));
    await tester.pumpAndSettle();
    expect(find.text('Transaksi periode lama'), findsOneWidget);
    await _disposeWidget(tester);
  });

  testWidgets('transaction detail edits type and enforces income reimburse', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = FinanceRepository(database);
    await repository.saveBatch([
      _input(
        id: 'detail-edit',
        name: 'Pengeluaran lama',
        amount: 100000,
        date: DateTime.now(),
        reimburse: true,
      ),
    ]);
    final router = GoRouter(
      initialLocation: '/finance/transaction/detail-edit',
      routes: [
        GoRoute(
          path: '/finance/transaction/:id',
          builder: (_, state) =>
              FinanceTransactionScreen(id: state.pathParameters['id']!),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(_routerApp(database, repository, router));
    await tester.pumpAndSettle();
    final type = find.byType(DropdownButtonFormField<FinancialTransactionType>);
    await tester.tap(type);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pemasukan').last);
    await tester.pumpAndSettle();
    expect(find.text('Reimburse'), findsNothing);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama transaksi'),
      'Refund vendor',
    );
    final save = find.text('SIMPAN PERUBAHAN');
    await Scrollable.ensureVisible(tester.element(save), alignment: 0.5);
    await tester.pumpAndSettle();
    await tester.tap(save);
    await tester.pumpAndSettle();

    final saved = await (database.select(
      database.financialTransactions,
    )..where((row) => row.id.equals('detail-edit'))).getSingle();
    expect(saved.type, FinancialTransactionType.income.storageValue);
    expect(saved.name, 'Refund vendor');
    expect(saved.isReimburse, isFalse);
    await _disposeWidget(tester);
  });

  testWidgets('finance settings persist budgets and expose IDR-only state', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = FinanceRepository(database);
    final period = await repository.getOrCreatePeriod(DateTime.now());

    await tester.pumpWidget(
      _app(database, repository, const FinanceSettingsScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('V1 HANYA IDR'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Budget default periode baru'),
      '2500000',
    );
    await tester.enterText(
      find.widgetWithText(
        TextFormField,
        'Budget periode aktif: ${period.name}',
      ),
      '1800000',
    );
    await tester.tap(find.text('SIMPAN PENGATURAN'));
    await tester.pumpAndSettle();

    expect((await repository.getSettings()).defaultBudgetAmount, 2500000);
    final savedPeriod = await (database.select(
      database.financialPeriods,
    )..where((row) => row.id.equals(period.id))).getSingle();
    expect(savedPeriod.budgetAmount, 1800000);
    await _disposeWidget(tester);
  });

  testWidgets('representative dashboard fixture renders under 500 ms', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = FinanceRepository(database);
    final today = DateTime.now();
    await repository.saveBatch(
      List.generate(
        100,
        (index) => _input(
          id: 'fixture-$index',
          name: 'Transaksi fixture $index',
          amount: 1000 + index,
          date: today,
          categoryId: index.isEven ? 'expense-food-drink' : 'expense-transport',
        ),
      ),
    );

    final stopwatch = Stopwatch()..start();
    await tester.pumpWidget(
      _app(database, repository, const FinanceDashboardScreen()),
    );
    await tester.pumpAndSettle();
    stopwatch.stop();

    expect(find.text('TRANSAKSI TERBARU'), findsOneWidget);
    expect(stopwatch.elapsedMilliseconds, lessThan(500));
    await _disposeWidget(tester);
  });
}

Widget _app(AppDatabase database, FinanceRepository repository, Widget home) {
  return ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(database),
      financeRepositoryProvider.overrideWithValue(repository),
    ],
    child: MaterialApp(theme: KeySpaceTheme.light, home: home),
  );
}

Widget _routerApp(
  AppDatabase database,
  FinanceRepository repository,
  GoRouter router,
) {
  return ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(database),
      financeRepositoryProvider.overrideWithValue(repository),
    ],
    child: MaterialApp.router(theme: KeySpaceTheme.light, routerConfig: router),
  );
}

FinanceTransactionInput _input({
  String? id,
  required String name,
  required int amount,
  required DateTime date,
  String categoryId = 'expense-food-drink',
  FinancialTransactionType type = FinancialTransactionType.expense,
  bool reimburse = false,
}) {
  return FinanceTransactionInput(
    id: id,
    type: type,
    name: name,
    amount: amount,
    transactionDate: date,
    categoryId: categoryId,
    isReimburse: reimburse,
  );
}

Future<void> _disposeWidget(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pump(const Duration(milliseconds: 1));
}
