import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/data/chat_draft_repository.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';

void main() {
  late AppDatabase database;
  late ChatDraftRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = ChatDraftRepository(
      database,
      now: () => DateTime.utc(2026, 7, 22, 12),
    );
  });

  tearDown(() => database.close());

  test('persists text and selected mode without sending anything', () async {
    final id = await repository.save(
      text: 'Beli bensin 150 ribu',
      selectedMode: ChatInputMode.expense,
    );

    final draft = await repository.latest();
    expect(draft!.id, id);
    expect(draft.draftText, 'Beli bensin 150 ribu');
    expect(draft.selectedMode, 'expense');
  });

  test('updates an existing draft while preserving its identity', () async {
    final id = await repository.save(
      text: 'Draft awal',
      selectedMode: ChatInputMode.automatic,
    );
    await repository.save(
      id: id,
      text: 'Draft yang diedit',
      selectedMode: ChatInputMode.income,
    );

    final drafts = await repository.watchDrafts().first;
    expect(drafts, hasLength(1));
    expect(drafts.single.draftText, 'Draft yang diedit');
    expect(drafts.single.selectedMode, 'income');
  });
}
