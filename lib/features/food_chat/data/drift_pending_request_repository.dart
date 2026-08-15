import 'package:drift/drift.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';

class DriftPendingRequestRepository implements PendingRequestRepository {
  const DriftPendingRequestRepository(this._database);

  final AppDatabase _database;

  @override
  Future<void> discardFailedAttempt(
    String requestId,
    GeminiFailureCategory category,
  ) {
    return _database.transaction(() async {
      final message = await (_database.select(
        _database.chatMessages,
      )..where((row) => row.id.equals(requestId))).getSingleOrNull();
      if (message == null) return;

      await (_database.delete(
        _database.chatMessages,
      )..where((row) => row.id.equals(requestId))).go();
      await _deleteSessionIfEmpty(message.sessionId);
    });
  }

  @override
  Future<void> purgeInterruptedAttempts() {
    return _database.transaction(() async {
      final interrupted =
          await (_database.select(_database.chatMessages)..where(
                (row) =>
                    row.role.equals('user') &
                    (row.status.equals('failed') |
                        row.status.equals('pending')),
              ))
              .get();
      if (interrupted.isEmpty) return;

      final sessionIds = interrupted
          .map((message) => message.sessionId)
          .toSet();
      await (_database.delete(_database.chatMessages)..where(
            (row) =>
                row.role.equals('user') &
                (row.status.equals('failed') | row.status.equals('pending')),
          ))
          .go();
      for (final sessionId in sessionIds) {
        await _deleteSessionIfEmpty(sessionId);
      }
    });
  }

  @override
  Future<void> markPreviewReady(String requestId, ParsedFoodDraft draft) {
    return _database.transaction(() async {
      final log =
          await (_database.select(_database.foodLogs)
                ..where((row) => row.localRequestId.equals(requestId)))
              .getSingleOrNull();
      final message = await (_database.select(
        _database.chatMessages,
      )..where((row) => row.id.equals(requestId))).getSingle();
      await (_database.update(
        _database.chatMessages,
      )..where((row) => row.id.equals(message.id))).write(
        ChatMessagesCompanion(
          status: const Value('complete'),
          errorCategory: const Value(null),
          foodLogId: Value(log?.id),
        ),
      );
      if (log != null) {
        await _database
            .into(_database.chatMessages)
            .insert(
              ChatMessagesCompanion.insert(
                id: 'assistant-$requestId',
                sessionId: message.sessionId,
                role: 'assistant',
                contentText:
                    '${draft.items.length} item terdeteksi, ${draft.totalCaloriesKcal.round()} kkal. Tinjau sebelum disimpan.',
                status: 'complete',
                foodLogId: Value(log.id),
                localRequestId: Value(requestId),
                createdAt: DateTime.now().toUtc(),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
  }

  @override
  Future<void> markUnifiedPreviewReady(
    String requestId,
    UnifiedChatDraft draft,
  ) {
    return _database.transaction(() async {
      final message = await (_database.select(
        _database.chatMessages,
      )..where((row) => row.id.equals(requestId))).getSingle();
      await (_database.update(
        _database.chatMessages,
      )..where((row) => row.id.equals(message.id))).write(
        const ChatMessagesCompanion(
          status: Value('complete'),
          errorCategory: Value(null),
        ),
      );
      final summary = draft.requiresClarification
          ? draft.clarificationQuestion ?? 'Input perlu diperjelas.'
          : switch (draft.detectedDomain) {
              ChatDomain.nutrition =>
                '${draft.nutrition?.items.length ?? 0} item nutrisi terdeteksi. Tinjau sebelum disimpan.',
              ChatDomain.expense =>
                '${draft.financialItems.length} pengeluaran terdeteksi. Tinjau sebelum disimpan.',
              ChatDomain.income =>
                '${draft.financialItems.length} pemasukan terdeteksi. Tinjau sebelum disimpan.',
              ChatDomain.schedule =>
                '${draft.schedules.length} jadwal terdeteksi. Tinjau sebelum disimpan.',
              ChatDomain.unknown => 'Jenis input belum dikenali.',
            };
      await _database
          .into(_database.chatMessages)
          .insert(
            ChatMessagesCompanion.insert(
              id: 'assistant-$requestId',
              sessionId: message.sessionId,
              role: 'assistant',
              contentText: summary,
              status: 'complete',
              localRequestId: Value(requestId),
              createdAt: DateTime.now().toUtc(),
            ),
            mode: InsertMode.insertOrReplace,
          );
    });
  }

  @override
  Future<void> savePending({
    required String requestId,
    required String input,
    required DateTime createdAt,
  }) async {
    final localDate = _localDate(createdAt.toLocal());
    final sessionId = 'session-$localDate';
    await _database.transaction(() async {
      await _database
          .into(_database.chatSessions)
          .insert(
            ChatSessionsCompanion.insert(
              id: sessionId,
              localDate: localDate,
              createdAt: createdAt,
              updatedAt: createdAt,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await _database
          .into(_database.chatMessages)
          .insert(
            ChatMessagesCompanion.insert(
              id: requestId,
              sessionId: sessionId,
              role: 'user',
              contentText: input,
              status: 'pending',
              localRequestId: Value(requestId),
              createdAt: createdAt,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await (_database.update(
        _database.chatMessages,
      )..where((message) => message.id.equals(requestId))).write(
        ChatMessagesCompanion(
          contentText: Value(input),
          status: const Value('pending'),
          errorCategory: const Value(null),
        ),
      );
    });
  }

  String _localDate(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  Future<void> _deleteSessionIfEmpty(String sessionId) async {
    final remaining =
        await (_database.select(_database.chatMessages)
              ..where((row) => row.sessionId.equals(sessionId))
              ..limit(1))
            .getSingleOrNull();
    if (remaining != null) return;
    await (_database.delete(
      _database.chatSessions,
    )..where((row) => row.id.equals(sessionId))).go();
  }
}
