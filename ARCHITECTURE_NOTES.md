# Architecture Notes — KeySpace

## Status

Internal MVP nutrisi tersedia. Ekspansi voice dan personal finance telah mencapai Gate Tahap 4; unified review/penyimpanan chat dan dashboard finance belum diintegrasikan.

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
- Provider config terpusat memakai alias model `gemini-flash-latest`, API `v1beta`, connect timeout 10 detik, receive timeout 30 detik, satu retry transient, backoff 500 ms + jitter 0–250 ms, fallback cooldown rate-limit 60 detik, dan transient cooldown 15 detik.
- Root aplikasi mempertahankan satu `MaterialApp.router` sepanjang bootstrap, recovery, dan perubahan settings. Layar bootstrap/recovery dirender melalui `builder` agar Navigator dan inherited widgets tidak dibongkar saat stream settings berubah.
- Tes API key dikerjakan oleh `ApiKeyTestService` tanpa `BuildContext`, dibatasi 35 detik, dapat dibatalkan saat halaman dilepas, dan hanya satu request tes yang boleh aktif pada satu waktu.
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

## Audit ekspansi fitur — Gate Tahap 1 (2026-07-22)

Audit ini menjadi baseline sebelum penambahan voice-to-text dan personal finance. Tidak ada perubahan fitur atau schema pada gate ini.

### Baseline implementasi

- Database masih schema v1 dengan 12 tabel. `AppDatabase` hanya memiliki `onCreate` dan `beforeOpen`; migration `onUpgrade` belum ada. Snapshot `drift_schemas/drift_schema_v1.json` adalah sumber fixture migrasi versi lama.
- Riverpod dipakai untuk dependency injection dan stream reaktif. `infrastructure_providers.dart` merangkai database, repository, Gemini client/failover, settings, target, reminder, dan API-key service.
- Router memakai `StatefulShellRoute.indexedStack` dengan lima branch persisten: Hari Ini, Chat, Riwayat, Insight, dan Pengaturan. Route finance belum ada.
- Draft chat saat ini masih khusus nutrisi: teks disimpan sebagai `food_logs` berstatus `draft`, sedangkan status request dan pesan disimpan melalui `chat_sessions`/`chat_messages`. Karena bentuk ini membawa field meal/nutrition, draft lintas domain perlu tabel tersendiri pada schema v2.
- Gemini contract masih khusus `parseFood`. Sticky Sequential Failover, penyimpanan pending request sebelum network, request cancellation, health/cooldown key, dan sanitized error handling harus dipertahankan ketika kontrak digeneralisasi.
- UI nutrisi, reminder reconciliation, secure storage, root `MaterialApp.router`, dan lifecycle hardening merupakan baseline kompatibilitas yang tidak boleh diregresikan.

### Keputusan ekspansi yang dikunci

- Implementasi berjalan per tahap dan berhenti pada setiap gate.
- Navigasi akan menambah tab keenam `Keuangan`; tab lama tidak digusur.
- Mata uang v1 dibatasi ke IDR, tetapi transaksi tetap menyimpan snapshot `currencyCode`.
- Perubahan cycle start tidak merekalkulasi histori dan memakai satu periode jembatan bila diperlukan agar tidak ada gap atau overlap.
- Automated Gemini test tetap fake/fixture-based; live Gemini dan voice recognition hanya divalidasi manual secara opt-in/perangkat nyata.

### Risiko overlap worktree

- Worktree sudah memuat perubahan Gemini schema, API-key lifecycle service, app root, onboarding, chat, provider, dan test yang belum di-commit. Tahap berikutnya wajib mengembangkan perubahan tersebut in-place dan tidak mengembalikan file ke versi `HEAD`.
- `app_database.g.dart` dan snapshot schema akan berubah pada Tahap 2; codegen harus dijalankan setelah definisi migration dan tabel final untuk gate tersebut.
- Router dan chat memiliki regression test aktif; penambahan branch/mode harus memperbarui test tanpa mengurangi coverage route dan lifecycle yang ada.

### Validasi baseline

- Flutter 3.44.6 dan Dart 3.12.2 dijalankan dari salinan SDK writable `/tmp/keyspace-flutter-sdk`, dengan pub cache `/tmp/keyspace-pub-cache`.
- `flutter analyze`: lulus, `No issues found` (20,5 detik).
- `flutter test`: 63 test lulus. Percobaan sandbox pertama hanya gagal membuka socket loopback internal Flutter tester; suite yang sama lulus setelah dijalankan dengan izin loopback.
- `git diff --check`: lulus.

## Ekspansi fitur — Gate Tahap 2 (2026-07-22)

### Schema dan migrasi

- Schema naik dari v1 (12 tabel) ke v2 (17 tabel) secara additive. Tabel baru: `financial_categories`, `financial_periods`, `financial_transactions`, `finance_settings`, dan `chat_drafts`; `app_settings` mendapat `voice_disclosure_acknowledged` dengan default `false`.
- Migration v1→v2 menambah kolom, tabel, dan seluruh index secara eksplisit. Test memakai snapshot v1 untuk membuka database lama, menyimpan Food Log, menjalankan migration aktual, lalu memverifikasi data nutrisi tetap ada dan schema cocok dengan snapshot v2.
- Seed terdiri dari 13 kategori expense dan 10 kategori income dengan ID deterministik. `INSERT OR IGNORE` dijalankan setiap database dibuka; test reopen file membuktikan jumlah seed tetap 23. Kategori income reimbursement bernama `Penggantian Biaya (Reimbursement)` dan tidak terhubung otomatis dengan flag expense.
- Constraint database menjaga cycle day 1–28, budget non-negatif, amount positif, IDR-only, domain type valid, income bukan reimburse, singleton finance settings, rentang periode unik, serta foreign key category/period `RESTRICT`.

### Domain dan repository

- `FinancialPeriodResolver` menormalisasi local date, menghitung periode tanpa durasi tetap, menamai periode berdasarkan end date, dan menangani tahun baru serta Februari leap/non-leap.
- `FinanceRepository` menjadi pemilik atomic get-or-create period. Perubahan cycle day mempertahankan periode lama dan membuat satu periode jembatan dari hari setelah periode lama sampai sehari sebelum boundary baru bila diperlukan.
- Batch transaction divalidasi dan disimpan dalam satu transaction Drift; kegagalan item mana pun me-rollback seluruh batch. Edit tanggal menghitung ulang `financialPeriodId`.
- Agregat expense, income, reimburse, budget usage, remaining budget, net balance, breakdown kategori, recent transactions, filter, dan search dijalankan oleh query database/stream, bukan memuat seluruh histori ke memory.
- System category hanya dapat dinonaktifkan. Join transaksi tetap membaca nama kategori inactive untuk histori; custom category yang belum dipakai dapat dihapus.
- `ChatDraftRepository` menyimpan teks dan selected mode secara terpisah dari draft `food_logs`. Provider finance dan chat draft sudah tersedia untuk tahap integrasi berikutnya.

### Catatan codegen

- Snapshot v2 dan helper migration disimpan di repository. Drift 2.34.0 memiliki collision pada helper versi ketika kolom SQL bernama `text`; getter tabel helper dipertahankan sebagai `draftText` tanpa mengubah nama kolom SQL `chat_drafts.text`.

### Validasi Gate Tahap 2

- `flutter analyze`: lulus, `No issues found`.
- `flutter test`: 84 test lulus, termasuk migration v1→v2, seed reopen/idempotency, resolver kalender dan bridge, concurrent get-or-create, batch rollback, agregasi/formula, reaktivitas edit/hapus, category lifecycle, filter/search, dan chat draft.
- `git diff --check`: lulus.
- Tidak ada perubahan route, UI, kontrak Gemini, dependency voice, atau konfigurasi platform pada tahap ini.

## Ekspansi fitur — Gate Tahap 3 (2026-07-22)

### Kontrak structured output terpadu

- `GeminiClient` dan `GeminiFailoverService` kini menyediakan operasi `parseChat` untuk mode Automatic, Nutrition, Expense, dan Income. Operasi `parseFood` lama tetap tersedia dan seluruh regresi nutrisi tetap lulus.
- Request unified hanya membawa input teks, selected mode, local date, timezone, currency IDR, nama/tipe kategori aktif, dan instruksi structured output. ID database kategori, histori chat, profil, serta secret tidak dimasukkan ke body.
- Schema respons memuat `detected_domain`, confidence, clarification, multiple items, field nutrisi lama, dan field transaksi keuangan. Versi kontrak provider dinaikkan menjadi 2.
- Parser mengunci domain pada mode eksplisit dan hanya mengizinkan nutrition/expense/income/unknown pada mode Automatic. Nominal finance wajib integer positif, currency wajib IDR, tanggal wajib local date ISO yang valid, dan kategori wajib aktif atau jatuh ke kategori `Lainnya` dengan tipe yang sama.
- Prompt fixture mengunci normalisasi `150 ribu`→`150000`, `1,5 juta`→`1500000`, `2 jt`→`2000000`, serta resolusi tanggal relatif dari `local_date`. Nilai yang sudah dinormalisasi tetap divalidasi deterministik di client.
- Gemini tidak diberi field `isReimburse`; parser juga menolak respons yang mencoba mengirim `is_reimburse`/`isReimburse`. Reimburse tetap keputusan pengguna pada review UI tahap berikutnya.

### Failover dan preservasi draft

- Unified parsing memakai sticky key order, eligibility/cooldown, satu retry transient, repair schema tepat satu kali, sanitized health tracking, usage event, offline handling, dan request cancellation yang sama dengan jalur nutrisi.
- Pending input disimpan sebelum network. Offline, cancellation, schema mismatch, terminal request error, dan seluruh key gagal mengembalikan result dengan `inputPreserved=true`; preview unified baru ditulis setelah parser lokal menerima respons.
- Seluruh pengujian Gemini Tahap 3 memakai fake client dan fixture lokal. Runner live Gemini tidak dijalankan dan tidak menjadi klaim gate.

### Validasi Gate Tahap 3

- `dart format lib test tool`: selesai; 78 file diperiksa pada run final.
- `flutter analyze`: lulus, `No issues found`.
- `flutter test`: 103 test lulus, termasuk regresi nutrisi, mode detection/lock, clarification, nominal Indonesia, tanggal relatif fixture, invalid JSON/field, category fallback, reimburse rejection, key failover, cancellation, dan all-keys-failed.
- Percobaan focused test pertama di sandbox hanya gagal membuka socket loopback internal Flutter tester; test yang sama dan suite penuh lulus setelah izin loopback diberikan.
- Tidak ada live Gemini, perangkat fisik, voice recognizer, atau konfigurasi permission platform yang diuji pada tahap ini.

## Ekspansi fitur — Gate Tahap 4 (2026-07-22)

### Service dan state machine voice

- Dependency terkunci ke `speech_to_text` 7.4.0 dan `permission_handler` 12.0.3, masih dalam rentang 7.4.x/12.0.x yang dipilih. Adapter memakai satu instance recognizer, partial result, dictation mode, locale `id_ID`, batas sesi satu menit, pause lima detik, serta recognizer online/on-device yang dipilih sistem.
- Public `SpeechRecognitionService` menyediakan availability, permission status/request, start, stop, cancel, open app settings, dan dispose. Detail plugin tidak bocor ke controller atau UI.
- Public `VoiceInputStatus` mengikuti state tetap: idle, requestingPermission, listening, processing, completed, denied, dan failed. Controller mencegah sesi ganda, memetakan silence/timeout/network/permission/unavailable, dan melakukan cancellation best-effort saat halaman dilepas.
- Android menambahkan `RECORD_AUDIO`, `INTERNET`, dan query `android.speech.RecognitionService`. iOS menambahkan `NSMicrophoneUsageDescription` serta `NSSpeechRecognitionUsageDescription`; proyek menggunakan Flutter Swift Package Manager sehingga permission plugin mendeteksi usage keys tanpa Podfile macro terpisah.

### Composer dan privasi

- Penggunaan pertama menampilkan disclosure spesifikasi secara verbatim sebelum permission diminta. Acknowledgement disimpan pada flag schema v2 dan dialog tidak diulang setelah pengguna memilih Lanjutkan.
- Partial/final transcript hanya menulis `TextEditingController`; tidak ada pemanggilan Gemini. Final transcript difokuskan kembali agar dapat diedit, sedangkan tombol Kirim nonaktif selama voice aktif.
- Saat listening tersedia Stop dan Batal. Permission denied menyediakan tombol menuju app settings dan tidak menonaktifkan input manual. Status memiliki live region dan tombol mikrofon memiliki semantic label sesuai state.
- Chat masih memakai flow nutrisi lama untuk aksi Kirim. Persistensi selected mode dan unified review baru dihubungkan pada Tahap 5.

### Validasi Gate Tahap 4

- `dart format lib test tool`: 84 file diperiksa, tidak ada perubahan tersisa.
- `flutter analyze`: lulus, `No issues found`.
- `flutter test`: seluruh 114 test lulus. Coverage baru mencakup permission granted/denied/permanent denial, unavailable, silence/no-match, timeout, network error, single active session, Stop/Batal, dispose saat listening, disclosure satu kali, app settings, editable partial/final draft, semantics, send disabled, dan no-auto-send.
- Test platform memverifikasi permission/query Android serta usage descriptions iOS tersimpan dalam file konfigurasi.
- Recognizer nyata, dialog permission sistem, jaringan speech provider, kualitas transkripsi, open-app-settings nyata, dan lifecycle pada perangkat fisik belum diuji. Tidak ada klaim validasi Android/iOS device pada gate ini.

## Ekspansi fitur — Gate Tahap 5 (2026-07-22)

### Unified composer dan draft

- Chat memakai satu composer dengan mode Otomatis, Kalori, Pengeluaran, dan Pemasukan; default selalu Otomatis setelah penyimpanan berhasil. Mode dan teks disimpan melalui `ChatDraftRepository`, termasuk sebelum request Gemini dimulai.
- Draft tidak dihapus pada offline/network failure, invalid schema/JSON, cancellation, clarification, atau seluruh key gagal. Single-flight `_requesting` mencegah request ganda dan tombol Kirim tetap nonaktif selama sesi voice aktif.
- Aksi seluruh-key-gagal tetap menawarkan Tambah API Key, Kelola, Coba Lagi, dan Catat Manual. Dialog hanya mengembalikan pilihan; navigasi atau retry dilakukan sesudah dialog tertutup dan setelah mounted guard.

### Review dan penyimpanan

- Cabang nutrisi tetap membuat Food Log draft, menerapkan parsed items, membuka preview/edit, mengonfirmasi, dan menjalankan reminder reconciliation. Chat message dengan request ID yang sama ditautkan kembali ke Food Log bila tersedia.
- Cabang expense/income menampilkan review multiple item yang dapat mengubah tipe, nama, nominal integer IDR, tanggal, kategori, catatan, reimbursement khusus expense, dan menghapus item individual.
- Konversi expense ke income memilih kategori `Lainnya` yang sesuai tipe dan selalu menghapus flag reimbursement. Gemini tetap tidak menentukan reimbursement.
- `FinanceRepository.saveBatch` menjadi satu-satunya jalur penyimpanan review dan menggunakan satu transaksi database, sehingga kegagalan satu item me-rollback seluruh batch. Draft composer baru dihapus setelah penyimpanan sukses.
- Catat Manual mengikuti mode aktif; mode Otomatis meminta pengguna memilih Kalori, Pengeluaran, atau Pemasukan terlebih dahulu.

### Validasi Gate Tahap 5

- `dart format lib test tool`: 86 file diperiksa dan bersih.
- `flutter analyze`: lulus, `No issues found`.
- `flutter test`: seluruh 118 test lulus. Coverage gate mencakup draft preservation pada all-keys-failed, selected-mode persistence, finance type conversion, reimbursement contextual, edit/hapus multiple item, atomic save/rollback repository, safe recovery actions, serta regresi preview/confirm nutrisi.
- Seluruh Gemini automated test tetap fake/fixture-based. Live Gemini, recognizer nyata, permission OS, secure storage pada perangkat, dan physical-device flow belum diuji.
- Route dashboard/riwayat/detail/pengaturan finance dan tab keenam belum ditambahkan; pekerjaan berhenti sebelum Tahap 6 sesuai gate.

## Ekspansi fitur — Gate Tahap 6 (2026-07-22)

### Navigasi dan query reaktif

- `StatefulShellRoute.indexedStack` kini memiliki enam branch persisten: Hari Ini, Chat, Riwayat nutrisi, Insight, Keuangan, dan Pengaturan. Navigation bar hanya menampilkan label destination aktif agar enam tab tetap terbaca pada viewport sempit.
- Route publik finance tersedia pada `/finance`, `/finance/history`, `/finance/transaction/:id`, dan `/settings/finance`. Route nutrisi lama tidak dipindah atau diganti.
- Repository menambahkan stream daftar periode dan lookup transaksi detail tanpa perubahan schema. Dashboard, detail, dan riwayat tetap membaca agregat/filter melalui SQL/Drift; tidak ada agregasi histori di widget.

### Dashboard dan riwayat

- Dashboard menampilkan nama/rentang periode aktif, budget, budget usage non-reimburse, sisa, persentase, over-budget state, total expense/income/reimburse, saldo bersih, breakdown kategori expense, dan lima transaksi terbaru.
- Summary, breakdown, recent list, dan period budget menggunakan provider/stream terpisah. Create, edit termasuk perubahan reimburse, dan delete langsung memperbarui kartu serta daftar tanpa refresh manual.
- Riwayat dapat memilih seluruh periode lama, mencari nama case-insensitive, dan memfilter tipe, kategori termasuk kategori histori nonaktif, serta status reimburse. Total periode dan rekap kategori tetap terlihat bersama hasil filter.
- Transaksi dapat dibuka untuk mengedit tipe, nama, nominal integer IDR, tanggal, kategori, catatan, dan reimburse. Konversi ke income mengganti kategori sesuai tipe dan memaksa reimburse `false`; edit tanggal tetap menyerahkan reassignment periode ke repository.
- Delete dari riwayat maupun detail selalu memakai dialog konfirmasi sebelum mutasi permanen.

### Pengaturan dan presentasi

- Pengaturan finance menyediakan cycle day 1–28, default budget periode baru, budget periode aktif, indikator IDR-only, penambahan kategori custom, aktivasi/nonaktivasi, dan penghapusan kategori custom yang belum dipakai.
- Perubahan cycle day tetap memakai resolver/repository Tahap 2: periode aktif menjadi anchor, konfigurasi baru berlaku sesudahnya, dan histori tidak direkalkulasi.
- Layar menggunakan komponen neo-brutalist yang sudah ada, field berlabel, tooltip/semantic metrics, responsive wrap/grid, serta state loading, empty, error, success, dan over-budget. Transaction tile memakai layout compact khusus viewport sempit.
- Informasi privasi diperbarui: transaksi tersimpan lokal dan histori/budget tidak dikirim ke Gemini.

### Validasi Gate Tahap 6

- `dart format lib test tool`: 93 file diperiksa dan bersih.
- `flutter analyze`: lulus, `No issues found`.
- `flutter test`: seluruh 124 test lulus. Coverage baru mencakup enam-tab/public routes, period/transaction streams, dashboard reaktif setelah create/edit/delete, search dan periode lama, konversi detail ke income, budget settings IDR-only, serta seluruh regression nutrisi/voice/Gemini lama.
- Fixture dashboard representatif berisi 100 transaksi dan test render lokal lulus target kurang dari 500 ms pada environment test ini. Angka tersebut bukan benchmark perangkat Android/iOS release.
- Tidak ada perubahan schema atau codegen pada Tahap 6. Live Gemini, recognizer/permission OS, secure storage perangkat, serta physical-device rendering belum diuji.
- Pekerjaan berhenti sebelum quality gate dan dokumentasi final Tahap 7.

## Ekspansi fitur — Gate Tahap 7 (2026-07-23)

### Quality gate aktual

1. `dart format .` memeriksa 93 file dan tidak menghasilkan perubahan.
2. `dart run build_runner build --delete-conflicting-outputs` selesai dalam 92 detik dan menulis 173 build outputs. Build runner versi aktif memperingatkan bahwa flag `--delete-conflicting-outputs` sudah dihapus dan diabaikan; codegen tetap selesai. Hash `app_database.g.dart`, snapshot v2, dan helper schema v2 tidak berubah.
3. Dump schema v2 baru dibuat di direktori sementara dan cocok byte-for-byte dengan `drift_schemas/drift_schema_v2.json`. Drift juga berhasil meregenerasi helper schema v1/v2 ke direktori sementara. Migration test v1→v2 dan seluruh database test termasuk dalam suite penuh yang lulus.
4. `flutter analyze` lulus dengan `No issues found`.
5. `flutter test` lulus seluruh 124 test. Automated Gemini tetap fake/fixture-based dan tidak memakai kuota atau key live.
6. `git diff --check`, audit pola credential, serta audit file `.env`, private key, keystore, dan konfigurasi service sensitif semuanya bersih.

### Status Android build

- `flutter build apk --debug` dijalankan dengan `GRADLE_USER_HOME=/tmp/keyspace-gradle-home`. Artifact `build/app/outputs/flutter-apk/app-debug.apk` terbentuk dengan ukuran 188.619.477 byte dan SHA-256 `032e76cb34113f00471be87c662516815b99571e231f06343b7898c0a2836b1b`.
- `unzip -tq` tidak menemukan kerusakan pada compressed data APK. Namun wrapper Flutter tertahan pada finalisasi `assembleDebug` dan tidak pernah mencetak completion message; percobaan incremental kedua juga tertahan lalu sesi terputus.
- Tidak ada proses Gradle/Flutter tersisa setelah sesi dipulihkan. Folder report antara `android/build/` yang dibuat oleh percobaan build telah dibersihkan; APK yang berada di direktori build ter-ignore tetap dipertahankan.
- Kesimpulan konservatif: artifact APK tersedia dan utuh sebagai arsip, tetapi Android build belum diklaim lulus bersih serta APK belum diinstal/dijalankan pada perangkat.

### Risiko residual dan batas validasi

- Recognizer voice nyata, permission dialog, open app settings, kualitas transkripsi, dan lifecycle microphone belum diuji pada Android/iOS fisik.
- Secure storage hanya diuji melalui abstraction/fake di automated test; persistensi Keychain/Keystore perangkat belum diverifikasi.
- Live Gemini end-to-end tidak dijalankan pada gate ini. Parser, failover, cancellation, draft preservation, dan structured contract tervalidasi offline.
- Target render dashboard kurang dari 500 ms lulus dengan fixture 100 transaksi pada test host, bukan benchmark profile/release perangkat.
- Release signing, release APK/AAB, store policy, iOS build, dan distribusi produksi berada di luar validasi ini.

### Checklist smoke test manual

- Voice: disclosure pertama, izin granted/denied/permanently denied, app settings, Stop/Batal, silence/network error, partial/final editable draft, no-auto-send, background/foreground, dan dispose saat listening.
- Gemini/chat: empat mode, clarification, nominal Indonesia, tanggal relatif, kategori fallback, invalid JSON, cancellation, failover semua key, recovery navigation, dan draft setelah restart.
- Finance: atomic multiple save, type conversion, reimburse context, edit tanggal lintas periode, create/edit/delete reaktif, over-budget, filter/search, histori kategori nonaktif, cycle-day bridge, default/active budget, dan IDR-only.
- Nutrisi/regresi: preview/edit/confirm Food Log, reminder reconciliation, riwayat harian, target, API-key management, dan root lifecycle tanpa `_dependents.isEmpty`.

Gate Tahap 7 selesai berdasarkan hasil aktual di atas; tidak ada klaim physical-device, secure-storage platform, live Gemini, atau clean Android build completion.
