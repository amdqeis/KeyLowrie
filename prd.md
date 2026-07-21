=== FILENAME: prd.md ===

# Product Requirements Document (PRD)
## KeySpace Mobile Application

| Atribut | Nilai |
|---|---|
| Nama produk | KeySpace |
| Platform | Android dan iOS melalui Flutter |
| Product model | Offline-first, no-login, bring-your-own Gemini API key |
| Versi dokumen | 1.0 |
| Status | Baseline produk |
| Tanggal baseline | 21 Juli 2026 |

---

## 1. Ringkasan Produk

KeySpace adalah aplikasi pencatat kalori harian berbasis chatbot AI. Pengguna tidak perlu mencari makanan dari katalog panjang. Pengguna cukup menuliskan konsumsi dalam bahasa natural, misalnya:

> “Aku makan nasi goreng satu porsi, telur, dan es teh manis.”

KeySpace meminta Gemini API mengubah input tersebut menjadi daftar makanan terstruktur, porsi, estimasi kalori, dan estimasi makronutrien. Hasil ditampilkan sebagai preview yang dapat diperiksa dan dikoreksi sebelum disimpan ke log harian.

Seluruh data aplikasi berada pada perangkat. KeySpace tidak memiliki backend developer, akun user, atau sinkronisasi cloud. Pengguna menyediakan API key Gemini miliknya sendiri dan dapat memasukkan banyak key. Aplikasi memakai **Sticky Sequential Failover**: key aktif digunakan selama berhasil; ketika gagal karena invalid, akses, kuota, rate limit, atau gangguan sementara, aplikasi mencoba key berikutnya sesuai prioritas. Jika seluruh key gagal, aplikasi mempertahankan input dan menampilkan peringatan agar pengguna menambahkan API key baru atau mencatat secara manual.

---

## 2. Latar Belakang dan Problem Statement

### 2.1 Latar Belakang

Pencatatan kalori sering gagal dipertahankan karena:

- pengguna harus mencari makanan satu per satu;
- nama makanan lokal atau racikan tidak selalu tersedia;
- ukuran porsi tidak selalu formal;
- form pencatatan terasa administratif;
- pengguna tidak yakin angka yang harus dimasukkan;
- aplikasi konvensional sering meminta akun dan sinkronisasi cloud sebelum dapat digunakan;
- kekhawatiran privasi membuat sebagian pengguna enggan mencatat kebiasaan makan.

Di sisi lain, model AI dapat memahami kalimat informal dan mengubahnya menjadi struktur yang lebih mudah ditinjau. Namun ketergantungan pada API eksternal menimbulkan masalah baru: koneksi internet, key invalid, quota habis, rate limit, perubahan model, serta potensi biaya.

### 2.2 Problem Statement Utama

> Pengguna membutuhkan cara cepat dan privat untuk mencatat konsumsi makanan sehari-hari tanpa login dan tanpa mengisi form kompleks, tetapi tetap harus memiliki kontrol untuk mengoreksi estimasi AI dan tetap dapat menggunakan aplikasi ketika koneksi atau API tidak tersedia.

### 2.3 Masalah Turunan

1. Input natural language dapat ambigu.
2. Estimasi kalori dan makro dapat tidak akurat.
3. Satu API key dapat gagal sewaktu-waktu.
4. Banyak API key belum tentu memiliki kuota terpisah.
5. Tanpa backend, aplikasi harus mengelola data, reminder, failover, dan backup sendiri.
6. Tanpa akun/cloud, perpindahan perangkat tidak otomatis.
7. Pengguna dapat lupa mencatat atau belum mencapai target pada akhir hari.
8. Produk kategori health harus menghindari klaim medis dan desain yang memperburuk hubungan pengguna dengan makanan.

---

## 3. Visi Produk

> Menjadikan pencatatan makanan semudah mengirim chat, dengan kontrol data di tangan pengguna dan ketahanan yang baik terhadap kegagalan API.

### 3.1 Product Principles

1. **No account, no gatekeeping.** Pengguna dapat langsung memakai aplikasi.
2. **Local-first by default.** Database lokal adalah sumber kebenaran.
3. **AI assists, user decides.** AI menghasilkan estimasi; pengguna memiliki keputusan akhir.
4. **Never lose the input.** Draft dipertahankan ketika request gagal.
5. **Graceful degradation.** Ketika AI tidak tersedia, manual entry dan seluruh fitur lokal tetap berfungsi.
6. **Transparent key health.** Pengguna dapat melihat key aktif, limited, invalid, atau error.
7. **Neutral health language.** Produk memberi informasi tanpa menghakimi atau membuat klaim medis.
8. **Provider-compliant.** Key pool adalah mekanisme failover, bukan janji untuk menghapus batas provider.

---

## 4. Tujuan dan Non-Tujuan

### 4.1 Product Goals

| ID | Goal |
|---|---|
| G-01 | Mengurangi waktu dan langkah pencatatan makanan dibanding form manual tradisional. |
| G-02 | Memungkinkan penggunaan tanpa akun dan tanpa backend developer. |
| G-03 | Menyediakan pengalaman offline-first untuk seluruh fitur non-AI. |
| G-04 | Mempertahankan input pengguna dan menyediakan jalur pemulihan saat API gagal. |
| G-05 | Meningkatkan availability AI melalui banyak API key dan failover otomatis yang transparan. |
| G-06 | Memberikan dashboard dan histori yang cukup untuk memahami progres kalori dan makro. |
| G-07 | Memastikan pengguna dapat mengoreksi semua estimasi sebelum atau sesudah penyimpanan. |
| G-08 | Menjaga privasi dengan minimisasi data dan penyimpanan key yang aman. |

### 4.2 Non-Goals

1. Diagnosis medis, terapi, atau rekomendasi diet klinis.
2. Menggantikan ahli gizi atau dokter.
3. Memberikan angka nutrisi yang dijamin akurat.
4. Menjamin ketersediaan, harga, atau kuota Gemini API.
5. Mengatasi rate limit dengan cara yang melanggar ketentuan provider.
6. Sinkronisasi cloud, web dashboard, atau multi-device pada baseline.
7. Social feed, komunitas, atau leaderboard.
8. Marketplace makanan atau meal delivery.
9. Integrasi wearable pada MVP.
10. Pemindaian barcode/foto pada MVP.

---

## 5. Target Pengguna

### 5.1 Segmen Utama

- Pengguna yang ingin memantau kalori tetapi tidak menyukai form kompleks.
- Pengguna Indonesia yang sering mengonsumsi makanan lokal atau menggunakan deskripsi informal.
- Pengguna yang peduli privasi dan tidak ingin membuat akun.
- Pengguna teknis atau semi-teknis yang bersedia membawa API key Gemini sendiri.
- Pengguna yang membutuhkan pencatatan dasar tetap berfungsi tanpa internet.

### 5.2 User Persona

#### Persona A — Raka, Pencatat Praktis

- Usia: 24 tahun.
- Tujuan: memantau asupan untuk maintenance.
- Perilaku: makan menu warung dan sering tidak tahu gram.
- Frustrasi: malas mencari setiap item pada database makanan.
- Kebutuhan: mengetik satu kalimat, review cepat, simpan.
- Literasi teknis: menengah; dapat mengikuti panduan membuat API key.

#### Persona B — Maya, Privacy-Conscious User

- Usia: 29 tahun.
- Tujuan: melihat pola mingguan.
- Perilaku: tidak ingin data makan tersimpan di akun cloud.
- Frustrasi: aplikasi meminta registrasi dan banyak permission.
- Kebutuhan: no-login, local backup, penjelasan data yang keluar dari perangkat.
- Literasi teknis: dasar; membutuhkan onboarding API key yang jelas.

#### Persona C — Dimas, Power User

- Usia: 27 tahun.
- Tujuan: tracking konsisten dan cepat.
- Perilaku: memiliki beberapa project/key Gemini dan ingin mengatur prioritas.
- Frustrasi: request gagal ketika satu key mencapai limit.
- Kebutuhan: key pool, status kesehatan, urutan key, usage log ringan, failover tanpa mengetik ulang.
- Literasi teknis: tinggi.

### 5.3 Jobs to Be Done

1. “Ketika selesai makan, saya ingin mencatat dengan satu kalimat agar tidak lupa dan tidak membuang banyak waktu.”
2. “Ketika AI salah menebak porsi, saya ingin mengoreksinya agar log tetap berguna.”
3. “Ketika API key gagal, saya ingin aplikasi mencoba key lain agar pencatatan tidak berhenti.”
4. “Ketika semua key gagal, saya ingin input saya tetap ada dan diberi jalur jelas untuk menambahkan key baru.”
5. “Ketika offline, saya ingin tetap melihat riwayat dan mencatat manual.”
6. “Ketika mendekati akhir hari, saya ingin pengingat yang dapat diatur jika progres masih di bawah target.”
7. “Ketika mengganti atau mereset perangkat, saya ingin dapat membuat backup lokal terlebih dahulu.”

---

## 6. Success Metrics

Karena baseline tidak memiliki backend atau telemetry developer, metrik produk dikumpulkan melalui:

- usability test terkontrol;
- beta survey;
- test instrumentation lokal;
- diagnostics yang diekspor pengguna secara sukarela;
- metrik lokal agregat yang tidak dikirim otomatis.

### 6.1 North Star Metric

**Median waktu dari mulai mengetik hingga Food Log terkonfirmasi** untuk input makanan sederhana.

Target MVP usability test: median ≤ 30 detik pada koneksi normal.

### 6.2 Product Metrics

| ID | Metric | Target Awal | Metode |
|---|---|---:|---|
| M-01 | Onboarding completion rate | ≥ 85% | Usability/beta session |
| M-02 | Pengguna dapat masuk Home tanpa login | 100% | QA |
| M-03 | AI parsing success pada key sehat | ≥ 95% pada test corpus | Automated/integration test |
| M-04 | Failover success saat key pertama gagal dan key kedua sehat | 100% | Integration test |
| M-05 | Input preserved saat seluruh key gagal | 100% | Integration test |
| M-06 | Food Log save success lokal | ≥ 99,9% pada test run | Automated test |
| M-07 | Dashboard harian query p95 | ≤ 300 ms target dataset | Performance test |
| M-08 | Persentase hasil AI yang disimpan tanpa edit | Dipantau, bukan target kualitas tunggal | Beta study |
| M-09 | Correction rate | Dipakai untuk menemukan area prompt/schema lemah | Beta study |
| M-10 | Restore success untuk backup valid | ≥ 99% test fixtures | Automated test |
| M-11 | Secret ditemukan di export/log | 0 kejadian | Security test |
| M-12 | Task success pencatatan manual offline | ≥ 95% | Usability test |

### 6.3 Guardrail Metrics

- Tidak ada secret API key pada log, export, screenshot test, atau analytics.
- Tidak ada request ke domain developer.
- Tidak ada klaim “akurat”, “pasti”, atau “rekomendasi medis” pada hasil AI.
- Tidak ada kehilangan draft pada skenario timeout, app pause, dan all-keys-failed.
- Tidak ada infinite retry/failover loop.
- Tidak ada notifikasi reminder ketika fitur dinonaktifkan.

---

## 7. Information Architecture

### 7.1 Navigasi Utama

Bottom navigation baseline:

1. **Hari Ini**
2. **Chat**
3. **Riwayat**
4. **Insight**
5. **Pengaturan**

Tombol floating atau quick action **Catat Makanan** dapat membuka Chat atau pilihan Chat/Manual.

### 7.2 Halaman Utama

- Onboarding
- Dashboard Hari Ini
- Chat Pencatat Kalori
- Preview Hasil AI
- Form Food Log
- Detail Harian
- Riwayat Kalender/List
- Insight Mingguan/Bulanan
- Favorites/Quick Add
- API Key Pool
- Target dan Profil
- Reminder
- Data dan Backup
- Privacy
- Diagnostics Lokal

---

## 8. Daftar Fitur dan Prioritas MoSCoW

| ID | Fitur | Ringkasan | Prioritas MVP |
|---|---|---|---|
| F-01 | No Login Onboarding | Setup singkat tanpa akun; target manual; BMR/TDEE opsional; API key opsional. | Must |
| F-02 | Local Database & Offline-first | Data lokal sebagai source of truth; CRUD dan histori tetap tersedia offline. | Must |
| F-03 | Gemini API Key Pool | Banyak key, secure storage, priority order, status, Sticky Sequential Failover, all-keys-failed warning. | Must |
| F-04 | AI Food Chat | Input natural language, structured parsing, preview editable, histori chat lokal. | Must |
| F-05 | Food Log Management | Manual entry, edit, delete, duplicate, meal type, date/time. | Must |
| F-06 | Flexible Calorie Target | Target manual, histori target, kalkulator BMR/TDEE opsional, override. | Must |
| F-07 | Dashboard & History | Hari ini, 7 hari, 30 hari, kalori vs target, makro, list log. | Must |
| F-08 | Local Reminder | Jadwal, threshold, permission, schedule-and-cancel, deep link ke hari terkait. | Should untuk MVP; Must sebelum rilis publik |
| F-09 | Favorites & Quick Add | Simpan favorite, frequent food, tambah cepat. | Should |
| F-10 | Export, Backup & Restore | CSV, JSON versioned, merge/replace, key dikecualikan. | Should |
| F-11 | Settings, Theme, Privacy & Accessibility | Theme, satuan, privacy explanation, accessibility minimum. | Must |
| F-12 | Search & Filter | Search makanan dan filter meal type/tanggal. | Should |
| F-13 | Macro Targets | Target makro dan progress. | Could |
| F-14 | Encrypted Full Backup | Backup terenkripsi opt-in termasuk key dengan passphrase. | Could, bukan baseline |
| F-15 | Photo/Barcode Input | Pencatatan dari foto/barcode. | Won’t pada roadmap awal |
| F-16 | Cloud Sync & Accounts | Akun dan multi-device. | Won’t |
| F-17 | Wearable/Health Platform | Integrasi Health Connect/HealthKit. | Could fase jauh |
| F-18 | AI Model Selection Advanced | Pengguna memilih model/konfigurasi compatible. | Could |
| F-19 | Local Food Catalog | Database makanan lokal curated untuk fallback. | Could |
| F-20 | Data Quality Feedback | Tandai estimasi buruk dan simpan koreksi lokal sebagai template. | Should |
| F-21 | Soft Delete & Undo Food Log | Penghapusan Food Log tidak langsung permanen; tersedia jendela waktu untuk undo. | Should |
| F-22 | Home Screen Widget | Widget ringkas kalori hari ini dan quick add dari home screen perangkat. | Could, Fase 3 |
| F-23 | App Lock (PIN/Biometric) | Kunci aplikasi opsional dengan PIN atau biometrik sebelum konten dapat diakses. | Should |

### 8.1 Definisi MVP

MVP wajib memungkinkan siklus berikut:

1. onboarding tanpa login;
2. target ditetapkan;
3. minimal satu key ditambahkan;
4. pengguna mengirim input makanan;
5. aplikasi menjalankan parsing;
6. bila key pertama gagal, key berikutnya dicoba;
7. bila seluruh key gagal, input dipertahankan dan pengguna diarahkan menambah key;
8. hasil sukses dapat diedit dan disimpan;
9. data muncul di dashboard/history;
10. manual entry tetap berfungsi offline.

---

## 9. Detail Fitur dan User Stories

### 9.1 F-01 — No Login Onboarding

#### Product Requirement

Onboarding tidak boleh meminta akun. Pengguna dapat menyelesaikan setup minimum dengan target manual. Data BMR/TDEE dan API key dapat ditambahkan saat onboarding atau nanti.

#### User Stories

- Sebagai pengguna baru, saya ingin langsung menggunakan aplikasi tanpa registrasi agar tidak terhambat proses akun.
- Sebagai pengguna baru, saya ingin menetapkan target kalori manual agar dashboard langsung relevan.
- Sebagai pengguna yang belum tahu target, saya ingin memperoleh estimasi BMR/TDEE agar memiliki titik awal.
- Sebagai pengguna, saya ingin mengubah hasil estimasi secara manual agar target mengikuti keputusan saya.
- Sebagai pengguna yang belum memiliki API key, saya ingin melewati setup key agar tetap dapat mencoba fitur lokal.
- Sebagai pengguna yang melewati setup key, saya ingin diarahkan menambahkan key saat membuka fitur chat agar tahu tindakan yang diperlukan.

#### Acceptance Summary

- Tidak ada login.
- Onboarding dapat diselesaikan tanpa internet.
- AI chat dikunci secara kontekstual, bukan seluruh aplikasi.
- Hasil BMR/TDEE selalu diberi label estimasi.

---

### 9.2 F-02 — Local Database dan Offline-first

#### Product Requirement

Database lokal adalah source of truth. Tidak ada proses sinkronisasi remote.

#### User Stories

- Sebagai pengguna, saya ingin melihat dashboard tanpa internet agar riwayat selalu dapat diakses.
- Sebagai pengguna, saya ingin mencatat manual saat offline agar data tidak tertunda.
- Sebagai pengguna, saya ingin edit dan hapus data offline agar kontrol tidak bergantung jaringan.
- Sebagai pengguna, saya ingin data tetap ada setelah aplikasi ditutup agar log konsisten.
- Sebagai pengguna, saya ingin undo setelah menghapus agar kesalahan tidak langsung permanen.

#### Acceptance Summary

- CRUD lokal tidak memanggil jaringan.
- Operasi multi-record atomik.
- Migrasi schema diuji.
- Draft chat dipulihkan setelah restart.

---

### 9.3 F-03 — Gemini API Key Pool

#### Product Requirement

Pengguna dapat memasukkan banyak API key. Secret disimpan di secure storage; metadata dan usage summary disimpan di database lokal. Sistem memakai Sticky Sequential Failover.

#### User Stories

- Sebagai pengguna, saya ingin menambahkan beberapa API key agar tersedia alternatif ketika satu key gagal.
- Sebagai pengguna, saya ingin memberi alias pada key agar mudah membedakan.
- Sebagai pengguna, saya ingin melihat key dalam format masked agar secret tidak terlihat.
- Sebagai pengguna, saya ingin mengatur urutan prioritas agar aplikasi mencoba key sesuai preferensi.
- Sebagai pengguna, saya ingin key aktif tetap digunakan selama sehat agar perilaku mudah diprediksi.
- Sebagai pengguna, saya ingin aplikasi otomatis pindah ke key berikutnya ketika key aktif gagal agar tidak perlu mengulang manual.
- Sebagai pengguna, saya ingin melihat status `healthy`, `limited`, `invalid`, atau `error` agar tahu kondisi setiap key.
- Sebagai pengguna, saya ingin menonaktifkan key tanpa menghapus agar dapat menggunakannya kembali.
- Sebagai pengguna, saya ingin menguji key agar mengetahui apakah key dapat mengakses model.
- Sebagai pengguna, saya ingin input tetap tersimpan ketika semua key gagal agar saya tidak perlu mengetik ulang.
- Sebagai pengguna, saya ingin mendapat peringatan untuk menambahkan API key baru ketika semua key gagal agar dapat melanjutkan penggunaan AI.
- Sebagai pengguna, saya ingin dapat memilih manual entry ketika semua key gagal agar pencatatan tetap selesai.
- Sebagai pengguna, saya ingin mengetahui bahwa key dari project yang sama mungkin berbagi kuota agar ekspektasi saya benar.

#### Product Rules

1. Active Key digunakan sampai mengalami key-specific failure.
2. Invalid/permission failure langsung dipindahkan ke key berikutnya.
3. Rate limit/quota menetapkan cooldown lalu berpindah.
4. Server error/timeout mendapat retry terbatas, lalu berpindah.
5. Offline, malformed request, dan safety block tidak menghabiskan seluruh pool.
6. Setiap key maksimal dicoba satu siklus, dengan retry sementara yang terbatas.
7. Jika semua gagal, tampilkan **Tambah API Key Baru** sebagai primary action.
8. Setelah key baru ditambahkan, request semula dapat dilanjutkan.
9. Aplikasi tidak menjanjikan key pool menambah kuota.

#### UX Copy Baseline

**All keys failed**

> Semua API key tidak dapat digunakan. Beberapa key mungkin mencapai limit, tidak valid, atau sedang mengalami gangguan. Input kamu tetap tersimpan.

Actions:

- Tambah API Key Baru
- Kelola API Key
- Coba Lagi
- Catat Manual

---

### 9.4 F-04 — AI Food Chat

#### Product Requirement

Chat mengubah input natural language menjadi draft Food Log terstruktur.

#### User Stories

- Sebagai pengguna, saya ingin menjelaskan makanan dengan bahasa sehari-hari agar pencatatan terasa natural.
- Sebagai pengguna, saya ingin memasukkan beberapa makanan dalam satu pesan agar lebih cepat.
- Sebagai pengguna, saya ingin melihat asumsi porsi agar memahami sumber estimasi.
- Sebagai pengguna, saya ingin melihat kalori dan makro per item agar dapat memeriksa hasil.
- Sebagai pengguna, saya ingin mengedit hasil sebelum menyimpan agar kesalahan AI tidak masuk sebagai data final.
- Sebagai pengguna, saya ingin memproses ulang dengan koreksi agar AI dapat memperbaiki asumsi.
- Sebagai pengguna, saya ingin histori chat disimpan lokal agar dapat melihat konteks pencatatan.
- Sebagai pengguna, saya ingin membatalkan request agar tidak perlu menunggu request yang tidak lagi diperlukan.
- Sebagai pengguna, saya ingin input tetap tersedia ketika koneksi gagal agar dapat mencoba lagi.
- Sebagai pengguna, saya ingin hasil diberi label estimasi agar tidak dianggap nilai pasti.

#### Acceptance Summary

- Input kosong tidak dapat dikirim.
- Response menggunakan schema terstruktur dan validasi lokal.
- Preview muncul sebelum konfirmasi secara default.
- Raw response yang tidak valid tidak langsung disimpan.
- Profil personal tidak dikirim jika tidak diperlukan.

---

### 9.5 F-05 — Food Log Management

#### User Stories

- Sebagai pengguna, saya ingin menambahkan log manual agar tidak bergantung pada AI.
- Sebagai pengguna, saya ingin mengubah porsi dan nutrisi agar data lebih sesuai.
- Sebagai pengguna, saya ingin memindahkan waktu/tanggal log agar kesalahan waktu dapat diperbaiki.
- Sebagai pengguna, saya ingin menghapus dan undo agar dapat memperbaiki kesalahan.
- Sebagai pengguna, saya ingin menduplikasi makanan yang sama agar pencatatan berulang lebih cepat.
- Sebagai pengguna, saya ingin melihat meal type agar histori lebih terorganisasi.
- Sebagai pengguna, saya ingin mendapat peringatan duplikasi agar tidak menyimpan dua kali tanpa sengaja.

---

### 9.6 F-06 — Flexible Calorie Target

#### User Stories

- Sebagai pengguna, saya ingin mengatur target manual kapan saja agar sesuai kebutuhan saya.
- Sebagai pengguna, saya ingin menghitung estimasi kebutuhan berdasarkan data dasar agar memperoleh titik awal.
- Sebagai pengguna, saya ingin melihat formula dan asumsi agar hasil transparan.
- Sebagai pengguna, saya ingin override hasil otomatis agar saya tetap memegang kontrol.
- Sebagai pengguna, saya ingin histori lama menggunakan target yang berlaku saat itu agar grafik tidak berubah secara menyesatkan.
- Sebagai pengguna, saya ingin menetapkan target makro opsional agar dapat memantau komposisi asupan.

---

### 9.7 F-07 — Dashboard dan History

#### User Stories

- Sebagai pengguna, saya ingin melihat konsumsi hari ini dibanding target agar memahami progres.
- Sebagai pengguna, saya ingin melihat sisa atau kelebihan kalori agar dapat mengambil keputusan sendiri.
- Sebagai pengguna, saya ingin melihat breakdown protein, karbohidrat, dan lemak agar tidak hanya melihat total kalori.
- Sebagai pengguna, saya ingin membuka tanggal lain agar dapat meninjau histori.
- Sebagai pengguna, saya ingin melihat tren mingguan dan bulanan agar memahami pola.
- Sebagai pengguna, saya ingin mencari nama makanan agar dapat menemukan log tertentu.
- Sebagai pengguna, saya ingin empty state yang memiliki tindakan agar tahu cara mulai.

---

### 9.8 F-08 — Local Reminder

#### User Stories

- Sebagai pengguna, saya ingin mengaktifkan reminder agar tidak lupa meninjau progres.
- Sebagai pengguna, saya ingin memilih jam agar notifikasi sesuai rutinitas.
- Sebagai pengguna, saya ingin mengatur threshold agar definisi “masih kurang” sesuai preferensi.
- Sebagai pengguna, saya ingin reminder dibatalkan ketika progres sudah mencapai threshold agar tidak mendapat notifikasi yang tidak relevan.
- Sebagai pengguna, saya ingin menekan notifikasi dan langsung membuka hari terkait agar dapat bertindak cepat.
- Sebagai pengguna, saya ingin menonaktifkan reminder kapan saja agar kontrol tetap pada saya.

#### Product Rule

Reminder tidak boleh menggunakan bahasa yang memicu rasa bersalah. Waktu pengiriman bersifat best effort mengikuti kebijakan OS.

---

### 9.9 F-09 — Favorites dan Quick Add

#### User Stories

- Sebagai pengguna, saya ingin menyimpan makanan favorit agar tidak perlu memakai AI untuk makanan berulang.
- Sebagai pengguna, saya ingin melihat makanan yang sering dicatat agar quick add semakin relevan.
- Sebagai pengguna, saya ingin menyesuaikan porsi setelah quick add agar tidak selalu menggunakan nilai yang sama.
- Sebagai pengguna, saya ingin menghapus favorite agar daftar tetap rapi.

---

### 9.10 F-10 — Export, Backup, dan Restore

#### User Stories

- Sebagai pengguna, saya ingin mengekspor CSV agar dapat menganalisis data sendiri.
- Sebagai pengguna, saya ingin membuat backup JSON agar dapat menyimpan salinan data.
- Sebagai pengguna, saya ingin melihat preview restore agar tidak mengimpor file yang salah.
- Sebagai pengguna, saya ingin memilih merge atau replace agar restore sesuai kebutuhan.
- Sebagai pengguna, saya ingin API key tidak masuk backup biasa agar secret tidak bocor.
- Sebagai pengguna, saya ingin mendapat laporan restore agar tahu data yang berhasil dipulihkan.

---

### 9.11 F-11 — Settings, Privacy, Theme, Accessibility

#### User Stories

- Sebagai pengguna, saya ingin memilih dark mode agar nyaman digunakan.
- Sebagai pengguna, saya ingin memilih satuan agar input mudah dipahami.
- Sebagai pengguna, saya ingin membaca data apa yang dikirim ke Gemini agar dapat membuat keputusan privasi.
- Sebagai pengguna, saya ingin menghapus seluruh data agar dapat mengakhiri penggunaan dengan bersih.
- Sebagai pengguna screen reader, saya ingin kontrol memiliki label agar aplikasi dapat digunakan.
- Sebagai pengguna, saya ingin diagnostics lokal yang aman agar dapat menyelidiki masalah tanpa membocorkan key.

---

### 9.12 F-21 — Soft Delete & Undo Food Log

#### User Stories

- Sebagai pengguna, saya ingin melihat konfirmasi singkat (snackbar/undo bar) setelah menghapus Food Log agar saya punya kesempatan membatalkan jika salah pencet.
- Sebagai pengguna, saya ingin item yang terhapus tetap dapat dipulihkan selama beberapa detik/menit tanpa harus restore backup.
- Sebagai pengguna, saya ingin dashboard dan riwayat langsung memperbarui angka kalori begitu item dihapus, bukan menunggu window undo berakhir.

#### Catatan Produk

- Soft delete berlaku untuk Food Log (dan Food Item di dalamnya), bukan pengganti fitur backup/restore skala penuh.
- Item yang berada dalam window undo tidak dihitung dalam agregasi dashboard/insight, tetapi baris data belum benar-benar dihapus dari database sampai window berakhir atau pengguna menutup snackbar.
- Setelah window undo berakhir, penghapusan menjadi permanen mengikuti proses hard delete normal.

---

### 9.13 F-22 — Home Screen Widget

#### User Stories

- Sebagai pengguna, saya ingin melihat sisa/total kalori hari ini dari home screen tanpa membuka aplikasi agar saya bisa cek progres sekilas.
- Sebagai pengguna, saya ingin tombol quick add pada widget yang membuka Chat/Manual Entry langsung agar mencatat makanan lebih cepat.
- Sebagai pengguna, saya ingin widget tetap menampilkan data terakhir yang tersedia secara lokal meski aplikasi belum dibuka, tanpa memerlukan koneksi internet.

#### Catatan Produk

- Fitur ini dijadwalkan Fase 3 karena membutuhkan implementasi khusus per platform (App Widgets di Android, WidgetKit di iOS) dan tidak kritikal untuk MVP.
- Widget bersifat read-mostly; proses AI parsing tetap terjadi di dalam aplikasi utama, bukan di dalam widget.

---

### 9.14 F-23 — App Lock (PIN/Biometric)

#### User Stories

- Sebagai pengguna, saya ingin mengunci aplikasi dengan PIN atau biometrik (fingerprint/Face ID) agar orang lain yang memegang perangkat saya tidak bisa langsung melihat riwayat makan saya.
- Sebagai pengguna, saya ingin memilih kapan lock diminta (setiap kali dibuka, atau setelah idle beberapa menit) agar sesuai kenyamanan saya.
- Sebagai pengguna, saya ingin ada jalur fallback (misalnya PIN) jika biometrik gagal atau tidak tersedia di perangkat.
- Sebagai pengguna, saya ingin app lock ini bersifat opsional dan dapat dinonaktifkan kapan saja dari Pengaturan.

#### Catatan Produk

- App lock melindungi akses ke UI, bukan pengganti enkripsi database; tetap disarankan berdampingan dengan praktik keamanan perangkat pengguna sendiri.
- Karena tidak ada akun/login, App Lock adalah satu-satunya lapisan privasi tambahan di level aplikasi — relevan khususnya untuk Persona B (Maya, Privacy-Conscious User).
- PIN app lock disimpan sebagai hash tersalting di secure storage, bukan di database biasa, mengikuti pola penyimpanan rahasia yang sama dengan API key.

---

## 10. End-to-End Experience Requirements

### 10.1 Happy Path

1. Pengguna membuka Chat.
2. Mengetik makanan.
3. Active Key berhasil.
4. AI mengembalikan JSON valid.
5. Aplikasi menampilkan preview.
6. Pengguna mengoreksi jika perlu.
7. Pengguna menekan Simpan.
8. Dashboard diperbarui.
9. Reminder hari ini direkonsiliasi.

### 10.2 Failover Path

1. Pengguna mengirim input.
2. Active Key mengembalikan error key-specific.
3. UI menampilkan progress netral, misalnya “Mencoba koneksi alternatif…”.
4. Sistem menandai status key.
5. Sistem mencoba key berikutnya.
6. Jika berhasil, hasil tampil normal; pengguna tidak perlu mengirim ulang.
7. Halaman key pool menunjukkan key yang gagal dan key aktif baru.

### 10.3 All-Keys-Failed Path

1. Seluruh key eligible gagal atau tidak ada key.
2. Input dipertahankan.
3. Modal/bottom sheet menjelaskan masalah.
4. Primary CTA: Tambah API Key Baru.
5. Secondary CTA: Kelola API Key, Coba Lagi, Catat Manual.
6. Setelah key baru disimpan dan lolos/diizinkan untuk dicoba, aplikasi menawarkan **Lanjutkan Pencatatan**.
7. Request menggunakan input semula.

### 10.4 Offline Path

1. Pengguna mengirim chat saat offline.
2. Sistem tidak mencoba seluruh key.
3. Pesan ditandai belum diproses.
4. Actions: Coba saat online atau Catat Manual.
5. Seluruh dashboard/history tetap dapat diakses.

---

## 11. Scope

### 11.1 In Scope MVP

- Flutter Android/iOS.
- No-login onboarding.
- Profil dasar opsional.
- Target manual dan BMR/TDEE opsional.
- Drift/SQLite.
- Secure storage untuk key.
- Multi-key pool dan reorder.
- Sticky Sequential Failover.
- Key health dan usage summary lokal.
- All-keys-failed warning dan add-new-key continuation.
- Chat input teks.
- Structured response, preview, edit, save.
- Histori chat lokal.
- Manual entry.
- Dashboard harian.
- History 7/30 hari.
- Basic charts kalori/makro.
- Edit/delete/undo.
- Theme dan satuan.
- Privacy page.
- Basic local backup/export jika kapasitas sprint memungkinkan; jika tidak, masuk MVP+1.
- Reminder masuk release publik, dapat berada setelah internal MVP.

### 11.2 Out of Scope

- Backend developer.
- Login/register.
- Cloud database.
- Multi-device sync.
- Admin panel.
- Remote push notifications.
- Remote analytics.
- Sharing sosial.
- Barcode dan image recognition.
- Meal plan otomatis.
- Diagnosis atau rekomendasi klinis.
- Payment/subscription KeySpace.
- Penyediaan API key oleh developer.
- Rotasi key yang bertujuan mengelabui atau melanggar kebijakan provider.
- Web/desktop app.
- Collaboration/family accounts.

---

## 12. Risiko dan Mitigasi

| ID | Risiko | Dampak | Probabilitas | Mitigasi |
|---|---|---|---|---|
| R-01 | Pengguna kesulitan memperoleh API key | Aktivasi AI rendah | Tinggi | Panduan langkah demi langkah, allow skip, manual entry tetap tersedia. |
| R-02 | API key invalid atau dicabut | Chat gagal | Tinggi | Validasi key, status jelas, failover, CTA tambah key. |
| R-03 | Semua key mencapai quota/rate limit | AI tidak tersedia | Tinggi | Cooldown, all-keys-failed state, input preserved, manual entry. |
| R-04 | Banyak key berbagi quota project yang sama | Failover tidak membantu | Sedang–tinggi | Edukasi bahwa quota dapat dibagi per project/billing scope; jangan menjanjikan kapasitas tambahan. |
| R-05 | Gemini mengubah model/API/schema | Fitur parsing rusak | Sedang | Provider config terpusat, parser defensif, contract tests, release verification. |
| R-06 | Gemini menghasilkan estimasi salah | Data menyesatkan | Tinggi | Label estimasi, preview, edit, assumptions, re-parse, manual correction. |
| R-07 | Output tidak sesuai JSON schema | Parsing gagal | Sedang | Structured output, validation, repair retry terbatas, manual fallback. |
| R-08 | API key bocor dari log/export | Biaya/penyalahgunaan | Tinggi | Secure storage, redaction, masked UI, security test, exclude backup. |
| R-09 | Reverse engineering aplikasi | Key dapat diekstrak pada perangkat kompromi | Sedang | Jelaskan threat model, secure storage, tidak embed developer key. |
| R-10 | Data hilang saat uninstall/perangkat rusak | Kehilangan histori | Sedang | Backup/export, reminder backup berkala di UI tanpa cloud otomatis. |
| R-11 | Restore merusak database | Data loss | Rendah–sedang | Schema validation, transaction, preview, local safety backup sebelum replace. |
| R-12 | Reminder tidak tepat waktu | Pengalaman tidak konsisten | Sedang | Schedule-and-cancel, reschedule horizon, jelaskan batasan OS. |
| R-13 | Notifikasi memicu perilaku tidak sehat | Harm/reputasi | Sedang | Bahasa netral, user-controlled threshold, easy disable, tidak memberi perintah makan/puasa. |
| R-14 | Target terlalu rendah/tinggi | Potensi penggunaan tidak aman | Sedang | Confirmation untuk nilai ekstrem, disclaimer, tidak mengunci keputusan pengguna secara diam-diam. |
| R-15 | Database tumbuh besar | Dashboard lambat | Rendah | Index, aggregate query, pagination, performance tests. |
| R-16 | Failover loop/biaya request meningkat | Latensi dan quota terbuang | Sedang | Satu siklus kandidat, retry terbatas, error taxonomy. |
| R-17 | Offline terdeteksi keliru | Pool terbuang | Sedang | Gunakan error request sebagai sumber kebenaran; connectivity hanya indikator. |
| R-18 | iOS/Android membatasi background | Conditional reminder tidak selalu presisi | Sedang | Pre-schedule per tanggal dan cancel saat threshold tercapai. |
| R-19 | App store menilai aplikasi health | Penolakan/penyesuaian listing | Sedang | Privacy disclosure, nonmedical positioning, review guideline sebelum submit. |
| R-20 | Pengguna menganggap AI mengirim seluruh profil | Trust rendah | Sedang | Privacy screen menjelaskan payload minimum; profil tidak dikirim baseline. |
| R-21 | Pengguna lupa PIN app lock dan tidak ada akun untuk reset | Terkunci dari data sendiri | Sedang | Fallback biometrik, opsi reset PIN via konfirmasi tambahan (tanpa membocorkan data), dokumentasi jelas bahwa reset PIN tidak menghapus data. |
| R-22 | Window undo soft delete disalahpahami sebagai backup permanen | Data hilang setelah window berakhir | Rendah | Copy UI jelas menyebut batas waktu undo; tidak mengklaim sebagai fitur recovery jangka panjang. |

---

## 13. Dependencies

### 13.1 Product Dependencies

- Pengguna memiliki API key Gemini untuk fitur AI.
- Gemini endpoint/model tersedia.
- Perangkat memiliki secure storage yang dapat digunakan.
- Permission notifikasi diberikan untuk reminder.
- Pengguna membuat backup sendiri untuk perlindungan dari uninstall/perangkat rusak.

### 13.2 Engineering Dependencies

- Flutter/Dart versi yang didukung.
- Drift/SQLite.
- Riverpod.
- Secure storage plugin.
- Networking client.
- Local notification plugin.
- File picker/share plugin.
- JSON serialization dan schema validation.
- Chart library yang kompatibel.

Versi package final dipilih saat implementasi dan dikunci melalui lockfile.

---

## 14. Roadmap Bertahap

### Fase 0 — Product and Technical Validation

**Tujuan:** mengurangi risiko terbesar sebelum membangun UI lengkap.

Deliverables:

- proof of concept Gemini structured output;
- test corpus makanan Indonesia;
- error taxonomy;
- prototype secure storage;
- prototype Drift aggregate query;
- prototype Sticky Sequential Failover dengan fake client;
- UX test onboarding API key;
- privacy/threat model review.

Exit criteria:

- dua key dummy dapat menunjukkan failover deterministik;
- all-keys-failed state mempertahankan input;
- response schema dapat diparse secara konsisten pada corpus awal.

### Fase 1 — Internal MVP

**Must:**

- F-01 No Login Onboarding;
- F-02 Local Database;
- F-03 API Key Pool;
- F-04 AI Food Chat;
- F-05 Food Log;
- F-06 Target;
- F-07 Dashboard dasar;
- F-11 Settings/Privacy.

**Target experience:**

- onboarding;
- add/reorder/test key;
- chat;
- failover;
- preview;
- save;
- dashboard;
- edit/delete;
- manual offline entry.

### Fase 1.1 — Reliability and Public Beta Readiness

- reminder lokal;
- weekly/monthly insights;
- backup/restore;
- favorite/quick add;
- soft delete & undo Food Log (F-21);
- app lock PIN/biometric (F-23);
- search/filter;
- migration hardening;
- accessibility pass;
- localization refinement;
- performance test;
- security test;
- app store privacy assets.

### Fase 2 — Quality and Retention

- frequent food ranking;
- data quality feedback;
- correction templates lokal;
- richer macro goals;
- configurable model advanced;
- improved reminder preferences;
- backup reminder;
- diagnostics export yang disanitasi.

### Fase 3 — Optional Expansion

- local food catalog;
- home screen widget (F-22);
- Health Connect/HealthKit exploration;
- encrypted opt-in backup;
- photo/barcode feasibility study.

Fitur cloud/account tetap di luar visi sampai terdapat keputusan strategis baru karena akan mengubah prinsip privasi dan arsitektur.

---

## 15. Release Criteria

### 15.1 Internal MVP Release

- Seluruh Must pada Fase 1 berfungsi.
- Tidak ada secret pada log/export.
- Key failover test lulus untuk invalid, rate limit, timeout, dan all failed.
- Manual entry dan history lulus offline test.
- Tidak ada destructive migration yang belum diuji.
- Crash pada happy path dan failover kritis telah ditangani.

### 15.2 Public Beta

- Reminder, backup, privacy copy, accessibility minimum, dan app store disclosure selesai.
- Test corpus makanan lokal memiliki baseline kualitas yang disepakati.
- Error messages telah melalui usability review.
- Recovery database dan restore diuji.
- Model/endpoint Gemini diverifikasi ulang sebelum build.

### 15.3 Public Release

- Guardrail metrics terpenuhi.
- Tidak ada blocker security/privacy.
- Known limitations terdokumentasi.
- Customer support content mencakup:
  - cara memperoleh key;
  - mengatasi key invalid/limit;
  - mengapa beberapa key dapat berbagi quota;
  - cara backup;
  - disclaimer estimasi nutrisi.

---

## 16. Open Product Decisions

Keputusan berikut dapat difinalkan saat prototyping tanpa mengubah prinsip inti:

1. Apakah preview selalu wajib atau dapat diubah menjadi auto-save oleh pengguna.
2. Batas karakter input.
3. Horizon penjadwalan reminder, misalnya 14 atau 30 hari.
4. Default cooldown jika provider tidak mengembalikan retry info.
5. Tampilan status Active Key pada chat: selalu terlihat atau hanya saat failover.
6. Apakah raw response tersanitasi disimpan sementara untuk diagnostics opt-in.
7. Apakah target makro masuk MVP atau MVP+1.
8. Apakah backup JSON masuk internal MVP atau public beta.
9. Model Gemini default yang tersedia pada saat release.
10. Durasi window undo untuk soft delete Food Log, misalnya 5 atau 10 detik.
11. Default idle timeout untuk App Lock ketika mode "lock setelah idle" dipilih.
12. Apakah App Lock aktif secara default pada instalasi baru atau harus diaktifkan manual oleh pengguna.

Keputusan yang telah final:

- tidak ada backend;
- tidak ada login;
- API key milik pengguna;
- banyak API key didukung;
- strategi utama adalah Sticky Sequential Failover;
- satu key gagal menyebabkan perpindahan ke key berikutnya;
- seluruh key gagal menyebabkan peringatan dan arahan menambahkan API key baru;
- input pengguna tidak hilang;
- manual entry tetap tersedia;
- data utama tersimpan lokal.
