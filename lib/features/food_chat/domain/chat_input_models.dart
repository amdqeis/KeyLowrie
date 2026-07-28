enum ChatInputMode { automatic, nutrition, expense, income }

enum ChatParseStatus { draft, parsing, needsReview, saved, failed }

enum InputSource { text, voiceDraft, manual }

extension ChatInputModeStorage on ChatInputMode {
  String get storageValue => name;

  static ChatInputMode parse(String value) => ChatInputMode.values.firstWhere(
    (mode) => mode.name == value,
    orElse: () => throw FormatException('chat_input_mode_invalid:$value'),
  );
}
