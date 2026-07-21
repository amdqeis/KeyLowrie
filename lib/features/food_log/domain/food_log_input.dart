class FoodItemInput {
  const FoodItemInput({
    required this.name,
    required this.caloriesKcal,
    this.quantity,
    this.unit,
    this.portionText,
    this.proteinG,
    this.carbsG,
    this.fatG,
    this.fiberG,
    this.sodiumMg,
    this.confidence,
    this.assumptionNote,
  });

  final String name;
  final double caloriesKcal;
  final double? quantity;
  final String? unit;
  final String? portionText;
  final double? proteinG;
  final double? carbsG;
  final double? fatG;
  final double? fiberG;
  final double? sodiumMg;
  final double? confidence;
  final String? assumptionNote;
}

class FoodLogInput {
  const FoodLogInput({
    required this.consumedAt,
    required this.mealType,
    required this.items,
    this.originalUserText,
    this.notes,
  });

  final DateTime consumedAt;
  final String mealType;
  final List<FoodItemInput> items;
  final String? originalUserText;
  final String? notes;
}

class FoodLogDetail {
  const FoodLogDetail({required this.log, required this.items});

  final dynamic log;
  final List<dynamic> items;
}
