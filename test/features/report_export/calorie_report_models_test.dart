import 'package:test/test.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';

void main() {
  group('CalorieReportData', () {
    DailyCalorieSummary _day({
      required DateTime date,
      required double calories,
      int? target,
      double? protein,
      double? carbs,
      double? fat,
    }) => DailyCalorieSummary(
      date: date,
      totalCalories: calories,
      targetCalories: target,
      proteinG: protein,
      carbsG: carbs,
      fatG: fat,
    );

    test('avgCalories hanya dihitung dari hari yang punya data', () {
      final data = CalorieReportData(
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 3),
        generatedAt: DateTime.utc(2025, 1, 4),
        dailySummaries: [
          _day(date: DateTime.utc(2025, 1, 1), calories: 2000),
          _day(date: DateTime.utc(2025, 1, 2), calories: 1500),
        ],
        foodItems: [],
        defaultTargetCalories: 2000,
        daysWithData: 2,
        daysWithoutData: 1, // 3 Jan tanpa data
      );

      // rata-rata = (2000 + 1500) / 2 = 1750, bukan / 3
      expect(data.avgCalories, closeTo(1750, 0.1));
    });

    test('avgCalories null jika tidak ada hari dengan data', () {
      final data = CalorieReportData(
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 3),
        generatedAt: DateTime.utc(2025, 1, 4),
        dailySummaries: [],
        foodItems: [],
        defaultTargetCalories: null,
        daysWithData: 0,
        daysWithoutData: 3,
      );

      expect(data.avgCalories, isNull);
    });

    test('avgProtein null jika semua nilai protein null', () {
      final data = CalorieReportData(
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 2),
        generatedAt: DateTime.utc(2025, 1, 3),
        dailySummaries: [
          _day(date: DateTime.utc(2025, 1, 1), calories: 1800),
          // protein null
        ],
        foodItems: [],
        defaultTargetCalories: null,
        daysWithData: 1,
        daysWithoutData: 1,
      );

      expect(data.avgProtein, isNull);
      expect(data.avgCarbs, isNull);
      expect(data.avgFat, isNull);
    });

    test('daysBelowTarget dihitung dengan benar', () {
      final data = CalorieReportData(
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 3),
        generatedAt: DateTime.utc(2025, 1, 4),
        dailySummaries: [
          _day(
            date: DateTime.utc(2025, 1, 1),
            calories: 1200,
            target: 2000,
          ), // bawah
          _day(
            date: DateTime.utc(2025, 1, 2),
            calories: 2000,
            target: 2000,
          ), // pas (within 50)
          _day(
            date: DateTime.utc(2025, 1, 3),
            calories: 2500,
            target: 2000,
          ), // atas
        ],
        foodItems: [],
        defaultTargetCalories: 2000,
        daysWithData: 3,
        daysWithoutData: 0,
      );

      expect(data.daysBelowTarget, 1);
      expect(data.daysAtTarget, 1);
      expect(data.daysAboveTarget, 1);
    });

    test('isEmpty true jika tidak ada catatan makanan', () {
      final data = CalorieReportData(
        rangeStart: DateTime.utc(2025, 1, 1),
        rangeEnd: DateTime.utc(2025, 1, 7),
        generatedAt: DateTime.utc(2025, 1, 8),
        dailySummaries: [],
        foodItems: [],
        defaultTargetCalories: null,
        daysWithData: 0,
        daysWithoutData: 7,
      );

      expect(data.isEmpty, isTrue);
    });
  });

  group('DailyCalorieSummary', () {
    test('difference null jika tidak ada target', () {
      final day = DailyCalorieSummary(
        date: DateTime.utc(2025, 1, 1),
        totalCalories: 1800,
        targetCalories: null,
      );

      expect(day.difference, isNull);
    });

    test('difference positif jika di atas target', () {
      final day = DailyCalorieSummary(
        date: DateTime.utc(2025, 1, 1),
        totalCalories: 2500,
        targetCalories: 2000,
      );

      expect(day.difference, 500);
    });

    test('difference negatif jika di bawah target', () {
      final day = DailyCalorieSummary(
        date: DateTime.utc(2025, 1, 1),
        totalCalories: 1500,
        targetCalories: 2000,
      );

      expect(day.difference, -500);
    });
  });
}
