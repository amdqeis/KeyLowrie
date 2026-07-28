/// Data models untuk laporan PDF — keuangan dan kalori.
/// Tidak ada dependency ke Gemini atau network.
library;

enum ReportType { finance, calorie }

// ─── Finance Report ────────────────────────────────────────────────────────

class FinanceCategoryRow {
  const FinanceCategoryRow({
    required this.categoryName,
    required this.transactionCount,
    required this.total,
  });

  final String categoryName;
  final int transactionCount;
  final int total;
}

class FinanceTransactionRow {
  const FinanceTransactionRow({
    required this.date,
    required this.type,
    required this.name,
    required this.categoryName,
    required this.isReimburse,
    required this.amount,
  });

  final DateTime date;
  final String type; // 'expense' | 'income'
  final String name;
  final String categoryName;
  final bool isReimburse;
  final int amount;
}

class FinanceReportData {
  const FinanceReportData({
    required this.periodName,
    required this.rangeStart,
    required this.rangeEnd,
    required this.generatedAt,
    required this.currencyCode,
    required this.budgetAmount,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalReimburse,
    required this.budgetUsage,
    required this.remainingBudget,
    required this.netBalance,
    required this.expenseCount,
    required this.incomeCount,
    required this.expenseCategories,
    required this.incomeCategories,
    required this.transactions,
  });

  final String periodName;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  final DateTime generatedAt;
  final String currencyCode;

  /// Budget dari periode keuangan (0 jika rentang kustom tanpa periode)
  final int budgetAmount;

  /// SUM semua transaksi type=expense
  final int totalExpense;

  /// SUM semua transaksi type=income
  final int totalIncome;

  /// SUM expense WHERE is_reimburse=true
  final int totalReimburse;

  /// SUM expense WHERE is_reimburse=false (tidak termasuk reimburse)
  final int budgetUsage;

  /// budgetAmount - budgetUsage (bisa negatif)
  final int remainingBudget;

  /// totalIncome - totalExpense
  final int netBalance;

  final int expenseCount;
  final int incomeCount;

  /// Sorted by total desc
  final List<FinanceCategoryRow> expenseCategories;
  final List<FinanceCategoryRow> incomeCategories;
  final List<FinanceTransactionRow> transactions;

  bool get isEmpty => transactions.isEmpty;
}

// ─── Calorie Report ────────────────────────────────────────────────────────

class FoodItemReportRow {
  const FoodItemReportRow({
    required this.date,
    required this.foodName,
    required this.portionText,
    required this.caloriesKcal,
    this.proteinG,
    this.carbsG,
    this.fatG,
  });

  final DateTime date;
  final String foodName;
  final String portionText;
  final double caloriesKcal;
  final double? proteinG;
  final double? carbsG;
  final double? fatG;
}

class DailyCalorieSummary {
  const DailyCalorieSummary({
    required this.date,
    required this.totalCalories,
    required this.targetCalories,
    this.proteinG,
    this.carbsG,
    this.fatG,
  });

  final DateTime date;
  final double totalCalories;
  final int? targetCalories;

  /// Kalori aktual - target. Null jika tidak ada target.
  double? get difference =>
      targetCalories != null ? totalCalories - targetCalories! : null;

  final double? proteinG;
  final double? carbsG;
  final double? fatG;
}

class CalorieReportData {
  const CalorieReportData({
    required this.rangeStart,
    required this.rangeEnd,
    required this.generatedAt,
    required this.dailySummaries,
    required this.foodItems,
    required this.defaultTargetCalories,
    required this.daysWithData,
    required this.daysWithoutData,
  });

  final DateTime rangeStart;
  final DateTime rangeEnd;
  final DateTime generatedAt;
  final List<DailyCalorieSummary> dailySummaries;
  final List<FoodItemReportRow> foodItems;

  /// Target kalori yang berlaku untuk rentang ini (dari DailyTargets)
  final int? defaultTargetCalories;

  final int daysWithData;
  final int daysWithoutData;

  bool get isEmpty => foodItems.isEmpty;

  /// Rata-rata kalori hanya dari hari yang punya data
  double? get avgCalories {
    if (daysWithData == 0) return null;
    final total = dailySummaries
        .where((d) => d.totalCalories > 0)
        .fold<double>(0, (sum, d) => sum + d.totalCalories);
    return total / daysWithData;
  }

  double? get avgProtein {
    final days = dailySummaries.where((d) => d.proteinG != null).toList();
    if (days.isEmpty) return null;
    return days.fold<double>(0, (sum, d) => sum + d.proteinG!) / days.length;
  }

  double? get avgCarbs {
    final days = dailySummaries.where((d) => d.carbsG != null).toList();
    if (days.isEmpty) return null;
    return days.fold<double>(0, (sum, d) => sum + d.carbsG!) / days.length;
  }

  double? get avgFat {
    final days = dailySummaries.where((d) => d.fatG != null).toList();
    if (days.isEmpty) return null;
    return days.fold<double>(0, (sum, d) => sum + d.fatG!) / days.length;
  }

  int get daysBelowTarget => dailySummaries.where((d) {
    final target = d.targetCalories ?? defaultTargetCalories;
    return target != null && d.totalCalories < target;
  }).length;

  int get daysAtTarget => dailySummaries.where((d) {
    final target = d.targetCalories ?? defaultTargetCalories;
    if (target == null) return false;
    return (d.totalCalories - target).abs() <= 50;
  }).length;

  int get daysAboveTarget => dailySummaries.where((d) {
    final target = d.targetCalories ?? defaultTargetCalories;
    return target != null && d.totalCalories > target + 50;
  }).length;
}
