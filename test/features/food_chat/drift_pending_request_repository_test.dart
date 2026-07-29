import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/data/drift_pending_request_repository.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';

void main() {
  late AppDatabase database;
  late DriftPendingRequestRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftPendingRequestRepository(database);
  });

  tearDown(() => database.close());

  test(
    'retry updates user message when assistant has same request id',
    () async {
      const requestId = 'request-retry';
      final createdAt = DateTime.utc(2026, 7, 28);
      const draft = UnifiedChatDraft(
        detectedDomain: ChatDomain.unknown,
        confidence: 0.4,
        requiresClarification: true,
        clarificationQuestion: 'Catatan apa yang ingin dibuat?',
        financialItems: [],
      );

      await repository.savePending(
        requestId: requestId,
        input: 'catat sesuatu',
        createdAt: createdAt,
      );
      await repository.markUnifiedPreviewReady(requestId, draft);

      await repository.savePending(
        requestId: requestId,
        input: 'catat sesuatu besok',
        createdAt: createdAt,
      );
      await expectLater(
        repository.markUnifiedPreviewReady(requestId, draft),
        completes,
      );

      final messages = await (database.select(
        database.chatMessages,
      )..where((row) => row.localRequestId.equals(requestId))).get();
      expect(messages, hasLength(2));
      expect(
        messages.singleWhere((message) => message.role == 'user').status,
        'complete',
      );
    },
  );

  test('failure only changes the user message', () async {
    const requestId = 'request-failure';
    final createdAt = DateTime.utc(2026, 7, 28);
    const draft = UnifiedChatDraft(
      detectedDomain: ChatDomain.unknown,
      confidence: 0.4,
      requiresClarification: true,
      clarificationQuestion: 'Perlu diperjelas',
      financialItems: [],
    );

    await repository.savePending(
      requestId: requestId,
      input: 'ambigu',
      createdAt: createdAt,
    );
    await repository.markUnifiedPreviewReady(requestId, draft);
    await repository.markFailed(
      requestId,
      GeminiFailureCategory.schemaMismatch,
    );

    final messages = await (database.select(
      database.chatMessages,
    )..where((row) => row.localRequestId.equals(requestId))).get();
    expect(
      messages.singleWhere((message) => message.role == 'user').status,
      'failed',
    );
    expect(
      messages.singleWhere((message) => message.role == 'assistant').status,
      'complete',
    );
  });
}
