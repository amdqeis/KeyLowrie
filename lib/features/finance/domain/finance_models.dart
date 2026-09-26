enum FinancialTransactionType { expense, income }

extension FinancialTransactionTypeStorage on FinancialTransactionType {
  String get storageValue => name;

  static FinancialTransactionType parse(String value) =>
      FinancialTransactionType.values.firstWhere(
        (type) => type.name == value,
        orElse: () =>
            throw FormatException('financial_transaction_type_invalid:$value'),
      );
}

enum InstallmentType { evenSplit, fixedMonthly }

extension InstallmentTypeStorage on InstallmentType {
  String get storageValue => switch (this) {
    InstallmentType.evenSplit => 'even_split',
    InstallmentType.fixedMonthly => 'fixed_monthly',
  };

  static InstallmentType parse(String value) => switch (value) {
    'even_split' => InstallmentType.evenSplit,
    'fixed_monthly' => InstallmentType.fixedMonthly,
    _ => throw FormatException('installment_type_invalid:$value'),
  };
}

enum InstallmentPlanStatus { active, completed, cancelled }

extension InstallmentPlanStatusStorage on InstallmentPlanStatus {
  String get storageValue => name;

  static InstallmentPlanStatus parse(String value) =>
      InstallmentPlanStatus.values.firstWhere(
        (s) => s.name == value,
        orElse: () =>
            throw FormatException('installment_plan_status_invalid:$value'),
      );
}

class FinanceTransactionInput {
  const FinanceTransactionInput({
    required this.type,
    required this.name,
    required this.amount,
    required this.transactionDate,
    required this.categoryId,
    this.id,
    this.notes,
    this.isReimburse = false,
  });

  final String? id;
  final FinancialTransactionType type;
  final String name;
  final int amount;
  final DateTime transactionDate;
  final String categoryId;
  final String? notes;
  final bool isReimburse;
}

class FinanceSummary {
  const FinanceSummary({
    required this.totalExpense,
    required this.totalIncome,
    required this.totalReimburse,
    required this.budgetUsage,
    required this.remainingBudget,
    required this.netBalance,
  });

  final int totalExpense;
  final int totalIncome;
  final int totalReimburse;
  final int budgetUsage;
  final int remainingBudget;
  final int netBalance;
}

class FinanceCategoryBreakdown {
  const FinanceCategoryBreakdown({
    required this.categoryId,
    required this.categoryName,
    required this.total,
  });

  final String categoryId;
  final String categoryName;
  final int total;
}

class FinanceTransactionFilter {
  const FinanceTransactionFilter({
    this.periodId,
    this.startDate,
    this.endDate,
    this.type,
    this.categoryId,
    this.isReimburse,
    this.search,
  });

  final String? periodId;
  final DateTime? startDate;
  final DateTime? endDate;
  final FinancialTransactionType? type;
  final String? categoryId;
  final bool? isReimburse;
  final String? search;
}

class FinanceTransactionRecord {
  const FinanceTransactionRecord({
    required this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.currencyCode,
    required this.transactionDate,
    required this.categoryId,
    required this.categoryName,
    required this.isReimburse,
    required this.periodId,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
    this.installmentPlanId,
    this.installmentNumber,
  });

  final String id;
  final FinancialTransactionType type;
  final String name;
  final int amount;
  final String currencyCode;
  final DateTime transactionDate;
  final String categoryId;
  final String categoryName;
  final String? notes;
  final bool isReimburse;
  final String periodId;
  final String? installmentPlanId;
  final int? installmentNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isInstallment => installmentPlanId != null;
}

enum FinanceAnalyticsType { all, expense, income }

enum FinanceTrendGranularity { day, week, month }

class FinanceAnalyticsFilter {
  const FinanceAnalyticsFilter({
    required this.startDate,
    required this.endDate,
    this.type = FinanceAnalyticsType.all,
  });

  final DateTime startDate;
  final DateTime endDate;
  final FinanceAnalyticsType type;

  int get dayCount => endDate.difference(startDate).inDays;

  FinanceTrendGranularity get granularity => dayCount <= 31
      ? FinanceTrendGranularity.day
      : dayCount <= 180
      ? FinanceTrendGranularity.week
      : FinanceTrendGranularity.month;

  @override
  bool operator ==(Object other) =>
      other is FinanceAnalyticsFilter &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.type == type;

  @override
  int get hashCode => Object.hash(startDate, endDate, type);
}

class CategoryFinanceSummary {
  const CategoryFinanceSummary({
    required this.categoryId,
    required this.categoryName,
    required this.transactionCount,
    required this.totalAmount,
    required this.percentage,
  });

  final String categoryId;
  final String categoryName;
  final int transactionCount;
  final int totalAmount;
  final double percentage;
}

class FinanceTrendPoint {
  const FinanceTrendPoint({
    required this.date,
    required this.expenseAmount,
    required this.incomeAmount,
  });

  final DateTime date;
  final int expenseAmount;
  final int incomeAmount;
}

class FinanceAnalyticsSummary {
  const FinanceAnalyticsSummary({
    required this.totalExpense,
    required this.totalIncome,
    required this.netBalance,
    required this.averageExpensePerDay,
    required this.averageIncomePerDay,
    required this.totalReimburse,
    this.largestExpenseCategory,
    this.largestIncomeCategory,
  });

  final int totalExpense;
  final int totalIncome;
  final int netBalance;
  final int averageExpensePerDay;
  final int averageIncomePerDay;
  final int totalReimburse;
  final CategoryFinanceSummary? largestExpenseCategory;
  final CategoryFinanceSummary? largestIncomeCategory;
}

class FinanceAnalyticsData {
  const FinanceAnalyticsData({
    required this.filter,
    required this.summary,
    required this.expensesByCategory,
    required this.incomeByCategory,
    required this.trend,
  });

  final FinanceAnalyticsFilter filter;
  final FinanceAnalyticsSummary summary;
  final List<CategoryFinanceSummary> expensesByCategory;
  final List<CategoryFinanceSummary> incomeByCategory;
  final List<FinanceTrendPoint> trend;
}

class InstallmentPlanInput {
  const InstallmentPlanInput({
    required this.name,
    required this.totalAmount,
    required this.installmentType,
    required this.dayOfMonth,
    required this.categoryId,
    required this.startDate,
    this.totalInstallments,
    this.monthlyAmount,
    this.notes,
  });

  final String name;
  final int totalAmount;
  final InstallmentType installmentType;
  final int dayOfMonth;
  final String categoryId;
  final DateTime startDate;
  /// Required for `evenSplit`. Ignored for `fixedMonthly`.
  final int? totalInstallments;
  /// Required for `fixedMonthly`. Ignored for `evenSplit`.
  final int? monthlyAmount;
  final String? notes;
}

class InstallmentPlanRecord {
  const InstallmentPlanRecord({
    required this.id,
    required this.name,
    required this.totalAmount,
    required this.installmentType,
    required this.totalInstallments,
    required this.monthlyAmount,
    required this.startDate,
    required this.dayOfMonth,
    required this.categoryId,
    required this.categoryName,
    required this.generatedCount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  final String id;
  final String name;
  final int totalAmount;
  final InstallmentType installmentType;
  final int totalInstallments;
  final int monthlyAmount;
  final DateTime startDate;
  final int dayOfMonth;
  final String categoryId;
  final String categoryName;
  final String? notes;
  final int generatedCount;
  final InstallmentPlanStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  int get remainingInstallments => totalInstallments - generatedCount;
  int get paidAmount => generatedCount * monthlyAmount;
  int get remainingAmount => totalAmount - paidAmount;
  bool get isCompleted => status == InstallmentPlanStatus.completed;
  bool get isActive => status == InstallmentPlanStatus.active;
}
