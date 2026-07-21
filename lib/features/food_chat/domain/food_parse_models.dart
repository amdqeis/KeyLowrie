import 'package:keyspace/core/errors/gemini_failure.dart';

class ParsedFoodItem {
  const ParsedFoodItem({
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

class ParsedFoodDraft {
  const ParsedFoodDraft({
    required this.items,
    required this.totalCaloriesKcal,
    required this.needsUserReview,
    required this.providerTotalDifferenceKcal,
    this.totalProteinG,
    this.totalCarbsG,
    this.totalFatG,
    this.generalNote,
  });

  final List<ParsedFoodItem> items;
  final double totalCaloriesKcal;
  final double? totalProteinG;
  final double? totalCarbsG;
  final double? totalFatG;
  final bool needsUserReview;
  final double providerTotalDifferenceKcal;
  final String? generalNote;
}

sealed class ParseFoodResult {
  const ParseFoodResult({required this.inputPreserved, this.requestId});

  final bool inputPreserved;
  final String? requestId;
}

class ParseFoodSuccess extends ParseFoodResult {
  const ParseFoodSuccess({
    required this.draft,
    required this.keyId,
    super.requestId,
  }) : super(inputPreserved: true);

  final ParsedFoodDraft draft;
  final String keyId;
}

class OfflineFailure extends ParseFoodResult {
  const OfflineFailure({super.requestId}) : super(inputPreserved: true);
}

class RequestFailure extends ParseFoodResult {
  const RequestFailure(this.category, {super.requestId})
    : super(inputPreserved: true);

  final GeminiFailureCategory category;
}

class ContentNeedsRevision extends ParseFoodResult {
  const ContentNeedsRevision({super.requestId}) : super(inputPreserved: true);
}

class CancelledFailure extends ParseFoodResult {
  const CancelledFailure({super.requestId}) : super(inputPreserved: true);
}

enum AllKeysFailedAction { addKey, manageKeys, retry, manualEntry }

class AllKeysFailed extends ParseFoodResult {
  const AllKeysFailed({required this.attemptedKeys, super.requestId})
    : actions = const [
        AllKeysFailedAction.addKey,
        AllKeysFailedAction.manageKeys,
        AllKeysFailedAction.retry,
        AllKeysFailedAction.manualEntry,
      ],
      super(inputPreserved: true);

  final List<String> attemptedKeys;
  final List<AllKeysFailedAction> actions;
}
