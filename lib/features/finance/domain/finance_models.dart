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
    required this.periodId,
    this.type,
    this.categoryId,
    this.isReimburse,
    this.search,
  });

  final String periodId;
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
  final DateTime createdAt;
  final DateTime updatedAt;
}
