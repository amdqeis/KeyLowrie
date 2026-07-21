import 'dart:math' as math;

enum FormulaSex { male, female }

enum ActivityLevel { sedentary, light, moderate, veryActive, extraActive }

enum CalorieGoal { deficit, maintenance, surplus }

class TargetEstimate {
  const TargetEstimate({
    required this.bmr,
    required this.activityFactor,
    required this.tdee,
    required this.adjustmentKcal,
    required this.suggestedTargetKcal,
  });

  final double bmr;
  final double activityFactor;
  final double tdee;
  final int adjustmentKcal;
  final int suggestedTargetKcal;
}

abstract final class TargetCalculator {
  static TargetEstimate mifflinStJeor({
    required double weightKg,
    required double heightCm,
    required int age,
    required FormulaSex sex,
    required ActivityLevel activity,
    required CalorieGoal goal,
  }) {
    if (!weightKg.isFinite || weightKg <= 0) {
      throw const FormatException('weight_invalid');
    }
    if (!heightCm.isFinite || heightCm <= 0) {
      throw const FormatException('height_invalid');
    }
    if (age <= 0 || age > 150) throw const FormatException('age_invalid');
    final sexOffset = sex == FormulaSex.male ? 5 : -161;
    final bmr = 10 * weightKg + 6.25 * heightCm - 5 * age + sexOffset;
    final factor = switch (activity) {
      ActivityLevel.sedentary => 1.2,
      ActivityLevel.light => 1.375,
      ActivityLevel.moderate => 1.55,
      ActivityLevel.veryActive => 1.725,
      ActivityLevel.extraActive => 1.9,
    };
    final adjustment = switch (goal) {
      CalorieGoal.deficit => -300,
      CalorieGoal.maintenance => 0,
      CalorieGoal.surplus => 300,
    };
    final tdee = bmr * factor;
    return TargetEstimate(
      bmr: bmr,
      activityFactor: factor,
      tdee: tdee,
      adjustmentKcal: adjustment,
      suggestedTargetKcal: math.max(1, (tdee + adjustment).round()),
    );
  }
}

double poundsToKilograms(double value) => value * 0.45359237;
double kilogramsToPounds(double value) => value / 0.45359237;
double inchesToCentimeters(double value) => value * 2.54;
double centimetersToInches(double value) => value / 2.54;
