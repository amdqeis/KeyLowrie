# Drift schema snapshots

Direktori ini menyimpan snapshot schema Drift untuk migration testing.

- `drift_schema_v1.json` adalah baseline 12 tabel sebelum ekspansi finance.
- `drift_schema_v2.json` menambah lima tabel finance/chat draft dan kolom disclosure voice secara additive.
- `drift_schema_v3.json` menambah scheduler, kategori, reminder, occurrence notification, dan pengaturan scheduler.
- `drift_schema_v4.json` menambah net worth, indeks analitik, dan tipe dual reminder secara additive.
- `test/database/migration_schema/` dihasilkan dari seluruh snapshot untuk memverifikasi migrasi v1/v2/v3 ke v4 dan integritas data lama.

Regenerasi setelah perubahan schema:

```bash
dart run drift_dev schema dump lib/database/app_database.dart drift_schemas/drift_schema_v4.json
dart run drift_dev schema generate --data-classes --companions drift_schemas test/database/migration_schema
```

Drift 2.34.0 menghasilkan getter `text` yang berkonflik dengan `Table.text()` untuk kolom SQL `chat_drafts.text`. Setelah regenerasi, getter tabel pada `schema_v2.dart`, `schema_v3.dart`, dan `schema_v4.dart` harus tetap dinamai `draftText` dan entri `$columns` harus memakai nama tersebut; nama kolom SQL dan data class tetap `text`.
