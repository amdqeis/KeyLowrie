# Design Specification — KeySpace
## Neo-Brutalist, Chat-First Mobile UI (untuk Google Stitch)

| Atribut | Nilai |
|---|---|
| Produk | KeySpace |
| Gaya desain | Neo-Brutalism |
| Layout paradigm | Chat-first (terinspirasi ChatGPT/Gemini app) |
| Platform | Flutter — Android & iOS |
| Versi dokumen | 1.0 |
| Tanggal | 21 Juli 2026 |

---

## 1. Filosofi Desain

KeySpace adalah aplikasi yang jujur soal keterbatasannya: data lokal, AI bisa gagal, user harus mengoreksi. Brutalism cocok karena bahasanya juga jujur — bentuk terlihat apa adanya, border tegas, tidak ada gradient yang menyembunyikan struktur, dan status (healthy/limited/invalid/failover) ditampilkan sebagai **blok warna dan label**, bukan animasi halus yang menyamarkan masalah.

Prinsip:

1. **Struktur telanjang.** Border tebal, tanpa shadow lembut — kalau ada shadow, hard shadow offset (khas brutalism), bukan blur.
2. **Chat adalah pusat gravitasi.** Layar utama harian adalah percakapan, bukan form. Dashboard dan riwayat adalah "orbit" di sekitar chat, diakses lewat bottom navigation sederhana.
3. **Status jangan basa-basi.** Key sehat = hijau solid + label "SEHAT". Key limit = kuning solid + label "LIMIT". Tidak ada icon ambigu tanpa teks (selaras dengan requirement aksesibilitas di userflow.md §22).
4. **Kontras tinggi, tipografi besar.** Angka kalori dan status adalah informasi terpenting di layar — harus langsung kebaca tanpa mikir.
5. **Sedikit warna, dipakai dengan berani.** Brutalism bukan warna-warni; satu accent dipakai konsisten sebagai "tanda tangan" brand.

---

## 2. Warna — Ditentukan oleh Claude untuk Brand KeySpace

Nama "KeySpace" bermain di dua ide: *key* (API key pool) dan *space* (ruang personal, lokal, milik user sendiri). Palet berikut membawa itu ke visual: base netral tegas (paper/ink, khas brutalism cetak) + satu accent kuning sinyal yang merepresentasikan "key" — warna kuning gembok/kunci, energik, dan gampang dipakai sebagai indikator status/CTA.

### 2.1 Base Palette

| Token | Hex | Peran |
|---|---|---|
| `--ks-paper` | `#F5F3EE` | Background utama (bukan putih murni — sedikit warm, khas brutalist print) |
| `--ks-ink` | `#111111` | Teks utama, border, ikon |
| `--ks-white` | `#FFFFFF` | Card/surface di atas paper |
| `--ks-line` | `#111111` | Semua border (solid, 2–3px, tidak pernah abu-abu tipis) |

### 2.2 Signature Accent

| Token | Hex | Peran |
|---|---|---|
| `--ks-signal-yellow` | `#FFD60A` | Accent utama brand — primary CTA, Active Key indicator, highlight kalori |
| `--ks-signal-yellow-dark` | `#E6C200` | Pressed state dari accent |

### 2.3 Status Semantic (dipakai literal, tidak dicampur gradasi)

| Token | Hex | Dipakai untuk |
|---|---|---|
| `--ks-status-healthy` | `#3BB273` (hijau solid) | Key `healthy`, progress kalori tercapai wajar |
| `--ks-status-limited` | `#FFD60A` (kuning, reuse accent) | Key `limited`, mendekati target |
| `--ks-status-error` | `#E4572E` (oranye-merah brutal, bukan merah alarm klinis) | Key `invalid`/`blocked`, all-keys-failed |
| `--ks-status-neutral` | `#111111` di atas `#E5E5E0` | Key `untested`/`disabled` |

### 2.4 Aturan Pemakaian Warna

- Maksimum 1 accent + 1 status color aktif per layar agar tidak ramai.
- Warna tidak pernah jadi satu-satunya penanda status (selalu didampingi label teks/ikon, sesuai kebutuhan aksesibilitas).
- Dark mode: `--ks-paper` → `#111111`, `--ks-ink` → `#F5F3EE`, border tetap solid tinggi kontras, accent kuning tetap sama (kuning brutalist justru makin menonjol di dark).

---

## 3. Tipografi

Brutalism butuh tipografi dengan karakter kuat — grotesque/mono, bukan tipografi humanis yang lembut.

| Peran | Font Direction | Contoh yang cocok jika tersedia di Stitch/Flutter |
|---|---|---|
| Display/Angka kalori besar | Grotesque bold / condensed sans | `Space Grotesk`, `Archivo Black`, atau `IBM Plex Sans Bold` |
| Heading & label | Grotesque sans, tegas | `Space Grotesk`, `Inter Bold` |
| Body/chat text | Sans netral, readable | `Inter`, `IBM Plex Sans` |
| Data teknis (API key masked, timestamp, angka log) | Monospace | `IBM Plex Mono`, `JetBrains Mono` |

Skala tipografi (mobile):

| Level | Ukuran | Weight | Contoh Pemakaian |
|---|---|---|---|
| Display | 40–48px | 800 | Angka kalori hari ini di Dashboard |
| H1 | 28px | 800 | Judul layar |
| H2 | 20px | 700 | Judul card/section |
| Body | 16px | 500 | Isi chat, deskripsi |
| Caption | 13px | 600, uppercase, letter-spacing | Status badge, label field |
| Mono | 14px | 500 | Masked API key, timestamp |

---

## 4. Grid, Spacing & Bentuk

- **Spacing unit:** basis 8px (4, 8, 12, 16, 24, 32).
- **Border:** solid `--ks-ink`, tebal **2px** untuk elemen kecil (chip, input), **3px** untuk card/container utama.
- **Corner radius:** brutalism boleh sedikit rounded untuk mobile-friendliness, tapi tetap tegas — gunakan radius kecil konsisten **8px**, jangan full-rounded/pill kecuali untuk badge status dan avatar.
- **Shadow:** hard offset shadow, bukan blur. Contoh: `box-shadow: 4px 4px 0 #111111` — shadow ini yang memberi kesan "ditempel" khas brutalism, dipakai pada card dan tombol primary.
- **Divider:** garis solid 2px, bukan garis tipis 1px abu-abu.

---

## 5. Komponen Inti

### 5.1 Button

| Varian | Style |
|---|---|
| Primary | Fill `--ks-signal-yellow`, border 3px `--ks-ink`, hard shadow 4px, teks hitam bold uppercase kecil |
| Secondary | Fill `--ks-white`, border 3px `--ks-ink`, teks hitam, shadow lebih tipis (2px) |
| Destructive | Fill `--ks-status-error`, border `--ks-ink`, teks putih/hitam kontras tinggi |
| Disabled | Fill `--ks-white`, border putus-putus/abu, teks abu, tanpa shadow |

Interaksi tekan (press state) khas brutalism: shadow "menempel" — saat ditekan, tombol bergeser ke posisi shadow (translate 4px) dan shadow hilang, memberi efek fisik "ditekan ke kertas".

### 5.2 Chat Bubble (layar utama)

- Bubble user: fill `--ks-white`, border 2–3px `--ks-ink`, rata kanan.
- Bubble AI/system: fill `--ks-paper` sedikit beda shade atau outline saja, rata kiri, disertai badge kecil "AI ESTIMASI" (uppercase, mono, border tipis) di atas bubble hasil parsing.
- Preview hasil parsing food: bukan bubble biasa, tapi **card struktural** di dalam alur chat — border tebal, list item makanan dengan angka kalori mono font di kanan, tombol Edit/Simpan sebagai button brutalist kecil di bawah card.
- Status inline (`requesting`, `failing_over`, `all_keys_failed`, dst dari userflow.md §2.1) muncul sebagai **strip status** di atas composer — bar solid warna status + teks singkat, bukan toast melayang.

### 5.3 Status Badge (API Key & Food Parsing)

Bentuk: pill kecil, border 2px `--ks-ink`, fill sesuai status semantic, teks uppercase bold kecil + ikon literal (bukan hanya warna). Contoh: `● SEHAT`, `▲ LIMIT`, `✕ INVALID`.

### 5.4 Card (Dashboard, Riwayat, Settings item)

- Border 3px solid, hard shadow 4px, radius 8px.
- Header card selalu uppercase caption + H2.
- Card API Key Pool menampilkan: alias/masked key (mono), status badge, mini usage indicator sebagai bar segmented (bukan gradient), drag handle untuk reorder priority (brutalist grip icon: 3 garis tebal).

### 5.5 Progress Ring/Bar Kalori

Karena brutalism menghindari elemen dekoratif melengkung yang terlalu halus, progress kalori direpresentasikan sebagai:

- **Bar horizontal tebal bersegmen** (bukan ring gradient halus) dengan border, fill accent kuning sampai proporsi tercapai, sisanya paper kosong.
- Angka besar di atas bar: `"1.240 / 2.000 KKAL"` dalam Display font.
- Teks status di bawah: `"760 KKAL LAGI"` uppercase caption.
- Jika ring tetap diinginkan untuk halaman Insight (grafik mingguan), gunakan ring dengan stroke tebal solid + border luar, bukan soft gradient.

### 5.6 Input Field

- Border 2–3px solid, tanpa rounded penuh (radius 8px), label di atas field (bukan floating label halus), fokus state = border jadi accent kuning + shadow muncul.

### 5.7 Navigasi

- Bottom navigation brutalist: 5 item (Hari Ini / Chat / Riwayat / Insight / Pengaturan sesuai struktur navigasi userflow.md §3), border atas tebal 3px, item aktif mendapat background block accent kuning di belakang ikon+label (bukan sekadar warna ikon berubah).

---

## 6. Peta Layar untuk Di-generate di Google Stitch

Gunakan daftar ini sebagai prompt terpisah per layar di Stitch (Stitch bekerja lebih baik per-layar daripada satu prompt raksasa). Setiap layar mewarisi style system Bagian 1–5 di atas.

### Prioritas Fase 1 (generate dulu):

1. **Onboarding — Welcome (B1)**: full-bleed paper background, headline besar Display font "CATAT MAKANAN CUKUP LEWAT CHAT", 3 baris value prop dengan icon literal kotak bersudut, tombol primary "MULAI" brutalist di bawah.
2. **Onboarding — Setup Target (B3/B4A)**: pilihan card besar (Manual / Kalkulator / Atur Nanti), radio brutalist berupa kotak bercentang bukan bulat halus.
3. **Onboarding — Setup API Key (B5/B6A)**: form input key, toggle "Tes key sekarang" sebagai switch brutalist kotak, status hasil tes sebagai badge dari §5.3.
4. **Dashboard Hari Ini**: header tanggal, progress bar kalori besar (§5.5), card ringkasan makro (protein/karbo/lemak) sebagai 3 kolom kotak dengan angka mono, list Food Log hari ini sebagai card kecil (nama makanan, kkal kanan, swipe-to-edit).
5. **Chat — Layar Utama**: composer di bawah, riwayat bubble (§5.2), strip status di atas composer, preview card hasil parsing dengan tombol Edit/Simpan.
6. **All-Keys-Failed Dialog**: modal brutalist border tebal shadow besar, headline status error, 4 tombol aksi (Tambah API Key Baru sebagai primary, Kelola/Retry/Manual sebagai secondary stack).
7. **Pengaturan — API Key Pool**: list card key (§5.4) dengan drag handle reorder, tombol tambah key floating brutalist di kanan bawah (kotak bukan lingkaran).

### Prioritas Fase 1.1 (generate setelah alur inti solid):

8. **Riwayat (Harian/Mingguan/Bulanan)** — tab brutalist di atas, list/grafik bar solid per hari.
9. **Insight — Grafik Kalori & Makro** — bar chart solid berwarna status semantic, bukan line chart gradient.
10. **Pengaturan — Reminder** — time picker brutalist, slider threshold sebagai stepped bar bukan smooth slider.
11. **Backup/Restore** — preview data sebagai tabel ringkas dengan border tebal khas brutalist "receipt".

---

## 7. Prompt Siap Pakai untuk Google Stitch

Contoh master prompt yang bisa ditempel di Stitch sebagai konteks awal sebelum meminta layar spesifik:

```
Design a mobile app UI in neo-brutalist style for "KeySpace", a calorie-tracking
chatbot app. Use a warm off-white paper background (#F5F3EE), pure black ink
(#111111) for all thick solid borders (2-3px) and text, and a signature signal
yellow accent (#FFD60A) for primary buttons and key highlights. Use hard offset
drop shadows (4px, no blur) instead of soft shadows. Typography: bold grotesque
sans for headings and large numbers, clean sans for body text, monospace for
technical data like masked API keys and timestamps. Corners slightly rounded
(8px radius), never fully pill-shaped except status badges. Status indicators
(healthy/limited/invalid/error) must always pair a solid color block with an
explicit text label and icon, never color alone. The overall feel is honest,
structural, high-contrast, and chat-first — inspired by ChatGPT/Gemini's
conversational layout but rebuilt with raw brutalist blocks instead of soft
minimalism.
```

Lanjutkan dengan prompt per layar dari Bagian 6, satu per satu.

---

## 8. Yang Perlu Dipastikan Konsisten Antar Layar (Design Checklist)

- [ ] Semua card pakai border + hard shadow yang sama tebalnya di seluruh app.
- [ ] Satu accent kuning tidak dipakai berlebihan — hanya untuk CTA utama & elemen "signature".
- [ ] Status key & status parsing selalu badge teks+ikon+warna (§5.3), tidak pernah warna saja.
- [ ] Angka kalori/kkal selalu pakai font Display/Mono, tidak pernah font body biasa.
- [ ] Dark mode tetap mempertahankan border solid tinggi kontras (bukan border redup).
- [ ] Empty state & error state (lihat Error/Empty State Matrix di userflow.md §20) tetap ikut style brutalist card, bukan ilustrasi lembut generik.
