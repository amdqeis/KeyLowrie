import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';

class FinancialReviewCategory {
  const FinancialReviewCategory({
    required this.id,
    required this.name,
    required this.type,
  });

  final String id;
  final String name;
  final FinancialTransactionType type;
}

class FinancialReviewItem {
  const FinancialReviewItem({
    required this.reviewId,
    required this.type,
    required this.name,
    required this.amount,
    required this.transactionDate,
    required this.categoryId,
    required this.categoryName,
    required this.isReimburse,
    this.notes,
    this.isInstallment = false,
    this.installmentType = InstallmentType.evenSplit,
    this.totalInstallments = 12,
    this.installmentMonthlyAmount,
    this.dayOfMonth = 1,
  });

  factory FinancialReviewItem.fromParsed({
    required String reviewId,
    required ParsedFinancialItem parsed,
    required FinancialTransactionType type,
    bool isReimburse = false,
  }) {
    return FinancialReviewItem(
      reviewId: reviewId,
      type: type,
      name: parsed.name,
      amount: parsed.amount,
      transactionDate: parsed.transactionDate,
      categoryId: parsed.categoryId,
      categoryName: parsed.categoryName,
      isReimburse: type == FinancialTransactionType.expense && isReimburse,
      notes: parsed.notes,
    );
  }

  final String reviewId;
  final FinancialTransactionType type;
  final String name;
  final int amount;
  final DateTime transactionDate;
  final String categoryId;
  final String categoryName;
  final String? notes;
  final bool isReimburse;

  /// Apakah item ini merupakan cicilan (installment plan).
  final bool isInstallment;

  /// Tipe cicilan: bagi rata atau tetap per bulan.
  final InstallmentType installmentType;

  /// Jumlah bulan cicilan (untuk evenSplit).
  final int totalInstallments;

  /// Cicilan per bulan (untuk fixedMonthly). Null = belum diisi.
  final int? installmentMonthlyAmount;

  /// Tanggal jatuh tempo setiap bulan (1-28).
  final int dayOfMonth;

  FinancialReviewItem copyWith({
    FinancialTransactionType? type,
    String? name,
    int? amount,
    DateTime? transactionDate,
    String? categoryId,
    String? categoryName,
    String? notes,
    bool? isReimburse,
    bool? isInstallment,
    InstallmentType? installmentType,
    int? totalInstallments,
    int? installmentMonthlyAmount,
    int? dayOfMonth,
  }) {
    final nextType = type ?? this.type;
    final nextIsInstallment = nextType == FinancialTransactionType.expense
        ? isInstallment ?? this.isInstallment
        : false;
    return FinancialReviewItem(
      reviewId: reviewId,
      type: nextType,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      transactionDate: transactionDate ?? this.transactionDate,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      notes: notes ?? this.notes,
      isReimburse: nextType == FinancialTransactionType.expense
          ? isReimburse ?? this.isReimburse
          : false,
      isInstallment: nextIsInstallment,
      installmentType: installmentType ?? this.installmentType,
      totalInstallments: totalInstallments ?? this.totalInstallments,
      installmentMonthlyAmount:
          installmentMonthlyAmount ?? this.installmentMonthlyAmount,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
    );
  }

  FinancialReviewItem convertType(
    FinancialTransactionType target,
    List<FinancialReviewCategory> categories,
  ) {
    if (target == type) return this;
    final eligible = categories
        .where((category) => category.type == target)
        .toList(growable: false);
    if (eligible.isEmpty) {
      throw StateError('review_category_missing_for_type');
    }
    final category = eligible.firstWhere(
      (value) => value.name.trim().toLowerCase() == 'lainnya',
      orElse: () => eligible.first,
    );
    return copyWith(
      type: target,
      categoryId: category.id,
      categoryName: category.name,
      isReimburse: false,
      isInstallment: false,
    );
  }

  FinanceTransactionInput toInput() {
    return FinanceTransactionInput(
      type: type,
      name: name,
      amount: amount,
      transactionDate: transactionDate,
      categoryId: categoryId,
      notes: notes,
      isReimburse: isReimburse,
    );
  }

  /// Konversi ke InstallmentPlanInput untuk item yang ditandai cicilan.
  InstallmentPlanInput toInstallmentInput() {
    assert(isInstallment, 'Item harus ditandai cicilan');
    return InstallmentPlanInput(
      name: name,
      totalAmount: amount,
      installmentType: installmentType,
      dayOfMonth: dayOfMonth,
      categoryId: categoryId,
      startDate: transactionDate,
      totalInstallments:
          installmentType == InstallmentType.evenSplit
              ? totalInstallments
              : null,
      monthlyAmount:
          installmentType == InstallmentType.fixedMonthly
              ? installmentMonthlyAmount
              : null,
      notes: notes,
    );
  }
}
