# KeySpace

KeySpace adalah aplikasi Flutter pencatat nutrisi lokal, offline-first, dan chat-first. Tidak ada backend, akun, atau telemetry developer. Koneksi eksternal baseline hanya Gemini API menggunakan key milik pengguna.

## Fase saat ini

Fase 0: scaffold Android/iOS, schema Drift v1, secure-store abstraction, router placeholder, parser structured output, serta prototype Sticky Sequential Failover. UI dan fitur Internal MVP belum dibangun.

## Menjalankan validasi

```bash
flutter pub get
dart run build_runner build
dart format --output=none --set-exit-if-changed lib test tool
flutter analyze
flutter test
```

Runner live opsional dan menggunakan kuota pengguna:

```bash
dart run tool/gemini_poc.dart
```

API key diminta interaktif dengan input tersembunyi, tidak diterima melalui argument/environment, tidak disimpan, dan tidak pernah digunakan automated test.

Dokumen sumber kebenaran: `srs.md`, `prd.md`, `userflow.md`, dan `design.md`. Keputusan teknis dan open question tercatat di `ARCHITECTURE_NOTES.md`.
