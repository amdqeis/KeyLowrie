# Drift schema snapshots

Direktori ini menyimpan snapshot schema Drift untuk migration testing.

- `drift_schema_v1.json` adalah baseline 12 tabel sebelum ekspansi finance.
- `drift_schema_v2.json` menambah lima tabel finance/chat draft dan kolom disclosure voice secara additive.
- `test/database/migration_schema/` dihasilkan dari kedua snapshot untuk memverifikasi migrasi v1 ke v2 dan integritas data lama.

Regenerasi setelah perubahan schema:

```bash
dart run drift_dev schema dump lib/database/app_database.dart drift_schemas/drift_schema_v2.json
dart run drift_dev schema generate --data-classes --companions drift_schemas test/database/migration_schema
```

Drift 2.34.0 menghasilkan getter `text` yang berkonflik dengan `Table.text()` untuk kolom SQL `chat_drafts.text`. Setelah regenerasi, getter tabel pada `schema_v2.dart` harus tetap dinamai `draftText` dan entri `$columns` harus memakai nama tersebut; nama kolom SQL dan data class tetap `text`.
