import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';

final activeFinancePeriodProvider = FutureProvider<FinancialPeriod>((ref) {
  return ref.watch(financeRepositoryProvider).getOrCreatePeriod(DateTime.now());
});

final financePeriodsProvider = StreamProvider<List<FinancialPeriod>>((ref) {
  return ref.watch(financeRepositoryProvider).watchPeriods();
});

final financeSettingsProvider = StreamProvider<FinanceSetting>((ref) {
  return ref.watch(financeRepositoryProvider).watchSettings();
});

final financeSummaryProvider = StreamProvider.family<FinanceSummary, String>((
  ref,
  periodId,
) {
  return ref.watch(financeRepositoryProvider).watchSummary(periodId);
});

final financeBreakdownProvider =
    StreamProvider.family<List<FinanceCategoryBreakdown>, String>((
      ref,
      periodId,
    ) {
      return ref
          .watch(financeRepositoryProvider)
          .watchExpenseBreakdown(periodId);
    });

final recentFinanceTransactionsProvider =
    StreamProvider.family<List<FinanceTransactionRecord>, String>((
      ref,
      periodId,
    ) {
      return ref.watch(financeRepositoryProvider).watchRecent(periodId);
    });

final financeTransactionProvider =
    StreamProvider.family<FinanceTransactionRecord?, String>((ref, id) {
      return ref.watch(financeRepositoryProvider).watchTransaction(id);
    });

final allFinanceCategoriesProvider = StreamProvider<List<FinancialCategory>>((
  ref,
) {
  return ref
      .watch(financeRepositoryProvider)
      .watchCategories(activeOnly: false);
});
