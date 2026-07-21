import 'dart:math' as math;

import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';

class FoodResponseException implements Exception {
  const FoodResponseException(this.reason);

  final String reason;

  @override
  String toString() => 'FoodResponseException($reason)';
}

class FoodResponseParser {
  const FoodResponseParser();

  ParsedFoodDraft parse(Map<String, dynamic> json) {
    final rawItems = json['items'];
    if (rawItems is! List || rawItems.isEmpty) {
      throw const FoodResponseException('items_invalid');
    }
    final items = rawItems.map(_parseItem).toList(growable: false);
    final localCalories = items.fold<double>(
      0,
      (total, item) => total + item.caloriesKcal,
    );
    final summary = json['summary'];
    if (summary is! Map<String, dynamic>) {
      throw const FoodResponseException('summary_invalid');
    }
    final providerCalories = _requiredNumber(
      summary['total_calories_kcal'],
      'summary.total_calories_kcal',
    );
    final protein = _sumNullable(items.map((item) => item.proteinG));
    final carbs = _sumNullable(items.map((item) => item.carbsG));
    final fat = _sumNullable(items.map((item) => item.fatG));
    final providerReview = summary['needs_user_review'];
    final extreme =
        localCalories > 10000 || items.any((item) => item.caloriesKcal > 5000);
    return ParsedFoodDraft(
      items: items,
      totalCaloriesKcal: localCalories,
      totalProteinG: protein,
      totalCarbsG: carbs,
      totalFatG: fat,
      needsUserReview: providerReview is bool
          ? providerReview || extreme
          : true,
      providerTotalDifferenceKcal: providerCalories - localCalories,
      generalNote: _optionalText(summary['general_note']),
    );
  }

  ParsedFoodItem _parseItem(Object? value) {
    if (value is! Map<String, dynamic>) {
      throw const FoodResponseException('item_not_object');
    }
    final name = _requiredText(value['name'], 'item.name');
    final confidence = _optionalNumber(value['confidence'], 'item.confidence');
    if (confidence != null && (confidence < 0 || confidence > 1)) {
      throw const FoodResponseException('confidence_out_of_range');
    }
    return ParsedFoodItem(
      name: name,
      caloriesKcal: _requiredNumber(
        value['calories_kcal'],
        'item.calories_kcal',
      ),
      quantity: _optionalNumber(value['quantity'], 'item.quantity'),
      unit: _optionalText(value['unit']),
      portionText: _optionalText(value['portion_text']),
      proteinG: _optionalNumber(value['protein_g'], 'item.protein_g'),
      carbsG: _optionalNumber(value['carbs_g'], 'item.carbs_g'),
      fatG: _optionalNumber(value['fat_g'], 'item.fat_g'),
      fiberG: _optionalNumber(value['fiber_g'], 'item.fiber_g'),
      sodiumMg: _optionalNumber(value['sodium_mg'], 'item.sodium_mg'),
      confidence: confidence,
      assumptionNote: _optionalText(value['assumption_note']),
    );
  }

  String _requiredText(Object? value, String field) {
    final sanitized = _optionalText(value);
    if (sanitized == null || sanitized.isEmpty) {
      throw FoodResponseException('${field}_invalid');
    }
    return sanitized;
  }

  String? _optionalText(Object? value) {
    if (value == null) return null;
    if (value is! String) {
      throw const FoodResponseException('text_invalid');
    }
    final sanitized = value
        .replaceAll(RegExp(r'[\u0000-\u0008\u000B\u000C\u000E-\u001F]'), '')
        .trim();
    if (sanitized.isEmpty) return null;
    return sanitized.substring(0, math.min(sanitized.length, 500));
  }

  double _requiredNumber(Object? value, String field) {
    final number = _optionalNumber(value, field);
    if (number == null) throw FoodResponseException('${field}_missing');
    return number;
  }

  double? _optionalNumber(Object? value, String field) {
    if (value == null) return null;
    if (value is! num) throw FoodResponseException('${field}_invalid');
    final number = value.toDouble();
    if (!number.isFinite || number < 0) {
      throw FoodResponseException('${field}_invalid');
    }
    return number;
  }

  double? _sumNullable(Iterable<double?> values) {
    var found = false;
    var total = 0.0;
    for (final value in values) {
      if (value != null) {
        found = true;
        total += value;
      }
    }
    return found ? total : null;
  }
}
