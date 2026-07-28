import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/features/report_export/application/report_export_service.dart';
import 'package:keyspace/features/report_export/data/calorie_report_query.dart';
import 'package:keyspace/features/report_export/data/finance_report_query.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';

final reportExportServiceProvider = Provider<ReportExportService>((ref) {
  final db = ref.watch(databaseProvider);
  return ReportExportService(
    financeQuery: FinanceReportQuery(db),
    calorieQuery: CalorieReportQuery(db),
  );
});
