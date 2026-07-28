import 'package:drift/drift.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:uuid/uuid.dart';

class ChatDraftRepository {
  ChatDraftRepository(
    this.database, {
    Uuid uuid = const Uuid(),
    DateTime Function()? now,
  }) : _uuid = uuid,
       _now = now ?? DateTime.now;

  final AppDatabase database;
  final Uuid _uuid;
  final DateTime Function() _now;

  Stream<List<ChatDraft>> watchDrafts() {
    return (database.select(
      database.chatDrafts,
    )..orderBy([(row) => OrderingTerm.desc(row.updatedAt)])).watch();
  }

  Future<ChatDraft?> latest() {
    return (database.select(database.chatDrafts)
          ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<String> save({
    String? id,
    required String text,
    required ChatInputMode selectedMode,
  }) async {
    final cleaned = text.trim();
    if (cleaned.isEmpty) throw const FormatException('chat_draft_empty');
    final now = _now().toUtc();
    final draftId = id ?? _uuid.v4();
    final existing = await (database.select(
      database.chatDrafts,
    )..where((row) => row.id.equals(draftId))).getSingleOrNull();
    if (existing == null) {
      await database
          .into(database.chatDrafts)
          .insert(
            ChatDraftsCompanion.insert(
              id: draftId,
              draftText: cleaned,
              selectedMode: selectedMode.storageValue,
              createdAt: now,
              updatedAt: now,
            ),
          );
    } else {
      await (database.update(
        database.chatDrafts,
      )..where((row) => row.id.equals(draftId))).write(
        ChatDraftsCompanion(
          draftText: Value(cleaned),
          selectedMode: Value(selectedMode.storageValue),
          updatedAt: Value(now),
        ),
      );
    }
    return draftId;
  }

  Future<void> delete(String id) {
    return (database.delete(
      database.chatDrafts,
    )..where((row) => row.id.equals(id))).go();
  }
}
