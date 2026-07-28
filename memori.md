# Memori Implementasi KeySpace

## 2026-07-21 — Fase 0

- Scope dikunci hanya Fase 0; berhenti sebelum Internal MVP.
- Scaffold Flutter 3.44.6/Dart 3.12.2 untuk Android/iOS dengan ID `com.keyspace.app`, Android API 24, iOS 13.
- SDK `/opt/flutter` read-only tidak diubah; command memakai salinan writable `/tmp/keyspace-flutter-sdk` dan pub cache `/tmp/keyspace-pub-cache`.
- Implementasi: Riverpod bootstrap, theme neo-brutalist dasar, seluruh route placeholder SRS, Drift schema v1 (12 tabel), secure storage wrapper, Gemini client/parser/taxonomy/failover, repository Drift, fixture corpus, manual live runner, dan automated tests.
- Dependency solver mengharuskan Drift/drift_dev 2.34.0 karena 2.34.1+ konflik dengan versi analyzer/test yang kompatibel dengan Flutter SDK ini. Lockfile adalah sumber versi final.
- Codegen build_runner pada environment sempat memerlukan tahap kompilasi AOT terpisah; output Drift dan `drift_schemas/drift_schema_v1.json` berhasil dibuat.
- Validasi final:
  - `dart format --output=none --set-exit-if-changed lib test tool`: 31 file, 0 perubahan.
  - `flutter analyze`: tidak ada issue.
  - `flutter test`: 35 test lulus.
  - Audit pola credential umum: tidak menemukan API key nyata pada source, test, tool, atau dokumen hasil implementasi.
- Runner Gemini live tidak dijalankan karena bersifat opt-in, membutuhkan key pengguna, dan dapat memakai kuota/biaya.
- Phase gate Fase 0 terpenuhi. Jangan lanjut ke Fase 1 sebelum ada instruksi pengguna.

## 2026-07-22 — Perbaikan Gemini live

- API key pengguna diuji secara live tanpa disimpan ke source, dokumen, argument command, atau environment repository. Endpoint daftar model merespons HTTP 200.
- Penyebab error aplikasi adalah `responseSchema` nullable yang memakai array `type`, sehingga Gemini REST menolak seluruh request dengan HTTP 400 `INVALID_ARGUMENT`.
- Seluruh field nullable diubah ke satu scalar `type` dengan `nullable: true`, sesuai format REST Gemini.
- `GeminiErrorClassifier` tidak lagi menarik implementasi Flutter secure storage ke jalur Gemini CLI; `dart run tool/gemini_poc.dart` kembali dapat dijalankan. Error secure storage tetap ditangani langsung oleh failover service.
- Pesan hasil tes API key di aplikasi sekarang menjelaskan kategori kegagalan dan tindakan yang relevan.
- Validasi live pascaperbaikan: 6 dari 12 respons corpus valid; 6 sisanya mencapai rate limit. Ini mengonfirmasi HTTP 400 schema sudah teratasi, tetapi kuota key membatasi corpus penuh.
- Validasi lokal akhir: `flutter analyze` bersih, seluruh 48 test lulus, `git diff --check` bersih, dan audit pola credential tidak menemukan key live di repository.

## 2026-07-22 — Hardening lifecycle tes API key

- Akar assertion `_dependents.isEmpty` adalah pergantian root antara `MaterialApp(home:)` dan `MaterialApp.router` ketika bootstrap/settings berubah, berdekatan dengan update stream saat status API key disimpan.
- Root diubah menjadi satu `MaterialApp.router` yang stabil; bootstrap dan recovery hanya mengganti child pada `builder` tanpa membongkar Navigator atau dependency root.
- Logic tes key dipindahkan ke `ApiKeyTestService` tanpa `BuildContext`, dengan timeout 35 detik, cancellation, pemetaan status HTTP termasuk model/endpoint 404, dan update health tersanitasi.
- `ApiKeyPoolScreen` menjadi `ConsumerStatefulWidget` dengan single-flight state, indikator loading pada tombol, cancellation saat dispose, serta guard mounted setelah asynchronous gap.
- Onboarding menggunakan service tes yang sama sehingga mapping, timeout, dan penyimpanan status tidak terduplikasi.
- Dialog semua-key-gagal mengembalikan action melalui `Navigator.pop`; navigation/retry dilakukan setelah dialog selesai menggunakan context halaman yang masih mounted.
- Validasi final: `flutter analyze` tanpa issue, seluruh 63 test lulus, dan `git diff --check` bersih.

## 2026-07-22 — Gate Tahap 1 ekspansi voice dan finance

- Scope gate hanya audit dan baseline; belum ada perubahan fitur, route, dependency, atau schema database.
- Baseline database tetap Drift schema v1 dengan 12 tabel dan belum memiliki `onUpgrade`. Draft lintas domain tidak dapat memakai `food_logs` tanpa membawa coupling nutrisi, sehingga Tahap 2 akan menambah `chat_drafts` tersendiri secara additive.
- Riverpod, `StatefulShellRoute.indexedStack` lima tab, kontrak Gemini `parseFood`, Sticky Sequential Failover, secure storage, reminder, dan lifecycle hardening telah dipetakan sebagai kontrak yang harus dipertahankan.
- Keputusan produk: eksekusi berhenti di tiap gate, tambah tab keenam Keuangan, v1 finance IDR-only, dan perubahan cycle day memakai periode jembatan tanpa merekalkulasi histori.
- Worktree sudah berisi perubahan Gemini/API-key lifecycle yang belum di-commit. Tahap berikutnya harus mengembangkan kondisi aktual tersebut dan tidak mengembalikan file ke `HEAD`.
- Flutter SDK writable disiapkan kembali di `/tmp/keyspace-flutter-sdk`; pub cache berada di `/tmp/keyspace-pub-cache`.
- Baseline aktual: `flutter analyze` bersih, seluruh 63 test lulus, dan `git diff --check` bersih. Kegagalan test pertama berasal dari larangan socket loopback sandbox, bukan dari kode; suite lulus setelah izin loopback diberikan.
- Gate Tahap 1 selesai. Jangan lanjut ke Tahap 2 sebelum ada instruksi pengguna.

## 2026-07-22 — Gate Tahap 2 domain dan database

- Drift naik additive dari schema v1/12 tabel ke v2/17 tabel: financial categories, periods, transactions, finance settings, dan chat drafts; app settings mendapat flag disclosure voice default false.
- Migration v1→v2 membuat seluruh tabel/index dan diuji dari snapshot v1 dengan Food Log lama. Data nutrisi tetap utuh dan schema hasil migration cocok dengan snapshot v2.
- Seed 13 kategori expense + 10 income memakai ID deterministik dan insert-or-ignore. Reopen database tidak menduplikasi seed; nama income reimbursement persis `Penggantian Biaya (Reimbursement)` dan tidak memiliki linkage otomatis ke flag expense.
- `FinancialPeriodResolver` mencakup local date, pergantian tahun, leap year, Februari, dan periode jembatan. Repository get-or-create atomic mempertahankan rentang histori ketika cycle day berubah.
- `FinanceRepository` menyediakan batch atomic, edit dengan reassignment periode, category lifecycle, filter/search, recent data, breakdown, serta agregat SQL reaktif untuk formula budget/reimburse/net balance.
- `ChatDraftRepository` menyimpan draft lintas domain terpisah dari Food Log nutrisi. Provider repository sudah dirangkai tetapi belum dipakai UI.
- Catatan Drift 2.34.0: helper migration menghasilkan getter `text` yang bentrok dengan `Table.text()`; getter helper v2 dipatch menjadi `draftText` sementara kolom SQL tetap `chat_drafts.text`.
- Validasi akhir gate: `flutter analyze` bersih, seluruh 84 test lulus, dan `git diff --check` bersih.
- Gate Tahap 2 selesai. Jangan lanjut ke Tahap 3 sebelum ada instruksi pengguna.

## 2026-07-22 — Gate Tahap 3 kontrak Gemini terpadu

- `GeminiClient` dan `GeminiFailoverService` mendapat operasi `parseChat` terpadu untuk Automatic, Nutrition, Expense, Income, dan Unknown tanpa menghapus jalur `parseFood` lama.
- Request body dibatasi pada input, selected mode, local date, timezone, IDR, serta nama/tipe kategori aktif. Prompt mengunci domain eksplisit, clarification, nominal Indonesia (`150 ribu`, `1,5 juta`, `2 jt`), tanggal relatif, dan category fallback.
- `UnifiedChatResponseParser` memvalidasi confidence, clarification, multiple items, kompatibilitas mode/domain, nominal integer positif, IDR, tanggal ISO lokal valid, serta kategori aktif. Kategori asing jatuh ke `Lainnya` dengan tipe yang sama.
- Gemini tidak menentukan reimburse: field itu tidak ada di response schema dan respons yang mencoba mengirim `is_reimburse` atau `isReimburse` ditolak.
- Unified failover mempertahankan sticky priority, cooldown/health tracking, bounded transient retry, satu schema repair, cancellation, sanitized errors, dan pending input sebelum network. Semua error mempertahankan draft/input.
- Seluruh validasi Gemini tetap fake/fixture-based; live Gemini tidak dijalankan. UI chat masih memakai flow nutrisi lama dan baru akan diintegrasikan pada Tahap 5 setelah voice service Tahap 4.
- Validasi akhir gate: `dart format` selesai, `flutter analyze` bersih, seluruh 103 test lulus, dan focused fixture mencakup mode, clarification, invalid JSON, failover, cancellation, serta all-keys-failed.
- Gate Tahap 3 selesai. Jangan lanjut ke Tahap 4 sebelum ada instruksi pengguna.

## 2026-07-22 — Gate Tahap 4 voice-to-text

- Dependency voice terkunci ke `speech_to_text` 7.4.0 dan `permission_handler` 12.0.3. Adapter plugin dipisahkan dari public `SpeechRecognitionService` agar seluruh automated test tetap memakai fake recognizer.
- `VoiceInputController` menerapkan state idle/requestingPermission/listening/processing/completed/denied/failed, single active session, partial/final callback, silence/timeout/network/unavailable mapping, Stop/Batal, serta cancel saat dispose.
- Composer chat mendapat tombol mikrofon dengan semantic state, Stop/Batal, Kirim nonaktif selama sesi voice, app-settings fallback ketika permission ditolak, dan input manual tetap aktif.
- Disclosure persis dari spesifikasi ditampilkan sebelum permission pada penggunaan pertama dan acknowledgement disimpan melalui flag `voice_disclosure_acknowledged` schema v2.
- Transcript partial/final hanya memperbarui draft `TextEditingController`; Gemini tidak dipanggil otomatis. Final draft dapat diedit dan field difokuskan kembali.
- Android memuat `RECORD_AUDIO`, `INTERNET`, dan query `android.speech.RecognitionService`; iOS memuat usage descriptions microphone dan speech recognition. iOS checkout menggunakan Swift Package Manager, bukan Podfile.
- Validasi akhir gate: 84 file format bersih, `flutter analyze` bersih, dan seluruh 114 test lulus, termasuk permission, unavailable, silence, timeout/network, cancel/dispose, disclosure, editable draft, semantics, serta no-auto-send.
- Physical-device recognition, system permission dialogs, open app settings nyata, dan kualitas hasil speech belum diuji. Gate Tahap 4 selesai; jangan lanjut ke Tahap 5 sebelum ada instruksi pengguna.

## 2026-07-22 — Gate Tahap 5 unified chat, review, dan penyimpanan

- Chat menjadi satu composer dengan mode Otomatis/Kalori/Pengeluaran/Pemasukan dan default Otomatis. Teks serta selected mode dipersistenkan di `chat_drafts`; draft hanya dihapus setelah penyimpanan berhasil.
- Voice tetap hanya mengisi draft yang dapat diedit. Kirim nonaktif selama voice aktif dan state request Gemini memakai single-flight agar request ganda tidak terjadi.
- Failure offline/network, invalid JSON/schema, cancellation, clarification, dan seluruh-key-gagal mempertahankan draft. Recovery dialog tetap menyediakan Tambah API Key, Kelola, Coba Lagi, dan Catat Manual dengan navigation sesudah dialog tertutup.
- Jalur nutrisi lama dipertahankan: Food Log draft, parsed preview/edit, confirm, chat linkage, dan reminder reconciliation tetap aktif.
- Review finance mendukung multiple item, edit tipe/nama/nominal/tanggal/kategori/catatan, hapus per item, serta reimbursement hanya untuk expense. Konversi ke income mengganti kategori sesuai tipe dan memaksa reimbursement false.
- Save review memakai `FinanceRepository.saveBatch` dalam satu transaksi; test repository lama tetap membuktikan rollback seluruh item ketika satu item gagal.
- Validasi akhir gate: 86 file format bersih, `flutter analyze` bersih, dan seluruh 118 test lulus. Test mencakup draft preservation, type conversion, contextual reimbursement, multi-item edit/delete, atomic save/rollback, recovery action, dan regresi nutrisi.
- Live Gemini, recognizer/permission OS, secure storage pada perangkat, serta physical-device flow belum diuji. Gate Tahap 5 selesai; jangan lanjut ke Tahap 6 sebelum ada instruksi pengguna.

## 2026-07-22 — Gate Tahap 6 dashboard, riwayat, dan pengaturan keuangan

- Router sekarang memiliki branch keenam Keuangan tanpa menggusur lima tab lama. Route publik ditambah untuk `/finance`, `/finance/history`, `/finance/transaction/:id`, dan `/settings/finance`.
- Dashboard finance memakai stream summary/breakdown/recent dan menampilkan periode/rentang, budget, usage non-reimburse, sisa/persentase, over-budget, expense, income, net balance, reimburse, kategori, dan transaksi terbaru.
- Riwayat mendukung periode lama, filter type/category/reimburse, pencarian nama di SQL, total periode, rekap kategori, edit/detail, dan delete dengan konfirmasi.
- Detail transaksi dapat mengubah seluruh field wajib. Konversi ke income memaksa reimburse false dan memilih kategori income; perubahan tanggal tetap menghitung ulang periode melalui repository.
- Pengaturan menyediakan cycle day 1–28, default budget, budget aktif, IDR-only indicator, serta create/toggle/delete kategori. Kategori sistem hanya dinonaktifkan dan kategori custom yang masih dipakai tidak dapat dihapus.
- Repository mendapat stream daftar periode dan lookup transaksi detail secara additive; schema tetap v2 dan tidak ada migration/codegen baru pada tahap ini.
- UI mempertahankan neo-brutalist, semantic metrics/tooltip, loading-empty-error-success state, responsive wrap, dan compact transaction tile pada viewport sempit.
- Validasi akhir gate: 93 file format bersih, `flutter analyze` bersih, dan seluruh 124 test lulus. Fixture 100 transaksi lulus target render test lokal kurang dari 500 ms; ini bukan benchmark physical device/release.
- Live Gemini, voice/permission OS, secure storage perangkat, dan render Android/iOS fisik belum diuji. Gate Tahap 6 selesai; jangan lanjut ke Tahap 7 sebelum instruksi pengguna.

## 2026-07-23 — Gate Tahap 7 quality gate dan dokumentasi final

- `dart format .` memeriksa 93 file tanpa perubahan. Build runner selesai dalam 92 detik; flag delete-conflicting-outputs diperingatkan sudah tidak berlaku, tetapi codegen sukses dan hash output database tidak berubah.
- Dump Drift schema v2 baru identik byte-for-byte dengan snapshot repository. Helper migration v1/v2 berhasil diregenerasi ke `/tmp`; migration v1→v2 tetap tercakup oleh suite penuh.
- `flutter analyze` bersih dan seluruh 124 test lulus. Seluruh automated Gemini tetap fake/fixture-based.
- `git diff --check`, audit pola credential, dan audit file sensitif bersih. Seluruh dirty changes pengguna/phase sebelumnya dipertahankan.
- Android debug APK terbentuk di `build/app/outputs/flutter-apk/app-debug.apk`, ukuran 188.619.477 byte, SHA-256 `032e76cb34113f00471be87c662516815b99571e231f06343b7898c0a2836b1b`, dan integritas ZIP bersih.
- Wrapper Flutter tertahan pada finalisasi Gradle dan tidak memberi completion message; percobaan incremental juga tertahan lalu sesi crash. Setelah pemulihan tidak ada proses tersisa dan hanya folder report generated `android/build/` yang dibersihkan. Karena itu build tidak diklaim lulus bersih dan APK belum diuji instalasi.
- README serta architecture notes diperbarui dengan fitur, formula budget/reimburse, voice flow, kontrak Gemini offline, hasil command aktual, risiko, dan checklist manual.
- Belum tervalidasi: physical-device Android/iOS, recognizer dan permission OS, secure storage platform, live Gemini end-to-end, release signing/build, serta distribusi store.
- Gate Tahap 7 selesai secara konservatif berdasarkan quality gate aktual; tidak ada tahap lanjutan otomatis.
