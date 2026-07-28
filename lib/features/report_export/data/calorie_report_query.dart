import 'package:drift/drift.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/report_export/domain/report_date_range.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';

/// Query database untuk laporan kalori berdasarkan rentang tanggal.
/// Tidak memanggil Gemini atau network.
/// Menggunakan nilai hasil koreksi pengguna dari database — tidak direkayasa.
class CalorieReportQuery {
  const CalorieReportQuery(this._db);

  final AppDatabase _db;

  Future<CalorieReportData> fetch(ReportDateRange range) async {
    // Ambil target kalori paling umum / berlaku di akhir rentang
    final defaultTarget = await _fetchDefaultTarget(range);

    // Food logs confirmed dalam rentang berdasarkan local_date
    final logs = await _fetchLogs(range);

    // Food items untuk semua log yang ditemukan
    final logIds = logs.map((l) => l.id).toList();
    final allItems = logIds.isEmpty ? <FoodItem>[] : await _fetchItems(logIds);

    // Bangun peta logId -> items
    final itemsByLog = <String, List<FoodItem>>{};
    for (final item in allItems) {
      itemsByLog.putIfAbsent(item.foodLogId, () => []).add(item);
    }

    // Kelompokkan logs by local_date
    final logsByDate = <String, List<FoodLog>>{};
    for (final log in logs) {
      logsByDate.putIfAbsent(log.localDate, () => []).add(log);
    }

    // Iterasi setiap hari dalam rentang (inklusif)
    final dailySummaries = <DailyCalorieSummary>[];
    final foodItems = <FoodItemReportRow>[];
    int daysWithData = 0;
    int daysWithoutData = 0;

    DateTime current = range.start;
    while (!current.isAfter(range.end)) {
      final key = localDateKey(current);
      final dayLogs = logsByDate[key] ?? [];

      if (dayLogs.isEmpty) {
        daysWithoutData++;
      } else {
        daysWithData++;
        double totalCal = 0;
        double? protein;
        double? carbs;
        double? fat;

        for (final log in dayLogs) {
          totalCal += log.totalCaloriesKcal;
          if (log.totalProteinG != null) {
            protein = (protein ?? 0) + log.totalProteinG!;
          }
          if (log.totalCarbsG != null) {
            carbs = (carbs ?? 0) + log.totalCarbsG!;
          }
          if (log.totalFatG != null) {
            fat = (fat ?? 0) + log.totalFatG!;
          }

          // Food items
          final items = itemsByLog[log.id] ?? [];
          for (final item in items) {
            foodItems.add(
              FoodItemReportRow(
                date: log.consumedAtUtc.toLocal(),
                foodName: item.displayName,
                portionText: item.portionText ?? _defaultPortion(item),
                caloriesKcal: item.caloriesKcal,
                proteinG: item.proteinG,
                carbsG: item.carbsG,
                fatG: item.fatG,
              ),
            );
          }
        }

        // Target efektif untuk tanggal ini
        final target = await _fetchTargetForDate(key);

        dailySummaries.add(
          DailyCalorieSummary(
            date: current,
            totalCalories: totalCal,
            targetCalories:
                target?.calorieTarget ?? defaultTarget?.calorieTarget,
            proteinG: protein,
            carbsG: carbs,
            fatG: fat,
          ),
        );
      }

      current = current.add(const Duration(days: 1));
    }

    // Sort food items by date ascending
    foodItems.sort((a, b) => a.date.compareTo(b.date));

    return CalorieReportData(
      rangeStart: range.start,
      rangeEnd: range.end,
      generatedAt: DateTime.now(),
      dailySummaries: dailySummaries,
      foodItems: foodItems,
      defaultTargetCalories: defaultTarget?.calorieTarget,
      daysWithData: daysWithData,
      daysWithoutData: daysWithoutData,
    );
  }

  Future<List<FoodLog>> _fetchLogs(ReportDateRange range) {
    return (_db.select(_db.foodLogs)
          ..where(
            (row) =>
                row.localDate.isBiggerOrEqualValue(range.startKey) &
                row.localDate.isSmallerOrEqualValue(range.endKey) &
                row.status.equals('confirmed') &
                row.deletedAt.isNull(),
          )
          ..orderBy([
            (row) => OrderingTerm.asc(row.localDate),
            (row) => OrderingTerm.asc(row.consumedAtUtc),
          ]))
        .get();
  }

  Future<List<FoodItem>> _fetchItems(List<String> logIds) {
    return (_db.select(_db.foodItems)
          ..where((row) => row.foodLogId.isIn(logIds))
          ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
        .get();
  }

  Future<DailyTarget?> _fetchDefaultTarget(ReportDateRange range) {
    // Ambil target yang berlaku di akhir rentang
    return (_db.select(_db.dailyTargets)
          ..where(
            (row) => row.effectiveFromDate.isSmallerOrEqualValue(range.endKey),
          )
          ..orderBy([
            (row) => OrderingTerm.desc(row.effectiveFromDate),
            (row) => OrderingTerm.desc(row.createdAt),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<DailyTarget?> _fetchTargetForDate(String dateKey) {
    return (_db.select(_db.dailyTargets)
          ..where((row) => row.effectiveFromDate.isSmallerOrEqualValue(dateKey))
          ..orderBy([
            (row) => OrderingTerm.desc(row.effectiveFromDate),
            (row) => OrderingTerm.desc(row.createdAt),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  String _defaultPortion(FoodItem item) {
    if (item.quantity != null && item.unit != null) {
      return '${item.quantity} ${item.unit}';
    }
    if (item.quantity != null) return '${item.quantity}';
    return '-';
  }
}
