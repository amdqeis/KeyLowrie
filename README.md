# KeySpace

KeySpace adalah aplikasi Flutter pencatat nutrisi lokal, offline-first, dan chat-first. Tidak ada backend, akun, atau telemetry developer. Koneksi eksternal baseline hanya Gemini API menggunakan key milik pengguna.

## Fase saat ini

Smart Scheduler telah ditambahkan di atas ekspansi Voice Input dan Personal Finance. Aplikasi tetap offline-first dengan SQLite/Drift sebagai source of truth, Riverpod, `go_router`, secure storage untuk API key, dan Gemini key-pool/failover.

## Fitur ekspansi

- Chat terpadu memiliki mode Otomatis, Kalori, Pengeluaran, dan Pemasukan. Teks serta mode draft disimpan lokal dan tidak hilang ketika request dibatalkan, respons invalid, jaringan gagal, atau seluruh API key gagal.
- Voice-to-text memakai recognizer OS. Partial/final transcript hanya mengubah draft yang dapat diedit; Gemini baru dipanggil setelah tombol Kirim ditekan.
- Review finance mendukung multiple item, edit seluruh field, konversi tipe, hapus item, reimbursement khusus expense, dan penyimpanan batch atomik.
- Tab Keuangan menyediakan dashboard reaktif, riwayat/filter/pencarian, detail edit/hapus, periode lama, cycle day 1–28, budget, dan kategori. Mata uang v1 dikunci ke IDR.
- Tab Jadwal menggantikan placeholder Insight dan menyediakan hourly, daily, weekly, task list, detail, serta editor manual.
- Chat memiliki mode Jadwal dan mode Otomatis dapat menerima structured schedule dari Gemini. Hasil selalu menjadi review draft sebelum disimpan.
- Event/task, kategori, recurrence daily/weekly/monthly, conflict warning, dan reminder disimpan lokal pada Drift schema v3.
- Reminder scheduler memakai occurrence virtual dengan rolling horizon 30 hari, reconciliation saat bootstrap, snooze 10 menit, complete task, serta deep-link edit.

Kontrak waktu scheduler:

- Event berwaktu disimpan sebagai UTC bersama IANA timezone asal.
- All-day event dan due date tanpa jam mempertahankan tanggal lokal.
- Recurrence memakai weekday ISO 1–7 dan edit/hapus berlaku untuk seluruh series.
- Registrasi notification OS bukan bagian dari transaksi SQLite; database menjadi source of truth dan status gagal akan direkonsiliasi.

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

- `dart format --output=none --set-exit-if-changed .`: 115 file, tidak ada perubahan.
- Drift build runner selesai; snapshot schema v3 dan helper migration v1/v2/v3 berhasil diregenerasi.
- `flutter analyze`: tidak ada issue.
- `flutter test --concurrency=1`: 148 test lulus, seluruh Gemini automated test memakai fake/fixture lokal.
- `git diff --check`, audit pola credential, dan audit file sensitif: bersih.
- Build APK tidak dijalankan pada ekspansi scheduler ini. Artifact lama tidak dipakai sebagai bukti build atau kesiapan release.

Belum divalidasi pada perangkat fisik: notification app-closed/reboot/action, fallback exact/inexact Android, batas pending iOS, perubahan timezone, voice recognizer/permission OS, secure storage, instalasi APK, lifecycle Android/iOS, dan live Gemini end-to-end.

## Checklist uji manual perangkat

1. Selesaikan onboarding dan tambahkan API key melalui secure storage UI.
2. Uji disclosure voice pertama, allow/deny/permanently-denied, Stop/Batal, partial/final transcript, edit draft, dan pastikan tidak ada auto-send.
3. Uji mode Otomatis/Kalori/Pengeluaran/Pemasukan, clarification, retry seluruh-key-gagal, serta Catat Manual.
4. Simpan multiple transaksi, konversi expense/income, reimbursement, edit tanggal lintas periode, dan rollback input invalid.
5. Verifikasi dashboard langsung berubah setelah create/edit/delete, over-budget state, filter/search, periode lama, cycle day bridge, budget, dan kategori nonaktif.
6. Buat event/task manual dan melalui chat, periksa warning bentrok, recurrence, completion, edit seluruh series, dan hapus.
7. Uji reminder 15 menit/1 jam, app ditutup, snooze, complete, reschedule, reboot Android, perubahan timezone, dan fallback inexact.
8. Restart aplikasi untuk memeriksa draft, database, settings, secure storage, reminder reconciliation, dan lifecycle background/foreground.
