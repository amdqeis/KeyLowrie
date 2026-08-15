import 'package:drift/drift.dart' show Value;
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

  test('failure deletes only the correlated user message', () async {
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
    await repository.discardFailedAttempt(
      requestId,
      GeminiFailureCategory.schemaMismatch,
    );

    final messages = await (database.select(
      database.chatMessages,
    )..where((row) => row.localRequestId.equals(requestId))).get();
    expect(messages, hasLength(1));
    expect(messages.single.role, 'assistant');
    expect(messages.single.status, 'complete');
    expect(await database.select(database.chatSessions).get(), hasLength(1));
  });

  test('failure deletes an empty chat session', () async {
    const requestId = 'request-only-message';

    await repository.savePending(
      requestId: requestId,
      input: 'akan gagal',
      createdAt: DateTime.utc(2026, 7, 28),
    );
    await repository.discardFailedAttempt(
      requestId,
      GeminiFailureCategory.offline,
    );

    expect(await database.select(database.chatMessages).get(), isEmpty);
    expect(await database.select(database.chatSessions).get(), isEmpty);
  });

  test(
    'startup purge removes interrupted rows but preserves completed data',
    () async {
      final now = DateTime.utc(2026, 7, 28);
      const completedDraft = UnifiedChatDraft(
        detectedDomain: ChatDomain.unknown,
        confidence: 0.4,
        requiresClarification: true,
        clarificationQuestion: 'Perlu diperjelas',
        financialItems: [],
      );
      await repository.savePending(
        requestId: 'request-complete',
        input: 'selesai',
        createdAt: now,
      );
      await repository.markUnifiedPreviewReady(
        'request-complete',
        completedDraft,
      );
      await repository.savePending(
        requestId: 'request-failed',
        input: 'gagal lama',
        createdAt: now,
      );
      await (database.update(database.chatMessages)
            ..where((row) => row.id.equals('request-failed')))
          .write(const ChatMessagesCompanion(status: Value('failed')));
      await repository.savePending(
        requestId: 'request-pending',
        input: 'pending lama',
        createdAt: now.add(const Duration(days: 1)),
      );
      await database
          .into(database.chatDrafts)
          .insert(
            ChatDraftsCompanion.insert(
              id: 'draft-preserved',
              draftText: 'input tetap aman',
              selectedMode: 'automatic',
              createdAt: now,
              updatedAt: now,
            ),
          );

      await repository.purgeInterruptedAttempts();

      final messages = await database.select(database.chatMessages).get();
      expect(messages.map((message) => message.localRequestId).toSet(), {
        'request-complete',
      });
      expect(await database.select(database.chatSessions).get(), hasLength(1));
      expect(await database.select(database.chatDrafts).get(), hasLength(1));
    },
  );
}
