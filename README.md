# KeySpace

KeySpace adalah aplikasi Flutter pencatat nutrisi lokal, offline-first, dan chat-first. Tidak ada backend, akun, atau telemetry developer. Koneksi eksternal baseline hanya Gemini API menggunakan key milik pengguna.

## Fase saat ini

Ekspansi Voice Input dan Personal Finance telah menyelesaikan Gate Tahap 7. Aplikasi tetap offline-first dengan SQLite/Drift sebagai source of truth, Riverpod, `go_router`, secure storage untuk API key, dan Gemini key-pool/failover. Nutrisi lama tetap tersedia bersama composer terpadu dan tab keenam Keuangan.

## Fitur ekspansi

- Chat terpadu memiliki mode Otomatis, Kalori, Pengeluaran, dan Pemasukan. Teks serta mode draft disimpan lokal dan tidak hilang ketika request dibatalkan, respons invalid, jaringan gagal, atau seluruh API key gagal.
- Voice-to-text memakai recognizer OS. Partial/final transcript hanya mengubah draft yang dapat diedit; Gemini baru dipanggil setelah tombol Kirim ditekan.
- Review finance mendukung multiple item, edit seluruh field, konversi tipe, hapus item, reimbursement khusus expense, dan penyimpanan batch atomik.
- Tab Keuangan menyediakan dashboard reaktif, riwayat/filter/pencarian, detail edit/hapus, periode lama, cycle day 1–28, budget, dan kategori. Mata uang v1 dikunci ke IDR.

Formula finance:

- `budgetUsage = expense non-reimburse`
- `remainingBudget = budgetAmount - budgetUsage`
- `totalReimburse = expense dengan isReimburse=true`
- `netBalance = totalIncome - totalExpense`

Expense reimburse tetap masuk total expense dan saldo bersih, tetapi tidak mengurangi budget. Income tidak menambah budget.

## Menjalankan validasi

```bash
flutter pub get
dart run build_runner build
dart format --output=none --set-exit-if-changed lib test tool
flutter analyze
flutter test
```

Environment terproteksi dapat memakai SDK/cache writable:

```bash
CI=true FLUTTER_SUPPRESS_ANALYTICS=true DART_SUPPRESS_ANALYTICS=true \
PUB_CACHE=/tmp/keyspace-pub-cache \
/tmp/keyspace-flutter-sdk/bin/flutter --no-version-check analyze
```

Runner live opsional dan menggunakan kuota pengguna:

```bash
dart run tool/gemini_poc.dart
```

API key diminta interaktif dengan input tersembunyi, tidak diterima melalui argument/environment, tidak disimpan, dan tidak pernah digunakan automated test.

Dokumen sumber kebenaran: `srs.md`, `prd.md`, `userflow.md`, dan `design.md`. Keputusan teknis dan open question tercatat di `ARCHITECTURE_NOTES.md`.

## Status validasi terakhir

- `dart format .`: 93 file, tidak ada perubahan.
- Drift build runner selesai; dump schema v2 baru identik dengan snapshot dan helper migrasi dapat diregenerasi.
- `flutter analyze`: tidak ada issue.
- `flutter test`: 124 test lulus, seluruh Gemini automated test memakai fake/fixture lokal.
- `git diff --check`, audit pola credential, dan audit file sensitif: bersih.
- APK debug terbentuk dan lolos pemeriksaan integritas ZIP, tetapi wrapper Flutter tertahan saat finalisasi Gradle dan tidak menghasilkan completion message. Karena itu build Android belum diklaim lulus bersih.

Belum divalidasi pada perangkat fisik: voice recognizer/permission OS, secure storage platform, instalasi APK, lifecycle Android/iOS, kualitas transkripsi, dan live Gemini end-to-end.

## Checklist uji manual perangkat

1. Selesaikan onboarding dan tambahkan API key melalui secure storage UI.
2. Uji disclosure voice pertama, allow/deny/permanently-denied, Stop/Batal, partial/final transcript, edit draft, dan pastikan tidak ada auto-send.
3. Uji mode Otomatis/Kalori/Pengeluaran/Pemasukan, clarification, retry seluruh-key-gagal, serta Catat Manual.
4. Simpan multiple transaksi, konversi expense/income, reimbursement, edit tanggal lintas periode, dan rollback input invalid.
5. Verifikasi dashboard langsung berubah setelah create/edit/delete, over-budget state, filter/search, periode lama, cycle day bridge, budget, dan kategori nonaktif.
6. Restart aplikasi untuk memeriksa draft, database, settings, secure storage, reminder reconciliation, dan lifecycle background/foreground.
