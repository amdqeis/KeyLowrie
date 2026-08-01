import 'package:drift/drift.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/domain/financial_period_resolver.dart';
import 'package:uuid/uuid.dart';

class FinanceRepository {
  FinanceRepository(
    this.database, {
    FinancialPeriodResolver resolver = const FinancialPeriodResolver(),
    Uuid uuid = const Uuid(),
    DateTime Function()? now,
  }) : _resolver = resolver,
       _uuid = uuid,
       _now = now ?? DateTime.now;

  final AppDatabase database;
  final FinancialPeriodResolver _resolver;
  final Uuid _uuid;
  final DateTime Function() _now;

  Stream<FinanceSetting> watchSettings() {
    return (database.select(
      database.financeSettings,
    )..where((row) => row.id.equals(1))).watchSingle();
  }

  Future<FinanceSetting> getSettings() {
    return (database.select(
      database.financeSettings,
    )..where((row) => row.id.equals(1))).getSingle();
  }

  Stream<List<FinancialPeriod>> watchPeriods() {
    return (database.select(database.financialPeriods)..orderBy([
          (row) => OrderingTerm.desc(row.startDate),
          (row) => OrderingTerm.desc(row.createdAt),
        ]))
        .watch();
  }

  Future<List<FinancialPeriod>> getPeriods() {
    return (database.select(database.financialPeriods)..orderBy([
          (row) => OrderingTerm.desc(row.startDate),
          (row) => OrderingTerm.desc(row.createdAt),
        ]))
        .get();
  }

  Stream<FinancialPeriod?> watchPeriod(String id) {
    return (database.select(
      database.financialPeriods,
    )..where((row) => row.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<FinancialCategory>> watchCategories({
    FinancialTransactionType? type,
    bool activeOnly = true,
  }) {
    final query = database.select(database.financialCategories)
      ..where((row) {
        Expression<bool> predicate = const Constant(true);
        if (type != null) {
          predicate = predicate & row.type.equals(type.storageValue);
        }
        if (activeOnly) predicate = predicate & row.isActive.equals(true);
        return predicate;
      })
      ..orderBy([
        (row) => OrderingTerm.asc(row.type),
        (row) => OrderingTerm.asc(row.name),
      ]);
    return query.watch();
  }

  Future<List<FinancialCategory>> getCategories({
    FinancialTransactionType? type,
    bool activeOnly = true,
  }) {
    final query = database.select(database.financialCategories)
      ..where((row) {
        Expression<bool> predicate = const Constant(true);
        if (type != null) {
          predicate = predicate & row.type.equals(type.storageValue);
        }
        if (activeOnly) predicate = predicate & row.isActive.equals(true);
        return predicate;
      })
      ..orderBy([
        (row) => OrderingTerm.asc(row.type),
        (row) => OrderingTerm.asc(row.name),
      ]);
    return query.get();
  }

  Future<void> setCategoryActive(String id, {required bool isActive}) async {
    final affected =
        await (database.update(
          database.financialCategories,
        )..where((row) => row.id.equals(id))).write(
          FinancialCategoriesCompanion(
            isActive: Value(isActive),
            updatedAt: Value(_now().toUtc()),
          ),
        );
    if (affected != 1) throw StateError('financial_category_not_found');
  }

  Future<String> createCategory({
    required String name,
    required FinancialTransactionType type,
    String? iconKey,
  }) async {
    final cleanedName = name.trim();
    if (cleanedName.isEmpty) {
      throw const FormatException('financial_category_name_empty');
    }
    final id = _uuid.v4();
    final now = _now().toUtc();
    await database
        .into(database.financialCategories)
        .insert(
          FinancialCategoriesCompanion.insert(
            id: id,
            name: cleanedName,
            type: type.storageValue,
            iconKey: Value(_cleanOptional(iconKey)),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<void> deleteCategory(String id) async {
    final category = await (database.select(
      database.financialCategories,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (category == null) throw StateError('financial_category_not_found');
    if (category.isSystem) {
      throw StateError('system_category_cannot_be_deleted');
    }
    await (database.delete(
      database.financialCategories,
    )..where((row) => row.id.equals(id))).go();
  }

  Future<FinancialPeriod> getOrCreatePeriod(DateTime transactionDate) {
    return database.transaction(() => _getOrCreatePeriod(transactionDate));
  }

  Future<void> updateCycleStartDay(
    int cycleStartDay, {
    required DateTime effectiveDate,
  }) {
    if (cycleStartDay < 1 || cycleStartDay > 28) {
      throw RangeError.range(cycleStartDay, 1, 28, 'cycleStartDay');
    }
    return database.transaction(() async {
      final settings = await getSettings();
      if (settings.cycleStartDay == cycleStartDay) return;
      await _getOrCreatePeriod(effectiveDate, settings: settings);
      await (database.update(
        database.financeSettings,
      )..where((row) => row.id.equals(1))).write(
        FinanceSettingsCompanion(
          cycleStartDay: Value(cycleStartDay),
          updatedAt: Value(_now().toUtc()),
        ),
      );
    });
  }

  Future<void> updateDefaultBudget(int amount) {
    if (amount < 0) throw const FormatException('budget_amount_invalid');
    return (database.update(
      database.financeSettings,
    )..where((row) => row.id.equals(1))).write(
      FinanceSettingsCompanion(
        defaultBudgetAmount: Value(amount),
        updatedAt: Value(_now().toUtc()),
      ),
    );
  }

  Future<void> updatePeriodBudget(String periodId, int amount) async {
    if (amount < 0) throw const FormatException('budget_amount_invalid');
    final affected =
        await (database.update(
          database.financialPeriods,
        )..where((row) => row.id.equals(periodId))).write(
          FinancialPeriodsCompanion(
            budgetAmount: Value(amount),
            updatedAt: Value(_now().toUtc()),
          ),
        );
    if (affected != 1) throw StateError('financial_period_not_found');
  }

  Future<List<String>> saveBatch(List<FinanceTransactionInput> inputs) {
    if (inputs.isEmpty) throw const FormatException('transactions_empty');
    return database.transaction(() async {
      final ids = <String>[];
      for (final input in inputs) {
        final category = await _validateInput(input);
        final period = await _getOrCreatePeriod(input.transactionDate);
        final id = input.id ?? _uuid.v4();
        final now = _now().toUtc();
        await database
            .into(database.financialTransactions)
            .insert(
              FinancialTransactionsCompanion.insert(
                id: id,
                type: input.type.storageValue,
                name: input.name.trim(),
                amount: input.amount,
                currencyCode: const Value('IDR'),
                transactionDate: FinancialPeriodResolver.normalize(
                  input.transactionDate,
                ),
                categoryId: category.id,
                notes: Value(_cleanOptional(input.notes)),
                isReimburse: Value(input.isReimburse),
                financialPeriodId: period.id,
                createdAt: now,
                updatedAt: now,
              ),
            );
        ids.add(id);
      }
      return ids;
    });
  }

  Future<void> updateTransaction(String id, FinanceTransactionInput input) {
    return database.transaction(() async {
      final existing = await (database.select(
        database.financialTransactions,
      )..where((row) => row.id.equals(id))).getSingleOrNull();
      if (existing == null) throw StateError('financial_transaction_not_found');
      final category = await _validateInput(
        input,
        allowInactiveCategoryId: existing.categoryId,
      );
      final period = await _getOrCreatePeriod(input.transactionDate);
      await (database.update(
        database.financialTransactions,
      )..where((row) => row.id.equals(id))).write(
        FinancialTransactionsCompanion(
          type: Value(input.type.storageValue),
          name: Value(input.name.trim()),
          amount: Value(input.amount),
          currencyCode: const Value('IDR'),
          transactionDate: Value(
            FinancialPeriodResolver.normalize(input.transactionDate),
          ),
          categoryId: Value(category.id),
          notes: Value(_cleanOptional(input.notes)),
          isReimburse: Value(input.isReimburse),
          financialPeriodId: Value(period.id),
          updatedAt: Value(_now().toUtc()),
        ),
      );
    });
  }

  Future<void> deleteTransaction(String id) async {
    final affected = await (database.delete(
      database.financialTransactions,
    )..where((row) => row.id.equals(id))).go();
    if (affected != 1) throw StateError('financial_transaction_not_found');
  }

  Stream<FinanceSummary> watchSummary(String periodId) {
    return _summaryQuery(periodId).watchSingle().map(_mapSummary);
  }

  Future<FinanceSummary> getSummary(String periodId) {
    return _summaryQuery(periodId).getSingle().then(_mapSummary);
  }

  Stream<List<FinanceCategoryBreakdown>> watchExpenseBreakdown(
    String periodId,
  ) {
    final amount = database.financialTransactions.amount.sum();
    final query =
        database.selectOnly(database.financialTransactions).join([
            innerJoin(
              database.financialCategories,
              database.financialCategories.id.equalsExp(
                database.financialTransactions.categoryId,
              ),
            ),
          ])
          ..addColumns([
            database.financialCategories.id,
            database.financialCategories.name,
            amount,
          ])
          ..where(
            database.financialTransactions.financialPeriodId.equals(periodId) &
                database.financialTransactions.type.equals('expense'),
          )
          ..groupBy([
            database.financialCategories.id,
            database.financialCategories.name,
          ])
          ..orderBy([OrderingTerm.desc(amount)]);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => FinanceCategoryBreakdown(
              categoryId: row.read(database.financialCategories.id)!,
              categoryName: row.read(database.financialCategories.name)!,
              total: row.read(amount) ?? 0,
            ),
          )
          .toList(growable: false),
    );
  }

  Stream<List<FinanceTransactionRecord>> watchTransactions(
    FinanceTransactionFilter filter,
  ) {
    final transactions = database.financialTransactions;
    final categories = database.financialCategories;
    final query = database.select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.categoryId)),
    ]);
    if (filter.periodId != null) {
      query.where(transactions.financialPeriodId.equals(filter.periodId!));
    }
    if (filter.startDate != null) {
      query.where(
        transactions.transactionDate.isBiggerOrEqualValue(filter.startDate!),
      );
    }
    if (filter.endDate != null) {
      query.where(
        transactions.transactionDate.isSmallerThanValue(filter.endDate!),
      );
    }
    if (filter.type != null) {
      query.where(transactions.type.equals(filter.type!.storageValue));
    }
    if (filter.categoryId != null) {
      query.where(transactions.categoryId.equals(filter.categoryId!));
    }
    if (filter.isReimburse != null) {
      query.where(transactions.isReimburse.equals(filter.isReimburse!));
    }
    final search = filter.search?.trim().toLowerCase();
    if (search != null && search.isNotEmpty) {
      query.where(transactions.name.lower().contains(search));
    }
    query.orderBy([
      OrderingTerm.desc(transactions.transactionDate),
      OrderingTerm.desc(transactions.createdAt),
    ]);
    return query.watch().map(
      (rows) => rows
          .map((row) {
            final transaction = row.readTable(transactions);
            final category = row.readTable(categories);
            return FinanceTransactionRecord(
              id: transaction.id,
              type: FinancialTransactionTypeStorage.parse(transaction.type),
              name: transaction.name,
              amount: transaction.amount,
              currencyCode: transaction.currencyCode,
              transactionDate: transaction.transactionDate,
              categoryId: transaction.categoryId,
              categoryName: category.name,
              notes: transaction.notes,
              isReimburse: transaction.isReimburse,
              periodId: transaction.financialPeriodId,
              createdAt: transaction.createdAt,
              updatedAt: transaction.updatedAt,
            );
          })
          .toList(growable: false),
    );
  }

  Stream<List<FinanceTransactionRecord>> watchRecent(
    String periodId, {
    int limit = 5,
  }) {
    if (limit < 1) throw RangeError.value(limit, 'limit');
    final transactions = database.financialTransactions;
    final categories = database.financialCategories;
    final query =
        database.select(transactions).join([
            innerJoin(
              categories,
              categories.id.equalsExp(transactions.categoryId),
            ),
          ])
          ..where(transactions.financialPeriodId.equals(periodId))
          ..orderBy([
            OrderingTerm.desc(transactions.transactionDate),
            OrderingTerm.desc(transactions.createdAt),
          ])
          ..limit(limit);
    return query.watch().map(
      (rows) => rows
          .map((row) {
            final transaction = row.readTable(transactions);
            final category = row.readTable(categories);
            return FinanceTransactionRecord(
              id: transaction.id,
              type: FinancialTransactionTypeStorage.parse(transaction.type),
              name: transaction.name,
              amount: transaction.amount,
              currencyCode: transaction.currencyCode,
              transactionDate: transaction.transactionDate,
              categoryId: transaction.categoryId,
              categoryName: category.name,
              notes: transaction.notes,
              isReimburse: transaction.isReimburse,
              periodId: transaction.financialPeriodId,
              createdAt: transaction.createdAt,
              updatedAt: transaction.updatedAt,
            );
          })
          .toList(growable: false),
    );
  }

  Stream<FinanceTransactionRecord?> watchTransaction(String id) {
    final transactions = database.financialTransactions;
    final categories = database.financialCategories;
    final query = database.select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.categoryId)),
    ])..where(transactions.id.equals(id));
    return query.watchSingleOrNull().map(
      (row) => row == null ? null : _mapTransactionRow(row),
    );
  }

  Future<List<CategoryFinanceSummary>> getExpenseByCategory(
    DateTime startDate,
    DateTime endDate,
  ) => _categorySummary(
    type: FinancialTransactionType.expense,
    startDate: startDate,
    endDate: endDate,
  );

  Future<List<CategoryFinanceSummary>> getIncomeByCategory(
    DateTime startDate,
    DateTime endDate,
  ) => _categorySummary(
    type: FinancialTransactionType.income,
    startDate: startDate,
    endDate: endDate,
  );

  Future<List<FinanceTrendPoint>> getFinanceTrend(
    DateTime startDate,
    DateTime endDate,
  ) => _trend(FinanceAnalyticsFilter(startDate: startDate, endDate: endDate));

  Future<FinanceAnalyticsData> getAnalytics(
    FinanceAnalyticsFilter filter,
  ) async {
    if (!filter.endDate.isAfter(filter.startDate)) {
      throw const FormatException('finance_analytics_range_invalid');
    }
    final includeExpense = filter.type != FinanceAnalyticsType.income;
    final includeIncome = filter.type != FinanceAnalyticsType.expense;
    final results = await Future.wait<Object>([
      if (includeExpense)
        getExpenseByCategory(filter.startDate, filter.endDate)
      else
        Future.value(const <CategoryFinanceSummary>[]),
      if (includeIncome)
        getIncomeByCategory(filter.startDate, filter.endDate)
      else
        Future.value(const <CategoryFinanceSummary>[]),
      _analyticsTotals(filter),
      _trend(filter),
    ]);
    final expense = results[0] as List<CategoryFinanceSummary>;
    final income = results[1] as List<CategoryFinanceSummary>;
    final totals = results[2] as ({int expense, int income, int reimburse});
    final days = filter.dayCount.clamp(1, 1 << 31);
    return FinanceAnalyticsData(
      filter: filter,
      summary: FinanceAnalyticsSummary(
        totalExpense: totals.expense,
        totalIncome: totals.income,
        netBalance: totals.income - totals.expense,
        averageExpensePerDay: totals.expense ~/ days,
        averageIncomePerDay: totals.income ~/ days,
        totalReimburse: totals.reimburse,
        largestExpenseCategory: expense.firstOrNull,
        largestIncomeCategory: income.firstOrNull,
      ),
      expensesByCategory: expense,
      incomeByCategory: income,
      trend: results[3] as List<FinanceTrendPoint>,
    );
  }

  Future<List<CategoryFinanceSummary>> _categorySummary({
    required FinancialTransactionType type,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final rows = await database
        .customSelect(
          '''
SELECT c.id AS category_id, c.name AS category_name,
  COUNT(t.id) AS transaction_count, SUM(t.amount) AS total_amount
FROM financial_transactions t
JOIN financial_categories c ON c.id = t.category_id
WHERE t.type = ? AND t.transaction_date >= ? AND t.transaction_date < ?
GROUP BY c.id, c.name
ORDER BY total_amount DESC, c.name ASC
''',
          variables: [
            Variable<String>(type.storageValue),
            Variable<DateTime>(_analyticsDate(startDate)),
            Variable<DateTime>(_analyticsDate(endDate)),
          ],
          readsFrom: {
            database.financialTransactions,
            database.financialCategories,
          },
        )
        .get();
    final total = rows.fold<int>(
      0,
      (sum, row) => sum + row.read<int>('total_amount'),
    );
    return rows
        .map(
          (row) => CategoryFinanceSummary(
            categoryId: row.read<String>('category_id'),
            categoryName: row.read<String>('category_name'),
            transactionCount: row.read<int>('transaction_count'),
            totalAmount: row.read<int>('total_amount'),
            percentage: total == 0
                ? 0
                : row.read<int>('total_amount') / total * 100,
          ),
        )
        .toList(growable: false);
  }

  Future<({int expense, int income, int reimburse})> _analyticsTotals(
    FinanceAnalyticsFilter filter,
  ) async {
    final type = filter.type == FinanceAnalyticsType.all
        ? null
        : filter.type.name;
    final row = await database
        .customSelect(
          '''
SELECT
  COALESCE(SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END), 0) AS expense,
  COALESCE(SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END), 0) AS income,
  COALESCE(SUM(CASE WHEN type = 'expense' AND is_reimburse = 1 THEN amount ELSE 0 END), 0) AS reimburse
FROM financial_transactions
WHERE transaction_date >= ? AND transaction_date < ?
  AND (? IS NULL OR type = ?)
''',
          variables: [
            Variable<DateTime>(_analyticsDate(filter.startDate)),
            Variable<DateTime>(_analyticsDate(filter.endDate)),
            Variable<String>(type),
            Variable<String>(type),
          ],
          readsFrom: {database.financialTransactions},
        )
        .getSingle();
    return (
      expense: row.read<int>('expense'),
      income: row.read<int>('income'),
      reimburse: row.read<int>('reimburse'),
    );
  }

  Future<List<FinanceTrendPoint>> _trend(FinanceAnalyticsFilter filter) async {
    final bucket = switch (filter.granularity) {
      FinanceTrendGranularity.day =>
        "date(transaction_date, 'unixepoch', 'localtime')",
      FinanceTrendGranularity.week =>
        "date(transaction_date, 'unixepoch', 'localtime', '-' || ((CAST(strftime('%w', transaction_date, 'unixepoch', 'localtime') AS INTEGER) + 6) % 7) || ' days')",
      FinanceTrendGranularity.month =>
        "date(transaction_date, 'unixepoch', 'localtime', 'start of month')",
    };
    final type = filter.type == FinanceAnalyticsType.all
        ? null
        : filter.type.name;
    final rows = await database
        .customSelect(
          '''
SELECT $bucket AS bucket_date,
  COALESCE(SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END), 0) AS expense,
  COALESCE(SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END), 0) AS income
FROM financial_transactions
WHERE transaction_date >= ? AND transaction_date < ?
  AND (? IS NULL OR type = ?)
GROUP BY bucket_date
ORDER BY bucket_date ASC
''',
          variables: [
            Variable<DateTime>(_analyticsDate(filter.startDate)),
            Variable<DateTime>(_analyticsDate(filter.endDate)),
            Variable<String>(type),
            Variable<String>(type),
          ],
          readsFrom: {database.financialTransactions},
        )
        .get();
    return rows
        .map(
          (row) => FinanceTrendPoint(
            date: DateTime.parse(row.read<String>('bucket_date')),
            expenseAmount: row.read<int>('expense'),
            incomeAmount: row.read<int>('income'),
          ),
        )
        .toList(growable: false);
  }

  DateTime _analyticsDate(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  Future<FinancialPeriod> _getOrCreatePeriod(
    DateTime transactionDate, {
    FinanceSetting? settings,
  }) async {
    final date = FinancialPeriodResolver.normalize(transactionDate);
    final existing =
        await (database.select(database.financialPeriods)..where(
              (row) =>
                  row.startDate.isSmallerOrEqualValue(date) &
                  row.endDate.isBiggerOrEqualValue(date),
            ))
            .getSingleOrNull();
    if (existing != null) return existing;

    final activeSettings = settings ?? await getSettings();
    final previous =
        await (database.select(database.financialPeriods)
              ..where((row) => row.endDate.isSmallerThanValue(date))
              ..orderBy([(row) => OrderingTerm.desc(row.endDate)])
              ..limit(1))
            .getSingleOrNull();
    final next =
        await (database.select(database.financialPeriods)
              ..where((row) => row.startDate.isBiggerThanValue(date))
              ..orderBy([(row) => OrderingTerm.asc(row.startDate)])
              ..limit(1))
            .getSingleOrNull();

    FinancialPeriodRange range;
    if (previous != null &&
        previous.cycleStartDay != activeSettings.cycleStartDay) {
      range =
          _resolver.bridgeAfter(
            previousEndDate: previous.endDate,
            transactionDate: date,
            newCycleStartDay: activeSettings.cycleStartDay,
          ) ??
          _resolver.resolve(
            transactionDate: date,
            cycleStartDay: activeSettings.cycleStartDay,
          );
    } else if (previous == null && next != null) {
      range = _resolver.resolve(
        transactionDate: date,
        cycleStartDay: next.cycleStartDay,
      );
    } else {
      range = _resolver.resolve(
        transactionDate: date,
        cycleStartDay: activeSettings.cycleStartDay,
      );
    }

    final now = _now().toUtc();
    final id = _uuid.v4();
    await database
        .into(database.financialPeriods)
        .insert(
          FinancialPeriodsCompanion.insert(
            id: id,
            name: range.name,
            startDate: range.startDate,
            endDate: range.endDate,
            cycleStartDay: range.cycleStartDay,
            budgetAmount: Value(activeSettings.defaultBudgetAmount),
            createdAt: now,
            updatedAt: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );
    return (database.select(database.financialPeriods)..where(
          (row) =>
              row.startDate.equals(range.startDate) &
              row.endDate.equals(range.endDate),
        ))
        .getSingle();
  }

  Future<FinancialCategory> _validateInput(
    FinanceTransactionInput input, {
    String? allowInactiveCategoryId,
  }) async {
    if (input.name.trim().isEmpty) {
      throw const FormatException('transaction_name_empty');
    }
    if (input.amount <= 0) {
      throw const FormatException('transaction_amount_invalid');
    }
    if (input.type == FinancialTransactionType.income && input.isReimburse) {
      throw const FormatException('income_cannot_be_reimburse');
    }
    final category = await (database.select(
      database.financialCategories,
    )..where((row) => row.id.equals(input.categoryId))).getSingleOrNull();
    if (category == null || category.type != input.type.storageValue) {
      throw const FormatException('transaction_category_invalid');
    }
    if (!category.isActive && category.id != allowInactiveCategoryId) {
      throw const FormatException('transaction_category_inactive');
    }
    return category;
  }

  Selectable<QueryRow> _summaryQuery(String periodId) {
    return database.customSelect(
      '''
SELECT
  p.budget_amount AS budget_amount,
  COALESCE(SUM(CASE WHEN t.type = 'expense' THEN t.amount ELSE 0 END), 0) AS total_expense,
  COALESCE(SUM(CASE WHEN t.type = 'income' THEN t.amount ELSE 0 END), 0) AS total_income,
  COALESCE(SUM(CASE WHEN t.type = 'expense' AND t.is_reimburse = 1 THEN t.amount ELSE 0 END), 0) AS total_reimburse,
  COALESCE(SUM(CASE WHEN t.type = 'expense' AND t.is_reimburse = 0 THEN t.amount ELSE 0 END), 0) AS budget_usage
FROM financial_periods p
LEFT JOIN financial_transactions t ON t.financial_period_id = p.id
WHERE p.id = ?
GROUP BY p.id, p.budget_amount
''',
      variables: [Variable<String>(periodId)],
      readsFrom: {database.financialPeriods, database.financialTransactions},
    );
  }

  FinanceSummary _mapSummary(QueryRow row) {
    final budget = row.read<int>('budget_amount');
    final expense = row.read<int>('total_expense');
    final income = row.read<int>('total_income');
    final reimburse = row.read<int>('total_reimburse');
    final usage = row.read<int>('budget_usage');
    return FinanceSummary(
      totalExpense: expense,
      totalIncome: income,
      totalReimburse: reimburse,
      budgetUsage: usage,
      remainingBudget: budget - usage,
      netBalance: income - expense,
    );
  }

  FinanceTransactionRecord _mapTransactionRow(TypedResult row) {
    final transaction = row.readTable(database.financialTransactions);
    final category = row.readTable(database.financialCategories);
    return FinanceTransactionRecord(
      id: transaction.id,
      type: FinancialTransactionTypeStorage.parse(transaction.type),
      name: transaction.name,
      amount: transaction.amount,
      currencyCode: transaction.currencyCode,
      transactionDate: transaction.transactionDate,
      categoryId: transaction.categoryId,
      categoryName: category.name,
      notes: transaction.notes,
      isReimburse: transaction.isReimburse,
      periodId: transaction.financialPeriodId,
      createdAt: transaction.createdAt,
      updatedAt: transaction.updatedAt,
    );
  }

  String? _cleanOptional(String? value) {
    final cleaned = value?.trim();
    return cleaned == null || cleaned.isEmpty ? null : cleaned;
  }
}
