import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/food_chat/domain/financial_review_models.dart';

void main() {
  const categories = [
    FinancialReviewCategory(
      id: 'expense-other',
      name: 'Lainnya',
      type: FinancialTransactionType.expense,
    ),
    FinancialReviewCategory(
      id: 'income-other',
      name: 'Lainnya',
      type: FinancialTransactionType.income,
    ),
  ];

  test('type conversion mengganti kategori dan mematikan reimburse', () {
    final expense = FinancialReviewItem(
      reviewId: 'one',
      type: FinancialTransactionType.expense,
      name: 'Talangan kantor',
      amount: 50000,
      transactionDate: DateTime(2026, 7, 22),
      categoryId: 'expense-other',
      categoryName: 'Lainnya',
      isReimburse: true,
    );

    final income = expense.convertType(
      FinancialTransactionType.income,
      categories,
    );

    expect(income.type, FinancialTransactionType.income);
    expect(income.categoryId, 'income-other');
    expect(income.isReimburse, isFalse);
    expect(income.toInput().isReimburse, isFalse);
  });

  test('expense mempertahankan reimburse pada edit field lain', () {
    final item = FinancialReviewItem(
      reviewId: 'one',
      type: FinancialTransactionType.expense,
      name: 'Bensin',
      amount: 100000,
      transactionDate: DateTime(2026, 7, 22),
      categoryId: 'expense-other',
      categoryName: 'Lainnya',
      isReimburse: true,
    ).copyWith(name: 'Bensin kantor', notes: 'Tunggu penggantian');

    expect(item.isReimburse, isTrue);
    expect(item.notes, 'Tunggu penggantian');
  });
}
