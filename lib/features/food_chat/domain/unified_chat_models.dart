import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';

enum ChatDomain { nutrition, expense, income, schedule, unknown }

class GeminiCategoryContext {
  const GeminiCategoryContext({
    required this.id,
    required this.name,
    required this.type,
  });

  final String id;
  final String name;
  final ChatDomain type;
}

class ChatParseContext {
  const ChatParseContext({
    required this.mode,
    required this.localDate,
    required this.timezone,
    required this.currencyCode,
    required this.activeCategories,
    this.scheduleCategories = const [],
    this.currentDateTime,
    this.weekStartsOn = 'monday',
    this.defaultEventDurationMinutes = 60,
  });

  final ChatInputMode mode;
  final DateTime localDate;
  final String timezone;
  final String currencyCode;
  final List<GeminiCategoryContext> activeCategories;
  final List<String> scheduleCategories;
  final DateTime? currentDateTime;
  final String weekStartsOn;
  final int defaultEventDurationMinutes;
}

class ParsedFinancialItem {
  const ParsedFinancialItem({
    required this.name,
    required this.amount,
    required this.currencyCode,
    required this.transactionDate,
    required this.categoryId,
    required this.categoryName,
  });

  final String name;
  final int amount;
  final String currencyCode;
  final DateTime transactionDate;
  final String categoryId;
  final String categoryName;
}

class UnifiedChatDraft {
  const UnifiedChatDraft({
    required this.detectedDomain,
    required this.confidence,
    required this.requiresClarification,
    required this.financialItems,
    this.clarificationQuestion,
    this.nutrition,
    this.schedule,
  });

  final ChatDomain detectedDomain;
  final double confidence;
  final bool requiresClarification;
  final String? clarificationQuestion;
  final List<ParsedFinancialItem> financialItems;
  final ParsedFoodDraft? nutrition;
  final ScheduleDraft? schedule;
}

sealed class ParseChatResult {
  const ParseChatResult({required this.inputPreserved, this.requestId});

  final bool inputPreserved;
  final String? requestId;
}

class ParseChatSuccess extends ParseChatResult {
  const ParseChatSuccess({
    required this.draft,
    required this.keyId,
    super.requestId,
  }) : super(inputPreserved: true);

  final UnifiedChatDraft draft;
  final String keyId;
}

class ParseChatOffline extends ParseChatResult {
  const ParseChatOffline({super.requestId}) : super(inputPreserved: true);
}

/// Membedakan jenis kegagalan parsing:
/// - [ambiguousInput]: Input tidak dikenali atau kurang informasi (masalah dari pengguna)
/// - [technicalError]: Error API key, jaringan, kuota, schema tidak cocok (masalah teknis)
enum ParseChatFailureKind { ambiguousInput, technicalError }

class ParseChatRequestFailure extends ParseChatResult {
  const ParseChatRequestFailure(
    this.category, {
    super.requestId,
    this.kind = ParseChatFailureKind.technicalError,
    this.detail,
  }) : super(inputPreserved: true);

  final GeminiFailureCategory category;

  /// Klasifikasi jenis kegagalan untuk ditampilkan di UI.
  final ParseChatFailureKind kind;

  /// Detail teknis (opsional) untuk log/debug — jangan tampilkan mentah ke pengguna.
  final String? detail;
}

class ParseChatContentNeedsRevision extends ParseChatResult {
  const ParseChatContentNeedsRevision({super.requestId})
    : super(inputPreserved: true);
}

class ParseChatCancelled extends ParseChatResult {
  const ParseChatCancelled({super.requestId}) : super(inputPreserved: true);
}

class ParseChatAllKeysFailed extends ParseChatResult {
  const ParseChatAllKeysFailed({required this.attemptedKeys, super.requestId})
    : super(inputPreserved: true);

  final List<String> attemptedKeys;
}
