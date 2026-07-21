import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/targets/domain/target_calculator.dart';

void main() {
  group('TargetCalculator', () {
    test('Mifflin-St Jeor memakai factor dan adjustment baseline', () {
      final estimate = TargetCalculator.mifflinStJeor(
        weightKg: 70,
        heightCm: 175,
        age: 30,
        sex: FormulaSex.male,
        activity: ActivityLevel.moderate,
        goal: CalorieGoal.deficit,
      );

      expect(estimate.bmr, 1648.75);
      expect(estimate.activityFactor, 1.55);
      expect(estimate.adjustmentKcal, -300);
      expect(estimate.suggestedTargetKcal, 2256);
    });

    test('konversi unit pulang-pergi tetap konsisten', () {
      expect(kilogramsToPounds(poundsToKilograms(150)), closeTo(150, 0.0001));
      expect(centimetersToInches(inchesToCentimeters(70)), closeTo(70, 0.0001));
    });

    test('nilai formula tidak valid ditolak', () {
      expect(
        () => TargetCalculator.mifflinStJeor(
          weightKg: 0,
          heightCm: 170,
          age: 30,
          sex: FormulaSex.female,
          activity: ActivityLevel.light,
          goal: CalorieGoal.maintenance,
        ),
        throwsFormatException,
      );
    });
  });
}
