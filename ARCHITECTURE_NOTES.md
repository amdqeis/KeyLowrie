# Architecture Notes — KeySpace

## Status

Fase 0 membangun fondasi dan validasi teknis saja. Fitur bisnis dan UI Internal MVP belum diimplementasikan.

## Toolchain dan package lock

- Flutter 3.44.6 stable, Dart 3.12.2.
- Android minimum API 24, iOS minimum 13.0.
- Application/bundle ID: `com.keyspace.app`.
- Dependency produksi utama: Riverpod 3.3.2, Drift 2.34.0, Dio 5.10.0, go_router 17.3.0, flutter_secure_storage 10.3.1, sqlite3 3.5.0.
- Codegen: drift_dev 2.34.0 dan build_runner yang diselesaikan lockfile. Drift/drift_dev 2.34.0 dipin karena rilis 2.34.1+ membutuhkan analyzer yang bertentangan dengan `meta`, `matcher`, dan `test_api` yang dipin Flutter 3.44.6.
- `sqlite3_flutter_libs` tidak dipakai. Drift native + sqlite3 3.x membundel SQLite melalui native assets.
- `fl_chart` 1.2.0 dipilih untuk Fase Insight, tetapi belum ditambahkan agar tidak menjadi dependency mati.

## Arsitektur Fase 0

- UI menggunakan Riverpod sebagai dependency injection dan go_router dengan lima branch tab persisten.
- Drift/SQLite adalah source of truth lokal. Schema v1 memiliki tepat 12 entity dari SRS §5, foreign key aktif, transaksi, index agregasi, cascade untuk child-owned rows, dan `SET NULL` untuk referensi audit.
- Secret disimpan melalui abstraction `SecretStore`. SQLite hanya mengetahui `secure_ref` dan suffix masked; namespace platform storage adalah `keyspace.api_key.`.
- `GeminiFailoverService` bergantung pada kontrak client, key repository, pending-request repository, network status, clock, delay, jitter, parser, dan ID factory. UI tidak mengelola rotasi key.
- Dio tidak memasang request/response logger. API key dikirim melalui header resmi `x-goog-api-key`, bukan URL, log, atau diagnostics.
- Provider config terpusat memakai model prototipe `gemini-2.5-flash`, API `v1beta`, connect timeout 10 detik, receive timeout 30 detik, satu retry transient, backoff 500 ms + jitter 0–250 ms, fallback cooldown rate-limit 60 detik, dan transient cooldown 15 detik.
- Parser menghitung ulang total dari item, menyimpan hanya domain draft, dan tidak menyimpan raw provider response.

## Threat model ringkas

- Ancaman utama: secret masuk SQLite/log/export, raw provider error membocorkan detail, retry tak terbatas, broken access pada perangkat terkompromi, dan kehilangan input saat jaringan/provider gagal.
- Mitigasi Fase 0: storage terpisah, taxonomy error tersanitasi, tidak ada LogInterceptor, satu bounded cycle, dependency waktu/jaringan dapat dites, pending input disimpan sebelum network, serta fake client untuk seluruh automated test.
- Secure storage melindungi data at rest tetapi tidak menjamin perangkat yang sudah di-root/jailbreak atau proses yang telah dikompromi.

## Konflik dan keputusan

1. FR-14 menyebut catatan non-sensitif pada API key, tetapi schema SRS §5.2.8 tidak menyediakan kolom catatan. Sesuai precedence dan instruksi schema exact, kolom tidak ditambahkan.
2. PRD Fase 0 meminta proof-of-concept Gemini live, sedangkan automated test dilarang memakai API sungguhan. Keputusan: corpus fixture wajib dan runner live manual bersifat opt-in, interaktif, tanpa penyimpanan key.
3. Schema menyebut singleton `user_profile` dengan ID teks tanpa nilai literal. Fase 0 memakai fixed ID `local_user`; singleton integer memakai ID `1`.
4. Penghapusan metadata key memakai `SET NULL` untuk Active Key dan referensi Food Log, serta cascade untuk usage events. Penghapusan Food Log meng-cascade item tetapi mempertahankan chat dengan `food_log_id = NULL`.

## Open questions untuk fase berikutnya

- Nilai timeout/cooldown harus dituning dengan pengujian jaringan nyata sebelum release.
- Model dan API version Gemini harus diverifikasi kembali menjelang setiap release.
- Keputusan produk PRD §16 (input limit, undo window, reminder horizon, App Lock timeout, dan lainnya) tetap terbuka sampai fase fitur terkait.
- UX onboarding API key dan hasil runner live perlu diuji pada perangkat nyata; tidak menjadi gate automated test.
