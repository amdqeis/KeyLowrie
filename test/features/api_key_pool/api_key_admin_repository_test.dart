import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/core/security/secret_store.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/api_key_pool/data/api_key_admin_repository.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';

void main() {
  late AppDatabase database;
  late InMemorySecretStore secrets;
  late ApiKeyAdminRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    secrets = InMemorySecretStore();
    await SettingsRepository(database).initialize();
    repository = ApiKeyAdminRepository(database, secrets);
  });

  tearDown(() => database.close());

  test('tambah hanya menyimpan metadata masked dan secret terpisah', () async {
    final id = await repository.add(
      alias: 'Utama',
      secret: 'private-value-1234',
    );
    final row = (await repository.keys()).single;

    expect(row.id, id);
    expect(row.maskedSuffix, '••••••1234');
    expect(row.toJson().toString(), isNot(contains('private-value')));
    expect(await repository.readSecret(id), 'private-value-1234');
    expect((await SettingsRepository(database).getSettings()).activeKeyId, id);
  });

  test(
    'reorder aman terhadap unique priority dan disable mengganti active',
    () async {
      final first = await repository.add(alias: 'A', secret: 'secret-A');
      final second = await repository.add(alias: 'B', secret: 'secret-B');
      final third = await repository.add(alias: 'C', secret: 'secret-C');

      await repository.reorder([third, second, first]);
      expect((await repository.keys()).map((row) => row.id), [
        third,
        second,
        first,
      ]);
      await repository.setActive(third);
      await repository.setEnabled(third, false);
      expect(
        (await SettingsRepository(database).getSettings()).activeKeyId,
        second,
      );
    },
  );

  test('hapus membersihkan secure storage dan menormalkan priority', () async {
    final first = await repository.add(alias: 'A', secret: 'secret-A');
    await repository.add(alias: 'B', secret: 'secret-B');
    await repository.delete(first);

    expect(await secrets.read(first), isNull);
    expect((await repository.keys()).single.priorityOrder, 1);
  });
}
