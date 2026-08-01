import 'package:drift/drift.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/net_worth/domain/net_worth_models.dart';

abstract interface class NetWorthRepository {
  Future<NetWorthInitializationModel?> getInitialization();
  Future<void> saveInitialization(NetWorthInitializationModel initialization);
  Future<void> updateInitialization(NetWorthInitializationModel initialization);
  Future<void> addAdjustment(NetWorthAdjustmentModel adjustment);
  Future<void> updateAdjustment(NetWorthAdjustmentModel adjustment);
  Future<void> deleteAdjustment(String adjustmentId);
  Future<int> calculateCurrentNetWorth();
  Future<int> calculateNetWorthChange({
    required DateTime startDate,
    required DateTime endDate,
  });
  Stream<int> watchCurrentNetWorth();
}

class DriftNetWorthRepository implements NetWorthRepository {
  DriftNetWorthRepository(this.database);

  final AppDatabase database;

  @override
  Future<NetWorthInitializationModel?> getInitialization() async {
    final row =
        await (database.select(database.netWorthInitializations)..where(
              (row) => row.id.equals(NetWorthInitializationModel.singletonId),
            ))
            .getSingleOrNull();
    return row == null ? null : _initialization(row);
  }

  Stream<NetWorthOverview?> watchOverview() => _overviewQuery()
      .watchSingleOrNull()
      .map((row) => row == null ? null : _overview(row));

  Future<NetWorthOverview?> getOverview() => _overviewQuery()
      .getSingleOrNull()
      .then((row) => row == null ? null : _overview(row));

  Future<NetWorthDetail?> getDetail() async {
    final overview = await getOverview();
    if (overview == null) return null;
    final rows =
        await (database.select(database.netWorthAdjustments)..orderBy([
              (row) => OrderingTerm.desc(row.adjustmentDate),
              (row) => OrderingTerm.desc(row.createdAt),
            ]))
            .get();
    return NetWorthDetail(
      overview: overview,
      adjustments: rows.map(_adjustment).toList(growable: false),
    );
  }

  Future<({int transactions, int adjustments})> countExcludedBefore(
    DateTime initializationDate,
  ) async {
    final date = _date(initializationDate);
    final row = await database
        .customSelect(
          '''
SELECT
  (SELECT COUNT(*) FROM financial_transactions WHERE transaction_date < ?) AS transactions,
  (SELECT COUNT(*) FROM net_worth_adjustments WHERE adjustment_date < ?) AS adjustments
''',
          variables: [Variable<DateTime>(date), Variable<DateTime>(date)],
          readsFrom: {
            database.financialTransactions,
            database.netWorthAdjustments,
          },
        )
        .getSingle();
    return (
      transactions: row.read<int>('transactions'),
      adjustments: row.read<int>('adjustments'),
    );
  }

  @override
  Future<void> saveInitialization(
    NetWorthInitializationModel initialization,
  ) async {
    _validateInitialization(initialization);
    if (await getInitialization() != null) {
      throw StateError('net_worth_already_initialized');
    }
    await database
        .into(database.netWorthInitializations)
        .insert(
          NetWorthInitializationsCompanion.insert(
            id: NetWorthInitializationModel.singletonId,
            initialAmount: initialization.initialAmount,
            initializationDate: _date(initialization.initializationDate),
            notes: Value(_clean(initialization.notes)),
            currencyCode: const Value('IDR'),
            createdAt: initialization.createdAt.toUtc(),
            updatedAt: initialization.updatedAt.toUtc(),
          ),
        );
  }

  @override
  Future<void> updateInitialization(
    NetWorthInitializationModel initialization,
  ) async {
    _validateInitialization(initialization);
    final affected =
        await (database.update(database.netWorthInitializations)..where(
              (row) => row.id.equals(NetWorthInitializationModel.singletonId),
            ))
            .write(
              NetWorthInitializationsCompanion(
                initialAmount: Value(initialization.initialAmount),
                initializationDate: Value(
                  _date(initialization.initializationDate),
                ),
                notes: Value(_clean(initialization.notes)),
                currencyCode: const Value('IDR'),
                updatedAt: Value(initialization.updatedAt.toUtc()),
              ),
            );
    if (affected != 1) throw StateError('net_worth_not_initialized');
  }

  @override
  Future<void> addAdjustment(NetWorthAdjustmentModel adjustment) async {
    await _validateAdjustment(adjustment);
    await database
        .into(database.netWorthAdjustments)
        .insert(
          NetWorthAdjustmentsCompanion.insert(
            id: adjustment.id,
            name: adjustment.name.trim(),
            amount: adjustment.amount,
            adjustmentDate: _date(adjustment.adjustmentDate),
            notes: Value(_clean(adjustment.notes)),
            createdAt: adjustment.createdAt.toUtc(),
            updatedAt: adjustment.updatedAt.toUtc(),
          ),
        );
  }

  @override
  Future<void> updateAdjustment(NetWorthAdjustmentModel adjustment) async {
    await _validateAdjustment(adjustment, allowBeforeInitialization: true);
    final affected =
        await (database.update(
          database.netWorthAdjustments,
        )..where((row) => row.id.equals(adjustment.id))).write(
          NetWorthAdjustmentsCompanion(
            name: Value(adjustment.name.trim()),
            amount: Value(adjustment.amount),
            adjustmentDate: Value(_date(adjustment.adjustmentDate)),
            notes: Value(_clean(adjustment.notes)),
            updatedAt: Value(adjustment.updatedAt.toUtc()),
          ),
        );
    if (affected != 1) throw StateError('net_worth_adjustment_not_found');
  }

  @override
  Future<void> deleteAdjustment(String adjustmentId) async {
    final affected = await (database.delete(
      database.netWorthAdjustments,
    )..where((row) => row.id.equals(adjustmentId))).go();
    if (affected != 1) throw StateError('net_worth_adjustment_not_found');
  }

  @override
  Future<int> calculateCurrentNetWorth() async {
    final value = await getOverview();
    if (value == null) throw StateError('net_worth_not_initialized');
    return value.currentNetWorth;
  }

  @override
  Stream<int> watchCurrentNetWorth() => watchOverview().map((value) {
    if (value == null) throw StateError('net_worth_not_initialized');
    return value.currentNetWorth;
  });

  @override
  Future<int> calculateNetWorthChange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final initialization = await getInitialization();
    if (initialization == null) throw StateError('net_worth_not_initialized');
    final start = _date(startDate).isBefore(initialization.initializationDate)
        ? initialization.initializationDate
        : _date(startDate);
    final end = _date(endDate);
    if (!end.isAfter(start)) return 0;
    final row = await database
        .customSelect(
          '''
SELECT
  COALESCE(SUM(CASE WHEN type = 'income' THEN amount ELSE -amount END), 0) AS transaction_change,
  COALESCE((SELECT SUM(amount) FROM net_worth_adjustments
    WHERE adjustment_date >= ? AND adjustment_date < ?), 0) AS adjustment_change
FROM financial_transactions
WHERE transaction_date >= ? AND transaction_date < ?
''',
          variables: [
            Variable<DateTime>(start),
            Variable<DateTime>(end),
            Variable<DateTime>(start),
            Variable<DateTime>(end),
          ],
          readsFrom: {
            database.financialTransactions,
            database.netWorthAdjustments,
          },
        )
        .getSingle();
    return row.read<int>('transaction_change') +
        row.read<int>('adjustment_change');
  }

  Selectable<QueryRow> _overviewQuery() => database.customSelect(
    '''
SELECT
  i.id, i.initial_amount, i.initialization_date, i.notes, i.currency_code,
  i.created_at, i.updated_at,
  COALESCE((SELECT SUM(amount) FROM financial_transactions
    WHERE type = 'income' AND transaction_date >= i.initialization_date), 0) AS total_income,
  COALESCE((SELECT SUM(amount) FROM financial_transactions
    WHERE type = 'expense' AND transaction_date >= i.initialization_date), 0) AS total_expense,
  COALESCE((SELECT SUM(amount) FROM net_worth_adjustments
    WHERE adjustment_date >= i.initialization_date), 0) AS total_adjustments,
  MAX(
    i.updated_at,
    COALESCE((SELECT MAX(updated_at) FROM financial_transactions
      WHERE transaction_date >= i.initialization_date), i.updated_at),
    COALESCE((SELECT MAX(updated_at) FROM net_worth_adjustments
      WHERE adjustment_date >= i.initialization_date), i.updated_at)
  ) AS last_updated_at
FROM net_worth_initialization i
WHERE i.id = 'local_net_worth'
''',
    readsFrom: {
      database.netWorthInitializations,
      database.netWorthAdjustments,
      database.financialTransactions,
    },
  );

  NetWorthOverview _overview(QueryRow row) {
    final initialization = NetWorthInitializationModel(
      id: row.read<String>('id'),
      initialAmount: row.read<int>('initial_amount'),
      initializationDate: row.read<DateTime>('initialization_date'),
      notes: row.readNullable<String>('notes'),
      currencyCode: row.read<String>('currency_code'),
      createdAt: row.read<DateTime>('created_at'),
      updatedAt: row.read<DateTime>('updated_at'),
    );
    final income = row.read<int>('total_income');
    final expense = row.read<int>('total_expense');
    final adjustments = row.read<int>('total_adjustments');
    return NetWorthOverview(
      initialization: initialization,
      totalIncome: income,
      totalExpense: expense,
      totalAdjustments: adjustments,
      currentNetWorth:
          initialization.initialAmount + income - expense + adjustments,
      lastUpdatedAt: row.read<DateTime>('last_updated_at'),
    );
  }

  NetWorthInitializationModel _initialization(NetWorthInitialization row) =>
      NetWorthInitializationModel(
        id: row.id,
        initialAmount: row.initialAmount,
        initializationDate: row.initializationDate,
        notes: row.notes,
        currencyCode: row.currencyCode,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  NetWorthAdjustmentModel _adjustment(NetWorthAdjustment row) =>
      NetWorthAdjustmentModel(
        id: row.id,
        name: row.name,
        amount: row.amount,
        adjustmentDate: row.adjustmentDate,
        notes: row.notes,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  Future<void> _validateAdjustment(
    NetWorthAdjustmentModel value, {
    bool allowBeforeInitialization = false,
  }) async {
    if (value.name.trim().isEmpty) {
      throw const FormatException('net_worth_adjustment_name_empty');
    }
    if (value.amount == 0) {
      throw const FormatException('net_worth_adjustment_amount_zero');
    }
    final initialization = await getInitialization();
    if (initialization == null) throw StateError('net_worth_not_initialized');
    if (!allowBeforeInitialization &&
        _date(
          value.adjustmentDate,
        ).isBefore(initialization.initializationDate)) {
      throw const FormatException('net_worth_adjustment_before_initialization');
    }
  }

  void _validateInitialization(NetWorthInitializationModel value) {
    if (value.id != NetWorthInitializationModel.singletonId) {
      throw const FormatException('net_worth_initialization_id_invalid');
    }
    if (value.currencyCode != 'IDR') {
      throw const FormatException('net_worth_currency_invalid');
    }
  }

  DateTime _date(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  String? _clean(String? value) {
    final cleaned = value?.trim();
    return cleaned == null || cleaned.isEmpty ? null : cleaned;
  }
}
