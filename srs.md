=== FILENAME: srs.md ===

# Software Requirements Specification (SRS)
## KeySpace Mobile Application

| Atribut | Nilai |
|---|---|
| Nama produk | KeySpace |
| Jenis dokumen | Software Requirements Specification |
| Platform | Flutter/Dart untuk Android dan iOS |
| Pola arsitektur | Offline-first, local-only, tanpa backend milik developer |
| Versi dokumen | 1.0 |
| Status | Baseline untuk perencanaan dan implementasi |
| Bahasa utama aplikasi | Bahasa Indonesia |
| Tanggal baseline | 21 Juli 2026 |

---

## 1. Pendahuluan

### 1.1 Tujuan Dokumen

Dokumen ini mendefinisikan kebutuhan perangkat lunak KeySpace secara terukur dan dapat ditelusuri. KeySpace adalah aplikasi mobile pencatat kalori harian berbasis chatbot AI. Pengguna menuliskan makanan dalam bahasa natural, kemudian aplikasi memanggil Gemini API langsung dari perangkat untuk mengubah teks tersebut menjadi item makanan terstruktur, estimasi kalori, dan estimasi makronutrien.

SRS ini menjadi acuan bersama bagi Product Manager, UI/UX Designer, Flutter Engineer, QA Engineer, dan pihak lain yang terlibat dalam pengembangan, pengujian, serta penerimaan produk.

### 1.2 Ruang Lingkup Sistem

KeySpace mencakup kemampuan berikut:

1. Onboarding tanpa registrasi atau login.
2. Penyimpanan profil dasar, target kalori, log makanan, histori chat, preferensi, dan metadata API key secara lokal.
3. Penyimpanan rahasia API key Gemini di secure storage perangkat.
4. Pengelolaan banyak API key melalui **API Key Pool**.
5. Mekanisme **Sticky Sequential Failover**, yaitu mempertahankan key yang sedang aktif selama masih berhasil dan berpindah ke key berikutnya sesuai urutan prioritas ketika key tersebut gagal karena masalah yang bersifat key-specific.
6. Pencatatan makanan melalui chatbot AI dengan hasil yang dapat dikoreksi.
7. Pencatatan makanan manual ketika internet atau Gemini API tidak tersedia.
8. Dashboard harian, riwayat, grafik tren, dan ringkasan makronutrien.
9. Perhitungan estimasi kebutuhan kalori melalui BMR/TDEE sebagai bantuan, bukan diagnosis atau rekomendasi medis.
10. Reminder lokal berdasarkan progres terhadap target.
11. Quick add dari makanan favorit dan histori yang sering digunakan.
12. Export, backup, dan restore data lokal tanpa sinkronisasi cloud.

### 1.3 Sasaran Produk

Sistem harus mengurangi friksi pencatatan makanan dengan mengubah kalimat bebas menjadi log terstruktur dalam beberapa langkah singkat, sambil mempertahankan kontrol pengguna terhadap hasil dan privasi data.

### 1.4 Definisi dan Istilah

| Istilah | Definisi |
|---|---|
| Offline-first | Aplikasi tetap menyediakan fungsi inti berbasis data lokal ketika internet tidak tersedia. |
| Local-only | Data aplikasi disimpan pada perangkat dan tidak disinkronkan ke backend milik developer. |
| Gemini API | Layanan AI eksternal yang dipanggil langsung dari aplikasi menggunakan API key pengguna. |
| API Key Pool | Kumpulan satu atau lebih API key Gemini yang ditambahkan pengguna dan dikelola aplikasi. |
| Active Key | API key yang saat ini menjadi kandidat pertama untuk permintaan AI berikutnya. |
| Sticky Sequential Failover | Strategi menggunakan Active Key selama berhasil, lalu berpindah ke key berikutnya berdasarkan prioritas jika terjadi kegagalan key-specific. |
| Key-specific failure | Kegagalan yang kemungkinan dapat diselesaikan dengan key lain, misalnya key tidak valid, akses ditolak, atau kuota/rate limit key/project tercapai. |
| Request-specific failure | Kegagalan akibat payload, schema, input, atau kebijakan konten yang tidak akan terselesaikan hanya dengan mengganti key. |
| Cooldown | Masa tunggu sementara sebelum key yang terkena rate limit atau gangguan sementara boleh dicoba kembali. |
| Food Parsing Request | Permintaan ke Gemini untuk mengubah input makanan bebas menjadi struktur JSON. |
| Food Log | Rekaman satu aktivitas konsumsi yang dapat memuat satu atau beberapa Food Item. |
| Food Item | Item makanan/minuman individual beserta porsi, kalori, dan makronutrien. |
| BMR | Basal Metabolic Rate, estimasi energi dasar tubuh. |
| TDEE | Total Daily Energy Expenditure, estimasi kebutuhan energi harian setelah mempertimbangkan aktivitas. |
| Daily Target | Target kalori harian yang ditetapkan pengguna atau berasal dari estimasi TDEE yang telah dikonfirmasi. |
| Secure Storage | Penyimpanan terenkripsi berbasis fasilitas keamanan platform, misalnya Keychain pada iOS dan penyimpanan berbasis Keystore pada Android. |
| Manual Entry | Pencatatan makanan tanpa Gemini API. |
| Current Local Date | Tanggal berdasarkan zona waktu perangkat, disimpan dalam format `YYYY-MM-DD` untuk pengelompokan log harian. |

### 1.5 Referensi Internal

1. `prd.md` — tujuan produk, prioritas, user stories, dan roadmap.
2. `userflow.md` — alur interaksi pengguna dan diagram proses.
3. Pedoman desain visual dan design system KeySpace, jika telah tersedia.
4. Dokumentasi Gemini API, Drift, Riverpod, secure storage, dan local notifications yang berlaku pada saat implementasi.

---

## 2. Deskripsi Umum Sistem

### 2.1 Perspektif Produk

KeySpace adalah aplikasi mandiri pada perangkat pengguna. Tidak ada backend aplikasi, akun pengguna, autentikasi developer, sinkronisasi cloud, atau database remote.

Komponen eksternal hanya terdiri dari:

- Gemini API untuk parsing makanan berbasis AI.
- Sistem operasi Android/iOS untuk secure storage, file picker/share sheet, dan local notifications.

```text
Pengguna
   |
   v
Flutter UI
   |
   +--> Domain/Application Services
   |       |
   |       +--> Local Repositories --> Drift/SQLite
   |       +--> Secret Repository --> Secure Storage
   |       +--> Notification Scheduler --> Android/iOS Notification API
   |       +--> Gemini Gateway --> Internet --> Gemini API
   |
   +--> File Export/Import --> Penyimpanan yang dipilih pengguna
```

### 2.2 Prinsip Arsitektur

1. **Local data is the source of truth.**
2. Kegagalan internet tidak boleh menghalangi akses ke riwayat, dashboard lokal, pengaturan, atau pencatatan manual.
3. Permintaan AI tidak langsung menulis data final tanpa peluang koreksi; hasil harus masuk ke preview/draft terlebih dahulu.
4. API key tidak boleh disimpan dalam tabel database biasa.
5. UI tidak boleh memiliki logika failover secara langsung; logika tersebut berada pada service/domain layer.
6. Seluruh operasi tulis yang melibatkan beberapa tabel harus menggunakan transaksi database.
7. Fitur analitik atau telemetry ke server developer tidak tersedia secara default.
8. Penggunaan Gemini harus mengikuti kebijakan, kuota, dan ketentuan penyedia layanan. Banyak key tidak menjamin kuota tambahan, terutama jika key berbagi project atau billing scope yang sama.

### 2.3 Keputusan Teknis Utama

#### 2.3.1 Database Lokal: Drift di atas SQLite

**Rekomendasi:** menggunakan Drift.

**Alasan:**

- Data KeySpace bersifat relasional: Food Log memiliki banyak Food Item; Chat Message dapat mereferensikan Food Log; target memiliki histori; key memiliki usage events.
- Mendukung query agregasi untuk harian, mingguan, bulanan, total makro, tren, dan makanan yang sering digunakan.
- Menyediakan query reaktif sehingga dashboard dapat memperbarui diri setelah data berubah.
- Mendukung migrasi schema, transaksi, index, foreign key, dan type-safe query.
- Lebih cocok dibanding penyimpanan key-value murni untuk kebutuhan laporan dan agregasi.

Hive/Isar tetap memungkinkan, tetapi bukan pilihan baseline karena kebutuhan agregasi relasional dan migrasi schema lebih natural di SQLite/Drift.

#### 2.3.2 Penyimpanan Rahasia: `flutter_secure_storage`

Nilai API key disimpan melalui secure storage platform. Database Drift hanya menyimpan metadata dan `secure_ref` untuk menghubungkan metadata dengan secret.

Konsekuensi:

- Export data biasa tidak menyertakan API key.
- Pemulihan backup pada perangkat lain tidak otomatis memulihkan API key.
- Pengguna harus menambahkan key kembali setelah restore, kecuali di masa depan tersedia backup terenkripsi khusus yang dipilih secara eksplisit.

#### 2.3.3 State Management: Riverpod

**Rekomendasi:** Riverpod untuk:

- Dependency injection.
- State async untuk database dan API.
- Pemisahan UI dari repository/service.
- Pembatalan dan invalidasi state yang terkontrol.
- Testing provider tanpa ketergantungan kuat pada widget tree.

#### 2.3.4 Networking: Dio atau HTTP Client Setara

**Rekomendasi baseline:** Dio dengan konfigurasi timeout dan adapter yang dapat diuji.

Catatan penting: rotasi API key tidak ditempatkan sebagai interceptor generik. Failover harus dikelola oleh `GeminiFailoverService` agar kategori error, status key, usage event, retry, dan preservasi input dapat dikelola secara deterministik.

#### 2.3.5 Navigasi

Gunakan routing deklaratif, misalnya `go_router`, dengan rute utama:

- `/onboarding`
- `/home`
- `/chat`
- `/history`
- `/history/:date`
- `/food-log/:id/edit`
- `/insights`
- `/settings`
- `/settings/api-keys`
- `/settings/reminders`
- `/settings/profile`
- `/settings/data`

#### 2.3.6 Local Notifications

Gunakan plugin local notifications yang memanfaatkan API notifikasi Android/iOS. Reminder dijadwalkan secara lokal dan direkonsiliasi setiap kali:

- aplikasi dibuka/resume;
- Food Log ditambah, diubah, dipindahkan tanggalnya, atau dihapus;
- target atau jadwal reminder berubah;
- zona waktu perangkat berubah dan terdeteksi saat aplikasi aktif.

### 2.4 Arsitektur Logis

```text
Presentation Layer
- Screens, Widgets, Controllers/Notifiers
- Hanya menampilkan state dan mengirim intent pengguna

Application Layer
- Use cases: ParseFood, SaveFoodLog, UpdateTarget, RunFailover,
  ReconcileReminder, ExportData, RestoreData

Domain Layer
- Entities, Value Objects, Repository Contracts, Error Taxonomy
- Kebijakan key pool dan validasi nutrisi

Data Layer
- Drift DAOs
- Secure Storage adapter
- Gemini API client
- Notification adapter
- File export/import adapter
```

### 2.5 Struktur Folder Flutter yang Direkomendasikan

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── bootstrap.dart
│   ├── router.dart
│   └── theme/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── localization/
│   ├── logging/
│   ├── networking/
│   ├── security/
│   ├── time/
│   └── utils/
├── database/
│   ├── app_database.dart
│   ├── tables/
│   ├── daos/
│   ├── migrations/
│   └── converters/
├── features/
│   ├── onboarding/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── dashboard/
│   ├── food_chat/
│   ├── food_log/
│   ├── history/
│   ├── insights/
│   ├── api_key_pool/
│   ├── targets/
│   ├── reminders/
│   ├── favorites/
│   ├── data_management/
│   └── settings/
├── shared/
│   ├── widgets/
│   ├── models/
│   └── providers/
└── generated/
```

Setiap feature menggunakan struktur secukupnya. Proyek tidak perlu memaksakan seluruh lapisan pada fitur kecil, tetapi kontrak repository dan domain rule kritis harus tetap terpisah dari UI.

### 2.6 Mode Operasi Sistem

| Kondisi | Fungsi yang tersedia |
|---|---|
| Online dan minimal satu key sehat | Semua fungsi, termasuk chatbot AI. |
| Online tetapi semua key gagal | Semua fungsi lokal; input chat dipertahankan; tersedia manual entry dan pengelolaan key. |
| Offline | Dashboard, riwayat, edit, target, reminder, quick add, dan manual entry tetap tersedia. |
| Secure storage tidak dapat diakses | Data lokal non-rahasia tetap tersedia; fitur AI dinonaktifkan sampai akses secret pulih atau key ditambahkan ulang. |
| Database gagal dibuka | Tampilkan recovery state; jangan melakukan reset otomatis tanpa persetujuan pengguna. |

---

## 3. Functional Requirements

### 3.1 Onboarding dan Profil Awal

#### FR-01 — Menentukan Status Onboarding
Sistem harus memeriksa flag onboarding lokal saat startup.

**Acceptance criteria:**
- Instalasi baru diarahkan ke onboarding.
- Pengguna yang telah menyelesaikan onboarding diarahkan ke Home.
- Tidak ada request jaringan untuk menentukan status onboarding.

#### FR-02 — Onboarding Tanpa Login
Sistem harus menyediakan onboarding tanpa registrasi, email, password, nomor telepon, atau akun sosial.

#### FR-03 — Preferensi Dasar
Sistem harus meminta atau menyediakan default untuk:

- nama panggilan opsional;
- satuan berat: kilogram atau pound;
- satuan tinggi: sentimeter atau feet/inch;
- format waktu mengikuti perangkat;
- tema: sistem, terang, atau gelap.

#### FR-04 — Target Kalori Manual
Sistem harus memungkinkan pengguna memasukkan target kalori harian secara manual saat onboarding.

Validasi baseline:

- bilangan bulat;
- lebih besar dari 0;
- batas UI yang wajar harus dapat dikonfigurasi;
- nilai ekstrem harus memunculkan konfirmasi, bukan diblokir secara diam-diam.

#### FR-05 — Estimasi BMR/TDEE Opsional
Sistem harus menyediakan kalkulator opsional berdasarkan:

- berat;
- tinggi;
- usia;
- pilihan formula yang didukung;
- kategori jenis kelamin biologis yang dibutuhkan formula;
- tingkat aktivitas;
- goal: defisit, maintenance, atau surplus.

Baseline formula: Mifflin–St Jeor.

```text
Laki-laki:  BMR = 10W + 6.25H - 5A + 5
Perempuan:   BMR = 10W + 6.25H - 5A - 161

W = berat dalam kg
H = tinggi dalam cm
A = usia dalam tahun
TDEE = BMR × activity_factor
```

Hasil harus diberi label **estimasi** dan pengguna harus dapat melakukan override manual. Aplikasi tidak boleh menyatakan hasil sebagai saran medis individual.

#### FR-06 — Setup API Key Pertama
Onboarding harus menawarkan penambahan API key pertama.

- Pengguna dapat menambahkan sekarang atau melewati langkah.
- Jika dilewati, seluruh fitur lokal tetap tersedia.
- Saat pengguna pertama kali membuka chatbot tanpa key, aplikasi menampilkan call-to-action untuk menambahkan key.

#### FR-07 — Penyelesaian Onboarding
Sistem harus menyimpan seluruh konfigurasi onboarding dalam satu transaksi logis dan menandai onboarding selesai hanya setelah data minimum valid tersimpan.

---

### 3.2 Local Database dan Pengelolaan Data

#### FR-08 — Penyimpanan Lokal
Sistem harus menyimpan data operasional di database Drift/SQLite pada perangkat.

#### FR-09 — Transaksi Atomik
Penyimpanan hasil AI harus menggunakan transaksi yang mencakup:

1. Food Log;
2. seluruh Food Item;
3. Chat Message yang relevan;
4. pembaruan referensi antara chat dan log;
5. invalidasi cache/dashboard.

Jika satu langkah gagal, transaksi harus rollback.

#### FR-10 — Pengelompokan Berdasarkan Tanggal Lokal
Setiap Food Log harus memiliki:

- timestamp UTC;
- timezone offset saat dibuat;
- `local_date` dalam format `YYYY-MM-DD`.

Dashboard harian menggunakan `local_date`, bukan hasil konversi ulang timestamp historis dengan zona waktu terbaru.

#### FR-11 — Migrasi Schema
Setiap perubahan schema database harus memiliki version number dan strategi migrasi yang diuji.

#### FR-12 — Soft Delete dan Undo
Penghapusan Food Log harus mendukung undo dalam jangka pendek melalui `deleted_at`. Pembersihan permanen dapat dilakukan setelah masa undo atau ketika pengguna meminta penghapusan permanen.

#### FR-13 — Pencatatan Manual
Pengguna harus dapat menambahkan Food Log dan Food Item tanpa Gemini API.

---

### 3.3 API Key Pool dan Sticky Sequential Failover

#### FR-14 — Menambahkan Banyak API Key
Pengguna harus dapat menambahkan satu atau lebih API key Gemini.

Untuk setiap key, pengguna dapat mengatur:

- alias, misalnya “Key Utama”;
- status enabled/disabled;
- urutan prioritas;
- catatan opsional yang tidak sensitif.

#### FR-15 — Penyimpanan Key yang Aman
Sistem harus:

- menyimpan secret key di secure storage;
- menyimpan metadata di Drift;
- menampilkan key hanya dalam bentuk masked, misalnya `••••••A1B2`;
- tidak menulis secret ke application log, crash report, clipboard history, database, atau file export biasa;
- menghapus secret dari secure storage ketika metadata key dihapus.

#### FR-16 — Validasi Key
Saat key ditambahkan, sistem harus menawarkan validasi menggunakan request ringan terhadap model aktif.

Hasil validasi:

- `healthy`: request berhasil;
- `limited`: rate limit/quota tercapai;
- `invalid`: autentikasi/otorisasi gagal;
- `transient_error`: layanan atau jaringan bermasalah;
- `untested`: pengguna menyimpan tanpa tes.

Key tetap dapat disimpan ketika validasi gagal sementara. Key invalid harus ditandai jelas.

#### FR-17 — Urutan Prioritas
Key enabled harus memiliki `priority_order` unik. Pengguna dapat mengubah urutan melalui drag-and-drop atau kontrol naik/turun.

#### FR-18 — Strategi Pemilihan Key
Sistem harus menggunakan **Sticky Sequential Failover**:

1. Gunakan `active_key_id` jika key enabled dan eligible.
2. Jika tidak eligible, pilih key eligible berikutnya berdasarkan `priority_order`.
3. Jika request berhasil, key tersebut menjadi atau tetap menjadi Active Key.
4. Request berikutnya tetap menggunakan Active Key tersebut.
5. Jika key mengalami key-specific failure, tandai statusnya dan pindah ke key berikutnya.
6. Proses berhenti ketika satu key berhasil atau seluruh kandidat telah dicoba satu kali pada siklus request tersebut.

Strategi ini dipilih karena:

- sesuai ekspektasi “gunakan satu key sampai gagal, lalu pindah”;
- mudah dipahami pengguna;
- tidak menambah pergantian key pada setiap request;
- mempertahankan urutan prioritas yang dikontrol pengguna;
- memungkinkan recovery otomatis setelah cooldown.

#### FR-19 — Klasifikasi Error untuk Failover

| Kategori | Contoh status/error | Perlakuan |
|---|---|---|
| Invalid/Unauthorized | 401, key invalid | Tandai `invalid`, nonaktifkan dari pemilihan otomatis, lanjut ke key berikutnya. |
| Permission/Access | 403 yang menunjukkan key/project tidak memiliki akses | Tandai `invalid` atau `blocked`, lanjut ke key berikutnya. |
| Rate limit/Quota | 429, resource exhausted | Tandai `limited`, tetapkan cooldown, lanjut ke key berikutnya. |
| Server transient | 500, 502, 503, 504 | Retry satu kali pada key yang sama dengan backoff singkat; jika tetap gagal, tandai `transient_error` dan lanjut ke key berikutnya. |
| Timeout | connect/receive timeout | Retry satu kali bila jaringan tersedia; kemudian lanjut ke key berikutnya. |
| Network offline | tidak ada koneksi/route | Jangan menghabiskan seluruh pool; hentikan dan tampilkan status offline. |
| Invalid request | 400 malformed payload/schema | Jangan rotasi key; perbaiki request atau tampilkan error pemrosesan. |
| Safety/content blocked | response diblokir atau tidak memiliki kandidat valid | Jangan rotasi key; minta pengguna mengubah input atau gunakan manual entry. |
| Parse/schema mismatch | JSON tidak valid atau field tidak sesuai | Lakukan satu repair/retry terkontrol; jika tetap gagal, jangan menandai key invalid. |
| Secure storage failure | secret tidak dapat dibaca | Tandai key `secret_unavailable`, lanjut ke key berikutnya. |

Klasifikasi harus membaca error body terstruktur jika tersedia dan tidak hanya bergantung pada HTTP status.

#### FR-20 — Cooldown
Untuk rate limit atau error sementara:

- gunakan `Retry-After` atau informasi retry provider jika tersedia;
- jika tidak tersedia, gunakan cooldown default yang dapat dikonfigurasi;
- setelah `cooldown_until` terlewati, key kembali berstatus eligible saat request berikutnya;
- tidak diperlukan timer aktif terus-menerus di background.

#### FR-21 — Siklus Failover Tunggal
Dalam satu Food Parsing Request, key yang sama tidak boleh dicoba lebih dari jumlah retry yang ditentukan untuk kategori error. Sistem harus mencegah loop tak terbatas.

#### FR-22 — Seluruh Key Gagal
Jika semua key enabled tidak dapat digunakan atau tidak ada key:

1. pertahankan teks input dan draft chat secara lokal;
2. tampilkan peringatan: **“Semua API key tidak dapat digunakan.”**
3. jelaskan ringkas apakah key habis kuota, tidak valid, atau sedang error;
4. tampilkan tindakan:
   - **Tambah API Key Baru**;
   - **Kelola API Key**;
   - **Coba Lagi**;
   - **Catat Manual**;
5. setelah key baru berhasil ditambahkan, pengguna dapat melanjutkan request tanpa mengetik ulang input.

Ini merupakan perilaku wajib sesuai keputusan produk.

#### FR-23 — Status Kesehatan Key
Halaman API Key Pool harus menampilkan:

- alias;
- masked suffix;
- status;
- prioritas;
- waktu terakhir berhasil;
- waktu terakhir gagal;
- kategori error terakhir;
- cooldown sampai waktu tertentu;
- jumlah request berhasil/gagal dalam ringkasan lokal.

#### FR-24 — Usage Event Ringan
Sistem harus menyimpan event penggunaan tanpa prompt, response, atau secret:

- key id;
- timestamp;
- operation type;
- success/failure;
- error category;
- latency;
- token usage jika dikembalikan provider;
- model identifier;
- request correlation id lokal.

Event dapat dipangkas berdasarkan retention, misalnya 30–90 hari.

#### FR-25 — Enable, Disable, dan Hapus Key
Pengguna harus dapat:

- menonaktifkan key tanpa menghapus;
- mengaktifkan kembali;
- menghapus key setelah konfirmasi;
- menguji ulang key;
- memindahkan prioritas.

Jika Active Key dihapus/dinonaktifkan, sistem harus memilih key eligible berikutnya.

#### FR-26 — Kepatuhan Kuota Provider
UI harus memberikan informasi bahwa:

- beberapa API key dapat berbagi kuota jika berasal dari project/billing scope yang sama;
- failover meningkatkan ketersediaan, tetapi tidak menjamin kuota tambahan;
- pengguna bertanggung jawab atas key, billing, dan kepatuhan terhadap ketentuan Gemini API.

Aplikasi tidak boleh mengklaim dapat “menghilangkan” rate limit.

---

### 3.4 Chatbot Pencatat Kalori

#### FR-27 — Input Natural Language
Pengguna harus dapat mengetik teks makanan dalam Bahasa Indonesia, misalnya:

> “Aku makan nasi goreng satu porsi, telur, dan es teh manis.”

Input dapat memuat beberapa item dan porsi informal.

#### FR-28 — Validasi Input Chat
Sistem harus:

- menolak input kosong;
- menetapkan batas karakter yang aman;
- mempertahankan draft saat aplikasi berpindah halaman atau request gagal;
- mencegah pengiriman ganda selama request aktif, kecuali pengguna membatalkan.

#### FR-29 — Food Parsing Request
Sistem harus mengirim konteks minimum yang diperlukan:

- teks makanan;
- locale;
- satuan pengguna;
- tanggal/waktu makan yang dipilih;
- instruksi schema;
- disclaimer internal agar model tidak mengarang kepastian;
- opsional konteks koreksi pada retry.

Data profil sensitif tidak dikirim kecuali benar-benar diperlukan dan disetujui oleh requirement masa depan. Baseline parsing makanan tidak memerlukan nama, berat, tinggi, usia, atau goal pengguna.

#### FR-30 — Structured Output
Sistem harus meminta response JSON terstruktur dengan field yang didefinisikan pada Bagian 6.3.

#### FR-31 — Preview Hasil
Sebelum disimpan sebagai final, sistem harus menampilkan preview:

- daftar makanan;
- porsi dan satuan;
- kalori;
- protein;
- karbohidrat;
- lemak;
- tingkat keyakinan atau indikator estimasi;
- catatan asumsi;
- total.

Pengguna dapat menyimpan langsung, mengedit, menghapus item, atau meminta parsing ulang.

#### FR-32 — Auto-save yang Aman
Untuk mengurangi kehilangan data, hasil AI dapat disimpan sebagai draft segera setelah parsing berhasil. Status berubah menjadi `confirmed` setelah pengguna menekan Simpan atau sesuai pengaturan auto-save yang eksplisit.

Default produk: preview dahulu lalu konfirmasi.

#### FR-33 — Histori Chat Lokal
Sistem harus menyimpan Chat Session dan Chat Message per hari/sesi.

- Pesan user menyimpan teks input.
- Pesan assistant menyimpan ringkasan ramah pengguna dan referensi ke Food Log/draft.
- Raw response provider tidak perlu disimpan setelah data terstruktur tervalidasi, kecuali mode debug lokal yang diaktifkan secara eksplisit.

#### FR-34 — Koreksi Sebelum Simpan
Pengguna dapat mengubah seluruh field nutrisi sebelum konfirmasi.

#### FR-35 — Koreksi Setelah Simpan
Pengguna dapat membuka Food Log dari dashboard/history, mengedit item, dan menyimpan perubahan. Sistem harus menghitung ulang total harian dan reminder.

#### FR-36 — Re-parse
Pengguna dapat meminta AI memproses ulang teks dengan instruksi koreksi, misalnya “nasinya hanya setengah porsi”.

Hasil re-parse harus masuk preview dan tidak menimpa data final sebelum dikonfirmasi.

#### FR-37 — Timestamp dan Meal Type
Sistem harus mengizinkan pengguna memilih:

- tanggal dan waktu konsumsi;
- kategori: sarapan, makan siang, makan malam, snack, atau lainnya.

Default berasal dari waktu perangkat dan aturan waktu yang dapat dikonfigurasi.

#### FR-38 — Manual Fallback
Ketika AI gagal, tombol **Catat Manual** harus membawa input dan tanggal yang sudah dipilih ke form manual.

---

### 3.5 Food Log, Favorite, dan Quick Add

#### FR-39 — Daftar Log Harian
Sistem harus menampilkan Food Log hari terpilih dengan total kalori dan makro.

#### FR-40 — CRUD Food Log
Pengguna dapat membuat, melihat, mengedit, menduplikasi, memindahkan tanggal, dan menghapus Food Log. Operasi hapus mengikuti mekanisme soft delete dan undo pada FR-44a, bukan penghapusan langsung.

#### FR-41 — Favorite Food
Pengguna dapat menyimpan satu Food Item atau kombinasi Food Log sebagai favorite template.

#### FR-42 — Frequently Eaten
Sistem harus menghitung makanan yang sering dicatat secara lokal berdasarkan nama ternormalisasi, frekuensi, dan recency.

#### FR-43 — Quick Add
Pengguna dapat menambahkan favorite atau frequent item dengan satu atau dua langkah, lalu menyesuaikan porsi.

#### FR-44 — Duplicate Detection
Jika pengguna mencoba menyimpan hasil identik dalam interval sangat pendek, sistem harus memberi peringatan kemungkinan duplikasi, bukan menghapus otomatis.

#### FR-44a — Soft Delete dan Undo Food Log
Penghapusan Food Log (dan Food Item di dalamnya) harus:

1. menandai `deleted_at` alih-alih menghapus baris secara langsung;
2. mengecualikan record dengan `deleted_at` terisi dari seluruh agregasi dashboard/history/insight sejak saat itu ditandai;
3. menampilkan UI undo (snackbar/bar) dengan durasi window yang dikonfigurasi secara terpusat (lihat PRD §16 untuk keputusan durasi final);
4. mengembalikan record sepenuhnya (`deleted_at = null`) apabila pengguna menekan Undo sebelum window berakhir;
5. menjalankan hard delete permanen melalui proses pembersihan berkala setelah window undo berakhir, atau segera jika pengguna memilih opsi hapus permanen eksplisit di tempat lain (misalnya dari trash/riwayat penghapusan bila tersedia).

Field `deleted_at` yang sudah didefinisikan pada skema `food_logs` (lihat §5.2.4) menjadi mekanisme penyimpanan utama fitur ini; tidak diperlukan tabel tambahan untuk baseline.

---

### 3.6 Target Kalori dan Makronutrien

#### FR-45 — Mengubah Target Kapan Saja
Pengguna dapat mengubah Daily Target kapan saja.

#### FR-46 — Histori Target
Perubahan target harus menghasilkan record histori dengan `effective_from_date`. Dashboard historis menggunakan target yang berlaku pada tanggal tersebut.

#### FR-47 — Override Manual
Nilai target manual selalu memiliki prioritas dibanding hasil BMR/TDEE sampai pengguna memilih untuk menerapkan estimasi baru.

#### FR-48 — Target Makro Opsional
Pengguna dapat menetapkan gram atau persentase target protein, karbohidrat, dan lemak. Jika tidak ditetapkan, dashboard hanya menampilkan konsumsi aktual.

#### FR-49 — Peringatan Nonmedis
Sistem harus menampilkan bahwa estimasi kalori dan nutrisi bersifat perkiraan dan bukan pengganti konsultasi profesional.

---

### 3.7 Dashboard, Riwayat, dan Insights

#### FR-50 — Dashboard Hari Ini
Dashboard harus menampilkan:

- kalori dikonsumsi;
- target;
- sisa atau kelebihan;
- progress ring/bar;
- protein, karbohidrat, dan lemak;
- daftar makanan;
- tombol cepat chat dan manual entry.

#### FR-51 — Pilihan Tanggal
Pengguna dapat berpindah tanggal tanpa koneksi internet.

#### FR-52 — Ringkasan Mingguan
Sistem harus menampilkan tujuh hari dengan:

- total per hari;
- rata-rata;
- perbandingan target;
- hari di bawah, mendekati, atau di atas target;
- tren makro.

#### FR-53 — Ringkasan Bulanan
Sistem harus menampilkan agregasi per hari dan ringkasan bulanan.

#### FR-54 — Grafik Tren
Grafik harus mendukung minimal:

- kalori aktual vs target;
- protein, karbohidrat, lemak;
- rentang 7 hari, 30 hari, dan periode kustom yang wajar.

#### FR-55 — Empty State
Setiap dashboard/history tanpa data harus memiliki empty state dan tindakan relevan, bukan layar kosong.

#### FR-56 — Filter dan Search
Pengguna dapat mencari nama makanan serta memfilter tanggal atau meal type secara lokal.

---

### 3.8 Reminder Lokal

#### FR-57 — Konfigurasi Reminder
Pengguna dapat mengatur:

- aktif/nonaktif;
- jam reminder;
- threshold progress, default 70%;
- hari aktif;
- suara/getar sesuai dukungan OS;
- quiet hours opsional.

#### FR-58 — Reminder Bersyarat Tanpa Backend
Sistem harus menggunakan strategi schedule-and-cancel:

1. Jadwalkan candidate notification per tanggal untuk horizon terbatas, misalnya 30 hari.
2. Gunakan notification id deterministik berdasarkan tanggal.
3. Setiap perubahan log atau target menjalankan `ReconcileReminder`.
4. Jika progres telah mencapai threshold sebelum waktu reminder, batalkan notifikasi tanggal tersebut.
5. Jika progres belum mencapai threshold, notifikasi tetap terjadwal.
6. Saat aplikasi dibuka, pastikan horizon jadwal diperbarui.

Pendekatan ini menghindari kebutuhan backend dan mengurangi ketergantungan pada background task yang tidak dijamin sistem operasi.

#### FR-59 — Isi Notifikasi
Notifikasi harus bersifat suportif dan netral, misalnya:

> “Asupan hari ini masih di bawah target yang kamu tetapkan. Buka KeySpace untuk meninjau atau mencatat makanan.”

Notifikasi tidak boleh memerintahkan pengguna makan secara berlebihan atau membuat klaim medis.

#### FR-60 — Aksi Notifikasi
Menekan notifikasi membuka dashboard hari terkait dengan tombol **Catat Makanan**.

#### FR-61 — Permission
Aplikasi harus meminta izin notifikasi pada konteks yang relevan dan menjelaskan manfaat sebelum system prompt.

#### FR-62 — Batasan OS
Aplikasi harus menjelaskan bahwa waktu pengiriman dapat dipengaruhi pengaturan baterai, izin, Focus mode, dan kebijakan sistem operasi.

---

### 3.9 Export, Backup, Restore, dan Privasi

#### FR-63 — Export CSV
Pengguna dapat mengekspor Food Log dan Food Item ke CSV.

#### FR-64 — Backup JSON
Pengguna dapat membuat backup JSON versioned yang memuat data aplikasi non-rahasia.

#### FR-65 — API Key Dikecualikan
Backup/export default tidak boleh memuat secret API key. Metadata masked dapat disertakan tanpa `secure_ref` yang dapat digunakan ulang.

#### FR-66 — Restore
Restore harus:

- memvalidasi file;
- memeriksa schema version;
- menampilkan preview jumlah record;
- menawarkan mode merge atau replace;
- meminta konfirmasi sebelum replace;
- menggunakan transaksi;
- menghasilkan laporan item berhasil/gagal.

#### FR-67 — Share Sheet
File export harus diberikan ke mekanisme file picker/share sheet platform. Aplikasi tidak mengunggah file secara otomatis.

#### FR-68 — Hapus Semua Data
Pengguna dapat menghapus semua data lokal setelah konfirmasi berlapis. Proses harus menghapus database, secure storage KeySpace, file cache, dan pending notifications.

---

### 3.10 Pengaturan, Tema, dan Accessibility

#### FR-69 — Tema
Sistem mendukung tema sistem, terang, dan gelap.

#### FR-70 — Satuan
Sistem mendukung input/tampilan berat dan tinggi sesuai preferensi, dengan penyimpanan nilai canonical dalam metrik.

#### FR-71 — Accessibility
Elemen inti harus mendukung:

- screen reader label;
- dynamic text;
- contrast yang layak;
- target sentuh minimum;
- informasi tidak bergantung pada warna saja.

#### FR-72 — Informasi Privasi
Halaman Privasi harus menyatakan:

- tidak ada backend developer;
- data tersimpan lokal;
- teks makanan dikirim ke Gemini hanya ketika pengguna menggunakan chatbot;
- request memakai API key milik pengguna;
- provider dapat memproses data sesuai ketentuannya;
- export dan backup dikontrol pengguna.

#### FR-72a — App Lock (PIN/Biometric)
Sistem harus menyediakan opsi kunci aplikasi:

1. pengguna dapat mengaktifkan/menonaktifkan App Lock dan mengatur PIN numerik minimum panjang yang wajar (misalnya 6 digit);
2. jika perangkat mendukung biometrik (fingerprint/Face ID) dan pengguna mengaktifkannya, biometrik menjadi jalur utama dengan PIN sebagai fallback wajib;
3. mode pemicu lock dapat dipilih: setiap kali aplikasi dibuka/resume dari background, atau setelah periode idle tertentu;
4. PIN disimpan sebagai hash tersalting melalui secure storage yang sama dengan API key, tidak pernah disimpan plaintext maupun di tabel database biasa;
5. gagal autentikasi berkali-kali tidak menghapus data aplikasi secara otomatis pada baseline; sistem hanya memperlambat percobaan berikutnya (throttling) untuk mengurangi brute force sederhana;
6. layar lock harus tetap dapat diakses screen reader dan tidak menampilkan potongan data Food Log di belakangnya (background content harus disamarkan) saat aplikasi berpindah ke background jika App Lock aktif;
7. App Lock tidak menggantikan atau memengaruhi enkripsi database maupun secure storage API key; keduanya berjalan independen.

#### FR-73 — Diagnostics Lokal
Sistem dapat menyediakan halaman diagnostics lokal yang menampilkan:

- versi app;
- versi schema;
- jumlah data;
- status secure storage;
- status pool;
- log error yang telah disanitasi.

Tidak boleh ada secret atau isi chat lengkap dalam diagnostics default.

---

### 3.11 Home Screen Widget (Fase 3)

#### FR-74 — Ringkasan Kalori pada Widget
Widget home screen harus menampilkan kalori terkonsumsi vs Daily Target untuk `Current Local Date`, dibaca langsung dari database lokal tanpa memanggil Gemini API.

#### FR-75 — Quick Add dari Widget
Widget harus menyediakan tombol yang membuka aplikasi langsung ke layar Chat atau Manual Entry untuk mempercepat pencatatan, tanpa melakukan parsing AI di dalam proses widget itu sendiri.

#### FR-76 — Widget Tetap Berfungsi Offline
Widget harus tetap menampilkan data terakhir yang tersimpan lokal ketika perangkat offline, dan diperbarui kembali begitu ada perubahan Food Log atau target.

#### FR-77 — Widget Menghormati App Lock
Jika App Lock (FR-72a) aktif, widget tidak boleh menampilkan detail Food Log individual di luar aplikasi; ringkasan angka kalori pada widget dianggap informasi non-sensitif minimum dan tetap boleh tampil, tetapi menekan widget untuk membuka detail harus tetap melalui layar App Lock.

---

## 4. Non-Functional Requirements

### 4.1 Performance

#### NFR-01 — Startup
Cold start target kurang dari 2,5 detik pada perangkat kelas menengah yang didukung, tidak termasuk keterlambatan sistem operasi.

#### NFR-02 — Query Dashboard
Query dashboard harian dan mingguan harus selesai dalam target 300 ms untuk dataset hingga 10.000 Food Item pada perangkat target.

#### NFR-03 — Operasi Tulis
Penyimpanan atau edit Food Log lokal harus selesai dalam target 150 ms, tidak termasuk request AI.

#### NFR-04 — Respons UI
UI tidak boleh freeze selama request jaringan, export besar, restore, atau migrasi. Operasi CPU berat harus dipindahkan dari UI isolate bila diperlukan.

#### NFR-05 — Pagination
Riwayat panjang dan usage event harus menggunakan pagination atau lazy loading.

### 4.2 Security dan Privasi

#### NFR-06 — Secret at Rest
API key harus disimpan menggunakan secure storage platform.

#### NFR-07 — Secret in Transit
Request Gemini harus menggunakan HTTPS/TLS melalui endpoint resmi.

#### NFR-08 — Sanitasi Log
Logging harus memiliki redaction untuk:

- query parameter `key`;
- authorization header;
- request URL lengkap;
- secret;
- raw response yang mungkin memuat input pengguna.

#### NFR-09 — Clipboard
Aplikasi tidak boleh menyalin key otomatis. Bila pengguna memilih paste/copy, UI harus memberi peringatan dan membersihkan field dari widget state setelah selesai.

#### NFR-10 — Threat Model
Dokumentasi harus mengakui bahwa aplikasi mobile tidak dapat menjamin kerahasiaan key pada perangkat yang telah di-root/jailbreak, di-debug, atau dikompromikan.

#### NFR-11 — Data Minimization
Hanya teks dan konteks minimum untuk parsing makanan yang dikirim ke Gemini. Profil BMR/TDEE tidak dikirim pada baseline.

#### NFR-12 — No Developer Telemetry
Tidak ada analytics, crash upload, atau remote logging ke server developer pada baseline. Jika ditambahkan di masa depan, harus opt-in dan didokumentasikan ulang.

### 4.3 Reliability dan Offline-first

#### NFR-13 — Offline Availability
Seluruh operasi lokal harus tetap tersedia tanpa internet.

#### NFR-14 — Input Preservation
Draft input tidak boleh hilang akibat timeout, failover, perpindahan layar, atau app pause normal.

#### NFR-15 — Idempotency Lokal
Penyimpanan hasil AI harus menggunakan local request id agar retry UI tidak menghasilkan duplikasi tanpa peringatan.

#### NFR-16 — Crash Recovery
Draft parsing yang sudah diterima tetapi belum dikonfirmasi harus dapat dipulihkan setelah app restart.

#### NFR-17 — Database Integrity
Foreign key, transaksi, migration test, dan backup sebelum destructive migration harus digunakan.

#### NFR-18 — Failover Bound
Satu request tidak boleh melakukan percobaan tak terbatas. Batas maksimum adalah jumlah key eligible dalam siklus ditambah retry sementara yang telah ditentukan.

### 4.4 Usability

#### NFR-19 — Zero Friction
Pengguna dapat mencapai Home tanpa akun dan dapat melakukan manual entry meskipun melewati API setup.

#### NFR-20 — Transparansi Estimasi
Setiap hasil AI harus diberi label estimasi dan dapat diedit.

#### NFR-21 — Pesan Error
Pesan error harus menjelaskan tindakan berikutnya dan tidak hanya menampilkan kode teknis.

#### NFR-22 — Waktu Pencatatan
Target UX: pengguna dapat mencatat input sederhana melalui chat dalam median kurang dari 30 detik pada koneksi normal, termasuk review singkat.

### 4.5 Maintainability dan Testability

#### NFR-23 — Separation of Concerns
UI, domain rule, database, networking, dan platform adapter harus terpisah.

#### NFR-24 — Automated Tests
Minimal tersedia:

- unit test key selection dan error classification;
- unit test kalkulasi target;
- DAO test dan migration test;
- repository test;
- widget test alur kritis;
- integration test onboarding, chat sukses, failover, all-keys-failed, edit, dan restore.

#### NFR-25 — Configurable Provider Layer
Model identifier, endpoint version, timeout, cooldown default, dan schema version harus dikonfigurasi terpusat agar perubahan provider tidak tersebar.

#### NFR-26 — Backward Compatibility
Backup version lama yang masih didukung harus dapat dimigrasikan atau ditolak dengan pesan yang jelas.

---

## 5. Model Data dan Skema Database Lokal

### 5.1 Prinsip Penyimpanan

- ID menggunakan UUID string atau integer lokal yang konsisten; baseline disarankan UUID agar aman untuk merge backup.
- Timestamp disimpan UTC dalam integer epoch milliseconds atau tipe `DateTime` Drift.
- Tanggal lokal disimpan eksplisit sebagai `YYYY-MM-DD`.
- Nilai nutrisi menggunakan `REAL` dan dinormalisasi ke unit:
  - energi: kcal;
  - protein/karbohidrat/lemak/fiber: gram;
  - sodium: milligram.
- Secret tidak disimpan di SQLite.

### 5.2 Entities

#### 5.2.1 `user_profile`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK, singleton | ID profil lokal. |
| display_name | TEXT | nullable | Nama panggilan. |
| birth_year_or_age | INTEGER | nullable | Data estimasi BMR. |
| sex_for_formula | TEXT | nullable | Nilai yang diperlukan formula. |
| height_cm | REAL | nullable | Nilai canonical. |
| weight_kg | REAL | nullable | Nilai canonical. |
| activity_level | TEXT | nullable | Kategori aktivitas. |
| goal_type | TEXT | nullable | deficit/maintenance/surplus. |
| goal_adjustment_kcal | INTEGER | nullable | Penyesuaian dari TDEE. |
| created_at | DATETIME | not null | Waktu dibuat. |
| updated_at | DATETIME | not null | Waktu terakhir diubah. |

#### 5.2.2 `app_settings`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | INTEGER | PK, singleton=1 | Record tunggal. |
| onboarding_completed | BOOLEAN | not null | Status onboarding. |
| weight_unit | TEXT | not null | kg/lb. |
| height_unit | TEXT | not null | cm/ft_in. |
| theme_mode | TEXT | not null | system/light/dark. |
| locale | TEXT | not null | Default `id`. |
| active_key_id | TEXT | nullable, FK metadata | Key aktif. |
| gemini_model | TEXT | not null | Model aktif dari konfigurasi. |
| preview_before_save | BOOLEAN | not null | Default true. |
| created_at | DATETIME | not null | Audit. |
| updated_at | DATETIME | not null | Audit. |

#### 5.2.3 `daily_targets`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID histori target. |
| effective_from_date | TEXT | indexed, not null | Tanggal mulai berlaku. |
| calorie_target | INTEGER | not null | Target kcal. |
| protein_target_g | REAL | nullable | Target protein. |
| carbs_target_g | REAL | nullable | Target karbohidrat. |
| fat_target_g | REAL | nullable | Target lemak. |
| source | TEXT | not null | manual/tdee. |
| formula_snapshot_json | TEXT | nullable | Input dan hasil kalkulasi saat diterapkan. |
| created_at | DATETIME | not null | Audit. |

Aturan: target untuk suatu tanggal adalah record terbaru dengan `effective_from_date <= selected_date`.

#### 5.2.4 `food_logs`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID log. |
| local_request_id | TEXT | unique, nullable | Pencegah duplikasi retry. |
| local_date | TEXT | indexed, not null | Tanggal lokal. |
| consumed_at_utc | DATETIME | indexed, not null | Waktu konsumsi UTC. |
| timezone_offset_minutes | INTEGER | not null | Offset saat pencatatan. |
| meal_type | TEXT | indexed, not null | breakfast/lunch/dinner/snack/other. |
| source | TEXT | not null | ai/manual/quick_add/duplicate. |
| status | TEXT | indexed, not null | draft/confirmed. |
| original_user_text | TEXT | nullable | Input awal. |
| notes | TEXT | nullable | Catatan pengguna. |
| total_calories_kcal | REAL | not null | Denormalized total. |
| total_protein_g | REAL | nullable | Denormalized total. |
| total_carbs_g | REAL | nullable | Denormalized total. |
| total_fat_g | REAL | nullable | Denormalized total. |
| ai_model | TEXT | nullable | Model parsing. |
| ai_key_metadata_id | TEXT | nullable, FK | Key metadata yang berhasil. |
| created_at | DATETIME | not null | Audit. |
| updated_at | DATETIME | not null | Audit. |
| deleted_at | DATETIME | nullable, indexed | Soft delete. |

#### 5.2.5 `food_items`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID item. |
| food_log_id | TEXT | FK, indexed, cascade | Parent. |
| display_name | TEXT | not null | Nama tampilan. |
| normalized_name | TEXT | indexed, nullable | Nama untuk search/frequency. |
| quantity | REAL | nullable | Jumlah. |
| unit | TEXT | nullable | porsi, gram, gelas, dsb. |
| portion_text | TEXT | nullable | Representasi natural. |
| calories_kcal | REAL | not null | Estimasi/aktual input user. |
| protein_g | REAL | nullable | Protein. |
| carbs_g | REAL | nullable | Karbohidrat. |
| fat_g | REAL | nullable | Lemak. |
| fiber_g | REAL | nullable | Serat. |
| sodium_mg | REAL | nullable | Sodium. |
| confidence | REAL | nullable | 0–1 jika tersedia. |
| assumption_note | TEXT | nullable | Asumsi porsi/resep. |
| sort_order | INTEGER | not null | Urutan. |
| created_at | DATETIME | not null | Audit. |
| updated_at | DATETIME | not null | Audit. |

#### 5.2.6 `chat_sessions`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID sesi. |
| local_date | TEXT | indexed, not null | Pengelompokan sesi. |
| title | TEXT | nullable | Judul otomatis/lokal. |
| created_at | DATETIME | not null | Audit. |
| updated_at | DATETIME | not null | Audit. |

#### 5.2.7 `chat_messages`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID pesan. |
| session_id | TEXT | FK, indexed, cascade | Parent sesi. |
| role | TEXT | not null | user/assistant/system_local. |
| content_text | TEXT | not null | Teks yang ditampilkan. |
| status | TEXT | indexed, not null | pending/sent/failed/complete. |
| food_log_id | TEXT | nullable, FK | Referensi hasil. |
| local_request_id | TEXT | nullable, indexed | Korelasi request. |
| error_category | TEXT | nullable | Kategori gagal tersanitasi. |
| created_at | DATETIME | not null | Audit. |

#### 5.2.8 `api_key_metadata`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID metadata. |
| alias | TEXT | not null | Nama key. |
| secure_ref | TEXT | unique, not null | Referensi secret storage. |
| masked_suffix | TEXT | not null | 4 karakter akhir atau representasi aman. |
| priority_order | INTEGER | unique, indexed | Urutan. |
| is_enabled | BOOLEAN | indexed, not null | Dapat dipilih/tidak. |
| health_status | TEXT | indexed, not null | untested/healthy/limited/invalid/blocked/transient_error/secret_unavailable. |
| cooldown_until | DATETIME | nullable, indexed | Waktu eligible kembali. |
| last_success_at | DATETIME | nullable | Status. |
| last_failure_at | DATETIME | nullable | Status. |
| last_error_category | TEXT | nullable | Tidak menyimpan error body sensitif. |
| success_count | INTEGER | not null default 0 | Ringkasan lokal. |
| failure_count | INTEGER | not null default 0 | Ringkasan lokal. |
| created_at | DATETIME | not null | Audit. |
| updated_at | DATETIME | not null | Audit. |

#### 5.2.9 `api_key_usage_events`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID event. |
| api_key_metadata_id | TEXT | FK, indexed, cascade | Key terkait. |
| local_request_id | TEXT | indexed, not null | Korelasi. |
| operation | TEXT | not null | validate/parse/reparse. |
| outcome | TEXT | indexed, not null | success/failure. |
| error_category | TEXT | nullable | Kategori. |
| http_status | INTEGER | nullable | Status. |
| latency_ms | INTEGER | nullable | Latensi. |
| prompt_tokens | INTEGER | nullable | Jika provider mengembalikan. |
| output_tokens | INTEGER | nullable | Jika provider mengembalikan. |
| model_id | TEXT | nullable | Model. |
| created_at | DATETIME | indexed, not null | Audit. |

#### 5.2.10 `favorite_templates`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID favorite. |
| name | TEXT | indexed, not null | Nama template. |
| template_json | TEXT | not null | Snapshot item yang tervalidasi. |
| use_count | INTEGER | not null default 0 | Ranking. |
| last_used_at | DATETIME | nullable | Ranking. |
| created_at | DATETIME | not null | Audit. |
| updated_at | DATETIME | not null | Audit. |

#### 5.2.11 `reminder_settings`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | INTEGER | PK, singleton=1 | Record tunggal. |
| is_enabled | BOOLEAN | not null | Status. |
| reminder_time_local | TEXT | not null | `HH:mm`. |
| threshold_percent | INTEGER | not null | Default 70. |
| active_weekdays_mask | INTEGER | not null | Bitmask hari. |
| quiet_hours_start | TEXT | nullable | Opsional. |
| quiet_hours_end | TEXT | nullable | Opsional. |
| permission_status | TEXT | not null | unknown/granted/denied. |
| updated_at | DATETIME | not null | Audit. |

#### 5.2.12 `notification_events`

| Field | Type | Constraint | Deskripsi |
|---|---|---|---|
| id | TEXT | PK | ID event. |
| local_date | TEXT | indexed, not null | Tanggal target. |
| platform_notification_id | INTEGER | unique, not null | ID deterministik. |
| scheduled_for | DATETIME | not null | Jadwal lokal/zonasi. |
| status | TEXT | indexed, not null | scheduled/cancelled/delivered_assumed/opened. |
| opened_at | DATETIME | nullable | Interaksi. |
| updated_at | DATETIME | not null | Audit. |

### 5.3 Relasi

```text
user_profile                    (singleton)
app_settings                    (singleton)
reminder_settings               (singleton)

daily_targets                   (history by effective date)

food_logs       1 -------- N    food_items
food_logs       0..1 ----- N    chat_messages
chat_sessions   1 -------- N    chat_messages
api_key_metadata 1 ------- N    api_key_usage_events
api_key_metadata 0..1 ----- N   food_logs
```

### 5.4 Index Wajib

1. `food_logs(local_date, deleted_at, status)`
2. `food_logs(consumed_at_utc)`
3. `food_items(food_log_id, sort_order)`
4. `food_items(normalized_name)`
5. `chat_messages(session_id, created_at)`
6. `api_key_metadata(is_enabled, priority_order, health_status, cooldown_until)`
7. `api_key_usage_events(api_key_metadata_id, created_at)`
8. `daily_targets(effective_from_date)`
9. `notification_events(local_date, status)`

---

## 6. External Interface Requirements

### 6.1 Gemini API Interface

Endpoint harus dikonfigurasi terpusat dan mengikuti versi API yang didukung saat implementasi. Pola umum:

```http
POST /<api-version>/models/<model-id>:generateContent
Content-Type: application/json
API key: dikirim menggunakan mekanisme resmi provider
```

Tidak boleh meng-hardcode key dalam source code, asset, remote config, atau repository.

### 6.2 Request Concept

Contoh konseptual:

```json
{
  "systemInstruction": {
    "parts": [
      {
        "text": "Ekstrak makanan dan estimasi nutrisi. Kembalikan JSON sesuai schema. Tandai asumsi dan jangan menyatakan estimasi sebagai nilai pasti."
      }
    ]
  },
  "contents": [
    {
      "role": "user",
      "parts": [
        {
          "text": "Locale=id-ID; unit=metric; consumed_at=2026-07-21T12:30:00+07:00; input=aku makan nasi goreng sama es teh"
        }
      ]
    }
  ],
  "generationConfig": {
    "responseMimeType": "application/json",
    "responseSchema": {
      "type": "object",
      "required": ["items", "summary"],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["name", "calories_kcal"],
            "properties": {
              "name": {"type": "string"},
              "quantity": {"type": ["number", "null"]},
              "unit": {"type": ["string", "null"]},
              "portion_text": {"type": ["string", "null"]},
              "calories_kcal": {"type": "number"},
              "protein_g": {"type": ["number", "null"]},
              "carbs_g": {"type": ["number", "null"]},
              "fat_g": {"type": ["number", "null"]},
              "fiber_g": {"type": ["number", "null"]},
              "sodium_mg": {"type": ["number", "null"]},
              "confidence": {"type": ["number", "null"]},
              "assumption_note": {"type": ["string", "null"]}
            }
          }
        },
        "summary": {
          "type": "object",
          "required": ["total_calories_kcal"],
          "properties": {
            "total_calories_kcal": {"type": "number"},
            "total_protein_g": {"type": ["number", "null"]},
            "total_carbs_g": {"type": ["number", "null"]},
            "total_fat_g": {"type": ["number", "null"]},
            "needs_user_review": {"type": "boolean"},
            "general_note": {"type": ["string", "null"]}
          }
        }
      }
    }
  }
}
```

Catatan: dukungan detail JSON Schema dapat berubah menurut endpoint/model. Implementasi harus mengikuti subset schema resmi yang berlaku dan memiliki parser defensif.

### 6.3 Response Domain yang Diharapkan

```json
{
  "items": [
    {
      "name": "Nasi goreng",
      "quantity": 1,
      "unit": "porsi",
      "portion_text": "1 porsi standar",
      "calories_kcal": 520,
      "protein_g": 14,
      "carbs_g": 72,
      "fat_g": 19,
      "fiber_g": 4,
      "sodium_mg": 900,
      "confidence": 0.62,
      "assumption_note": "Porsi dan minyak diasumsikan ukuran warung standar."
    },
    {
      "name": "Es teh manis",
      "quantity": 1,
      "unit": "gelas",
      "portion_text": "1 gelas",
      "calories_kcal": 120,
      "protein_g": 0,
      "carbs_g": 30,
      "fat_g": 0,
      "fiber_g": 0,
      "sodium_mg": 5,
      "confidence": 0.70,
      "assumption_note": "Gula diasumsikan sekitar 2–3 sendok teh."
    }
  ],
  "summary": {
    "total_calories_kcal": 640,
    "total_protein_g": 14,
    "total_carbs_g": 102,
    "total_fat_g": 19,
    "needs_user_review": true,
    "general_note": "Nilai merupakan estimasi dan dapat berbeda berdasarkan resep serta ukuran porsi."
  }
}
```

### 6.4 Validasi Response

Parser harus:

1. memastikan top-level object valid;
2. memastikan `items` tidak kosong;
3. menolak nilai NaN/Infinity;
4. memastikan kalori tidak negatif;
5. membatasi nilai ekstrem dan memunculkan review flag;
6. menghitung ulang total dari item;
7. mencatat perbedaan antara total provider dan total lokal;
8. membersihkan string;
9. tidak mengeksekusi konten sebagai kode;
10. menghasilkan domain error yang dapat ditampilkan.

### 6.5 Timeout dan Retry

Baseline konfigurasi:

- connect timeout: configurable;
- receive timeout: configurable;
- satu retry untuk error transient dengan exponential backoff dan jitter;
- tidak retry otomatis untuk invalid request, invalid key, atau safety block;
- failover dilakukan setelah retry transient key tersebut habis;
- user dapat membatalkan request.

Nilai numerik final harus ditentukan melalui pengujian jaringan nyata dan dapat disesuaikan tanpa mengubah seluruh codebase.

### 6.6 Pseudocode Failover

```text
function parseFood(input):
    requestId = createLocalRequestId()
    savePendingChatMessage(input, requestId)

    if offline:
        markMessageFailed(OFFLINE)
        return OfflineFailure(inputPreserved=true)

    candidates = keyPool.getOrderedCandidates(startFrom=activeKeyId)

    if candidates.isEmpty:
        return AllKeysFailed(showAddKey=true)

    attempted = []

    for key in candidates:
        if not key.isEligible(now):
            continue

        attempted.add(key.id)

        secret = secureStore.read(key.secureRef)
        if secret is unavailable:
            keyPool.markSecretUnavailable(key)
            continue

        result = callGeminiWithTransientRetry(secret, input)

        if result.success:
            keyPool.markHealthyAndActive(key)
            saveUsageSuccess(key, requestId)
            return validateAndCreateDraft(result)

        category = classify(result.error)
        saveUsageFailure(key, requestId, category)

        if category is INVALID_KEY or PERMISSION:
            keyPool.markInvalidOrBlocked(key)
            continue

        if category is RATE_LIMIT:
            keyPool.markLimited(key, cooldown)
            continue

        if category is TRANSIENT_SERVER or TIMEOUT:
            keyPool.markTransient(key, cooldown)
            continue

        if category is REQUEST_INVALID:
            return RequestFailure(inputPreserved=true)

        if category is SAFETY_BLOCK:
            return ContentNeedsRevision(inputPreserved=true)

        if category is OFFLINE:
            return OfflineFailure(inputPreserved=true)

    return AllKeysFailed(
        attemptedKeys=attempted,
        inputPreserved=true,
        actions=[ADD_KEY, MANAGE_KEYS, RETRY, MANUAL_ENTRY]
    )
```

### 6.7 Interface Sistem Operasi

#### Secure Storage
Operasi minimum:

- create/write secret;
- read secret;
- delete secret;
- availability/error mapping;
- migration alias bila format reference berubah.

#### Notifications
Operasi minimum:

- request permission;
- schedule zoned notification;
- cancel notification by id;
- inspect launch payload;
- reschedule horizon.

#### File System
Operasi minimum:

- create temporary export;
- invoke save/share flow;
- read selected backup;
- delete temporary files.

---

## 7. Constraints dan Assumptions

### 7.1 Constraints

1. Tidak ada backend/server milik developer.
2. Tidak ada autentikasi atau akun pengguna.
3. Tidak ada sinkronisasi cloud atau multi-device.
4. Hanya Gemini API yang memerlukan internet pada baseline.
5. API key berasal dari dan dikelola pengguna.
6. Aplikasi tidak dapat mengontrol perubahan harga, model, kuota, atau kebijakan Gemini.
7. Beberapa key dapat memiliki scope kuota yang sama; perpindahan key tidak selalu memulihkan layanan.
8. Local notifications dipengaruhi kebijakan OS.
9. Data dapat hilang bila perangkat rusak, aplikasi dihapus, atau storage dibersihkan sebelum pengguna membuat backup.
10. Secure storage meningkatkan keamanan at rest tetapi tidak menjamin perlindungan pada perangkat yang dikompromikan.
11. Estimasi nutrisi dari AI tidak selalu akurat dan harus dapat dikoreksi.
12. App Store/Play Store dapat memiliki ketentuan tambahan terkait aplikasi health, privacy disclosure, dan user-provided API key.

### 7.2 Assumptions

1. Pengguna memiliki perangkat Android/iOS yang didukung.
2. Pengguna mampu memperoleh API key Gemini sendiri jika ingin menggunakan AI.
3. Pengguna memahami bahwa penggunaan key dapat menimbulkan penggunaan kuota atau biaya.
4. Locale utama adalah Indonesia, tetapi arsitektur mendukung localization.
5. Waktu dan zona waktu perangkat cukup benar.
6. Dataset lokal tipikal berada di bawah puluhan ribu item, tetapi query harus tetap terindex.
7. Pengguna menerima bahwa BMR/TDEE dan nutrisi adalah estimasi.
8. Backup dipicu manual oleh pengguna pada baseline.

---

## 8. Matriks Traceability Ringkas

| Capability | Functional Requirements | PRD Feature |
|---|---|---|
| Onboarding tanpa login | FR-01–FR-07 | F-01 |
| Database lokal/offline | FR-08–FR-13 | F-02 |
| API Key Pool | FR-14–FR-26 | F-03 |
| Chatbot AI | FR-27–FR-38 | F-04 |
| Food Log dan quick add | FR-39–FR-44 | F-05, F-09 |
| Target dan BMR/TDEE | FR-45–FR-49 | F-06 |
| Dashboard dan insights | FR-50–FR-56 | F-07 |
| Reminder | FR-57–FR-62 | F-08 |
| Backup/export | FR-63–FR-68 | F-10 |
| Settings/accessibility/privacy | FR-69–FR-73, FR-72a | F-11, F-23 |
| Soft delete & undo Food Log | FR-44a | F-21 |
| Home screen widget | FR-74–FR-77 | F-22 |

---

## 9. Kriteria Penerimaan Sistem Tingkat Tinggi

Sistem dinyatakan memenuhi baseline MVP apabila:

1. Instalasi baru dapat menyelesaikan onboarding tanpa login.
2. Pengguna dapat mencatat makanan manual sepenuhnya offline.
3. Pengguna dapat menambahkan minimal tiga API key, mengatur urutan, dan melihat status masked.
4. Pengujian integrasi membuktikan key A gagal lalu request berhasil otomatis dengan key B tanpa kehilangan input.
5. Ketika semua key gagal, pengguna mendapat peringatan dan tombol **Tambah API Key Baru**, serta dapat melanjutkan input setelah key baru tersedia.
6. Response AI tervalidasi dan ditampilkan dalam preview editable.
7. Log tersimpan lokal, muncul di dashboard, dan dapat diedit/dihapus.
8. Dashboard harian/mingguan/bulanan berfungsi tanpa internet.
9. Reminder lokal dapat dijadwalkan dan dibatalkan ketika threshold tercapai.
10. Export/backup tidak mengandung secret API key.
11. Penghapusan semua data juga menghapus secure storage dan notifikasi.
12. Tidak ada request ke server developer selama pengujian jaringan.
13. Menghapus Food Log menampilkan opsi undo dan dashboard langsung menyesuaikan; item tidak lagi dapat dipulihkan setelah window undo berakhir.
14. Ketika App Lock diaktifkan, aplikasi meminta autentikasi (PIN/biometrik) sebelum konten Food Log dapat diakses, dan pengguna tetap dapat menonaktifkannya kapan saja dari Pengaturan.
15. Widget home screen (bila diimplementasikan pada Fase 3) menampilkan angka kalori terakhir yang valid secara lokal tanpa memerlukan koneksi internet.

---

## 10. Catatan Implementasi dan Validasi Berkala

Dokumentasi provider dan package dapat berubah. Sebelum setiap release, tim harus memverifikasi:

- format endpoint dan autentikasi Gemini;
- model yang masih tersedia;
- subset structured output/JSON Schema;
- kategori error dan field retry;
- rate limit dan scope kuota;
- kebijakan penggunaan API key pada aplikasi client;
- perubahan Android/iOS terkait secure storage dan notifications;
- kompatibilitas versi Flutter, Drift, Riverpod, dan plugin platform.

Keputusan produk yang tidak berubah adalah: **ketika satu API key mengalami kegagalan key-specific, KeySpace berpindah ke key berikutnya; ketika seluruh key gagal, KeySpace memperingatkan pengguna dan mengarahkan pengguna untuk memasukkan API key baru, tanpa menghilangkan input yang sudah ditulis.**
