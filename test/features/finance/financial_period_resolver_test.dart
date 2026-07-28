import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/finance/domain/financial_period_resolver.dart';

void main() {
  const resolver = FinancialPeriodResolver();

  test('24 Juli belongs to Periode Juli for cycle day 25', () {
    final range = resolver.resolve(
      transactionDate: DateTime(2026, 7, 24, 23, 59),
      cycleStartDay: 25,
    );

    expect(range.startDate, DateTime(2026, 6, 25));
    expect(range.endDate, DateTime(2026, 7, 24));
    expect(range.name, 'Periode Juli 2026');
  });

  test('25 Juli starts Periode Agustus', () {
    final range = resolver.resolve(
      transactionDate: DateTime(2026, 7, 25),
      cycleStartDay: 25,
    );

    expect(range.startDate, DateTime(2026, 7, 25));
    expect(range.endDate, DateTime(2026, 8, 24));
    expect(range.name, 'Periode Agustus 2026');
  });

  test('handles year transition', () {
    final range = resolver.resolve(
      transactionDate: DateTime(2027, 1, 3),
      cycleStartDay: 25,
    );

    expect(range.startDate, DateTime(2026, 12, 25));
    expect(range.endDate, DateTime(2027, 1, 24));
    expect(range.name, 'Periode Januari 2027');
  });

  test('handles leap and non-leap February without fixed durations', () {
    final leap = resolver.resolve(
      transactionDate: DateTime(2028, 2, 20),
      cycleStartDay: 1,
    );
    final regular = resolver.resolve(
      transactionDate: DateTime(2027, 2, 20),
      cycleStartDay: 1,
    );

    expect(leap.endDate, DateTime(2028, 2, 29));
    expect(regular.endDate, DateTime(2027, 2, 28));
  });

  test('creates a short bridge before the first complete new cycle', () {
    final bridge = resolver.bridgeAfter(
      previousEndDate: DateTime(2026, 7, 24),
      transactionDate: DateTime(2026, 7, 30),
      newCycleStartDay: 10,
    );

    expect(bridge, isNotNull);
    expect(bridge!.startDate, DateTime(2026, 7, 25));
    expect(bridge.endDate, DateTime(2026, 8, 9));
    expect(bridge.name, 'Periode Agustus 2026');
    expect(bridge.isBridge, isTrue);
  });

  test('does not create a bridge when boundaries are contiguous', () {
    final bridge = resolver.bridgeAfter(
      previousEndDate: DateTime(2026, 7, 24),
      transactionDate: DateTime(2026, 7, 25),
      newCycleStartDay: 25,
    );

    expect(bridge, isNull);
  });

  test('rejects cycle start outside 1 through 28', () {
    expect(
      () => resolver.resolve(
        transactionDate: DateTime(2026, 7, 22),
        cycleStartDay: 29,
      ),
      throwsRangeError,
    );
  });
}
