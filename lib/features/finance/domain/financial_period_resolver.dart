class FinancialPeriodRange {
  const FinancialPeriodRange({
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.cycleStartDay,
    this.isBridge = false,
  });

  final DateTime startDate;
  final DateTime endDate;
  final String name;
  final int cycleStartDay;
  final bool isBridge;

  bool contains(DateTime value) {
    final date = FinancialPeriodResolver.normalize(value);
    return !date.isBefore(startDate) && !date.isAfter(endDate);
  }
}

class FinancialPeriodResolver {
  const FinancialPeriodResolver();

  FinancialPeriodRange resolve({
    required DateTime transactionDate,
    required int cycleStartDay,
  }) {
    _validateCycleStartDay(cycleStartDay);
    final date = normalize(transactionDate);
    final start = date.day >= cycleStartDay
        ? DateTime(date.year, date.month, cycleStartDay)
        : DateTime(date.year, date.month - 1, cycleStartDay);
    final end = DateTime(
      start.year,
      start.month + 1,
      cycleStartDay,
    ).subtract(const Duration(days: 1));
    return FinancialPeriodRange(
      startDate: start,
      endDate: end,
      name: periodName(end),
      cycleStartDay: cycleStartDay,
    );
  }

  FinancialPeriodRange? bridgeAfter({
    required DateTime previousEndDate,
    required DateTime transactionDate,
    required int newCycleStartDay,
  }) {
    _validateCycleStartDay(newCycleStartDay);
    final firstUncovered = normalize(
      previousEndDate,
    ).add(const Duration(days: 1));
    var nextBoundary = DateTime(
      firstUncovered.year,
      firstUncovered.month,
      newCycleStartDay,
    );
    if (nextBoundary.isBefore(firstUncovered)) {
      nextBoundary = DateTime(
        firstUncovered.year,
        firstUncovered.month + 1,
        newCycleStartDay,
      );
    }
    if (nextBoundary == firstUncovered) return null;
    final bridgeEnd = nextBoundary.subtract(const Duration(days: 1));
    final date = normalize(transactionDate);
    if (date.isBefore(firstUncovered) || date.isAfter(bridgeEnd)) return null;
    return FinancialPeriodRange(
      startDate: firstUncovered,
      endDate: bridgeEnd,
      name: periodName(bridgeEnd),
      cycleStartDay: newCycleStartDay,
      isBridge: true,
    );
  }

  static DateTime normalize(DateTime value) {
    final local = value.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  static String periodName(DateTime endDate) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return 'Periode ${months[endDate.month - 1]} ${endDate.year}';
  }

  void _validateCycleStartDay(int value) {
    if (value < 1 || value > 28) {
      throw RangeError.range(value, 1, 28, 'cycleStartDay');
    }
  }
}
