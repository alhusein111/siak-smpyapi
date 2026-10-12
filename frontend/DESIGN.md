# DESIGN SYSTEM SPECIFICATION (DESIGN.md)
## SIAK-SMPYAPI v.2 — Sistem Informasi Akademik SMP YAPI AL-HUSAENI

Dokumentasi arsitektur desain, token visual, komponen, dan pedoman implementasi Flutter & Web untuk platform akademik dan keuangan terpadu SMP YAPI AL-HUSAENI.

---

### 1. Identity & Philosophy
- **Nama Produk:** SIAK-SMPYAPI v.2
- **Nama Institusi:** SMP YAPI AL-HUSAENI (Lebakbiru)
- **Karakter Visual:** *Professional Educational Technology, Trustworthy, Modern Institutional, Clean & Functional.*
- **Prinsip Desain:**
  1. **Data Density with Clarity:** Ruang kerja operator dan guru harus padat informasi namun tetap bernapas melalui ritme spasi teratur (skala 4px).
  2. **Multi-Sensory Status:** Status tidak boleh hanya mengandalkan warna; selalu sertakan ikon status dan teks eksplisit (WCAG AA).
  3. **Flutter-Native Parity:** Semua token diatur agar dapat di-mapping 1:1 ke `ThemeData`, `ColorScheme`, dan `TextTheme` di Flutter/Dart.

---

### 2. Color Palette & Token Mapping

#### A. Brand & Foundation
| Token Name | Hex Code | Flutter ColorScheme Mapping | Peruntukan / Usage |
|---|---|---|---|
| `primaryNavy` | `#173B65` | `colorScheme.primaryContainer` | Topbar, sidebar active accent, header identitas |
| `primaryBlue` | `#2458C5` | `colorScheme.primary` | Tombol aksi utama, link aktif, focus border |
| `secondaryTeal` | `#0F8588` | `colorScheme.secondary` | Aksi pendukung, badge sekunder, filter aktif |
| `accentGold` | `#F2B84B` | `colorScheme.tertiary` | Aksen lambang sekolah, highlight prestasi, lencana khusus |
| `appBackground`| `#F4F7FB` | `colorScheme.surfaceContainerLowest` | Background kanvas aplikasi desktop & mobile |
| `surface` | `#FFFFFF` | `colorScheme.surface` | Background kartu, kontainer dialog, tabel |
| `surfaceSubtle`| `#EDF2F8` | `colorScheme.surfaceContainerLow` | Header tabel, background input, sidebar hover |
| `borderDefault`| `#DCE4EF` | `colorScheme.outlineVariant` | Border kartu, garis batas tabel, pemisah field |
| `borderFocus`  | `#2458C5` | `colorScheme.outline` | Outline saat keyboard focus / form active |

#### B. Semantic Colors
| Semantic | Token / Hex | Background Tint (12%) | Ikon / Teks | Penggunaan |
|---|---|---|---|---|
| **Success** | `#16815D` | `#E8F6F0` | Tanda centang, teks status | Lunas, Hadir, Disetujui, Berhasil |
| **Warning** | `#946200` | `#FEF6E7` | Tanda seru segitiga | Cicilan aktif, Menunggu Approval, Jatuh tempo |
| **Error** | `#C83C45` | `#FDECEE` | Lingkaran silang | Tunggakan, Alfa/Absen, Ditolak, Destruktif |
| **Info** | `#2767C7` | `#EAF2FD` | Informasi netral (i) | Catatan akademik, pengumuman terjadwal |

#### C. Neutral Text & Icons
| Token | Hex | Opacity | Kontras Rasio (thd #FFFFFF) | Peruntukan |
|---|---|---|---|---|
| `textPrimary` | `#172B4D` | 100% | 12.8:1 (AAA) | Judul, data tabel, teks input utama |
| `textSecondary`| `#5E6C84` | 100% | 5.8:1 (AA) | Label field, deskripsi, placeholder teks |
| `textDisabled` | `#A5B2C6` | 100% | 2.5:1 | Elemen non-aktif, batas readonly |

---

### 3. Typography Hierarchy

Referensi font: **Inter** (Web) / **Roboto** atau bundled Google Fonts (Flutter). Angka nominal finansial dan NISN/NIP menggunakan font varian `font-feature-settings: "tnum" 1` (Tabular Numbers).

| Text Style | Ukuran | Weight | Line Height | Letter Spacing | Flutter `TextTheme` Target |
|---|---|---|---|---|---|
| **Display** | 32 px | SemiBold (600) | 40 px | -0.5 px | `displaySmall` |
| **H1** | 28 px | SemiBold (600) | 36 px | -0.3 px | `headlineMedium` |
| **H2** | 24 px | SemiBold (600) | 32 px | -0.2 px | `headlineSmall` |
| **H3** | 20 px | SemiBold (600) | 28 px | 0 px | `titleLarge` |
| **H4** | 18 px | Medium (500) | 24 px | 0 px | `titleMedium` |
| **Body Large**| 16 px | Regular (400) | 24 px | +0.1 px | `bodyLarge` |
| **Body** | 14 px | Regular (400) | 20 px | +0.1 px | `bodyMedium` |
| **Label** | 13 px | Medium (500) | 18 px | +0.2 px | `labelLarge` |
| **Caption** | 12 px | Regular (400) | 16 px | +0.2 px | `bodySmall` / `labelSmall` |

---

### 4. Spacing, Grid, & Layout Tokens

Grid kelipatan 4px: `4, 8, 12, 16, 20, 24, 32, 40, 48, 64 px`.

```dart
// Flutter Spacing Constant Guide
abstract class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;   // Default form field gap & card inner padding sm
  static const double xl = 20.0;
  static const double xxl = 24.0;  // Card inner padding lg & page horizontal desktop
  static const double section = 32.0;
  static const double page = 40.0;
  static const double block = 64.0;
}
```

#### Dimensi Shell & Navigasi:
- **Desktop Sidebar:** Lebar default **248 px**; saat di-collapse menjadi **76 px**.
- **Desktop Topbar:** Tinggi tetap **64 px** dengan elevasi datar (0dp) dan border bawah `1px solid #DCE4EF`.
- **Content Max-Width / Padding:** Fluid container dengan padding `24 px` (layar < 1440px) atau `32 px` (layar >= 1440px).
- **Tablet (768px – 1024px):** Navigation rail (76 px) atau modal drawer.
- **Ponsel (< 768px):** Modal Bottom Sheet / Drawer dengan target sentuh minimum **44–48 px**.

---

### 5. Shape & Elevation

- **Input Fields & Buttons:** Radius **8–10 px** (`BorderRadius.circular(8)` atau `10`).
- **Cards & Containers:** Radius **12 px** (`BorderRadius.circular(12)`).
- **Dialogs & Modals:** Radius **16 px** (`BorderRadius.circular(16)`).
- **Badges / Chips:** Radius **6 px** (rounded rect) atau pill **999 px**.
- **Border Treatment:** `1px solid #DCE4EF` (halus dan tidak tebal).
- **Elevation / Shadows:**
  - `Level 0 (Flat)`: `none` (default di dalam container atau list item).
  - `Level 1 (Card/Dropdown)`: `0px 2px 6px rgba(23, 43, 77, 0.05), 0px 1px 2px rgba(23, 43, 77, 0.03)`
  - `Level 2 (Modal/Dialog)`: `0px 12px 28px rgba(23, 43, 77, 0.12), 0px 4px 10px rgba(23, 43, 77, 0.06)`

---

### 6. Component Guidelines

1. **Buttons:**
   - *Primary:* Background `#2458C5`, Text White, Hover `#1A449E`, Active `#173B65`.
   - *Secondary:* Background `#EDF2F8`, Text `#173B65`, Border `#DCE4EF`.
   - *Destructive:* Background `#C83C45`, Text White, Hover `#A62B34`. Digunakan pada hapus data & tolak approval.
   - *Outline:* Border `#DCE4EF`, Text `#172B4D`, Hover Background `#F4F7FB`.
   - *Text:* Tanpa border, Text `#2458C5`, Hover Background `#EAF2FD`.

2. **Form Controls:**
   - Tinggi standard input desktop: `40 px` (Touch mobile: `48 px`).
   - Default state: Border `#DCE4EF`, Background `#FFFFFF`.
   - Focus state: Border `#2458C5` + 2px subtle ring `#2458C5` at 15% opacity.
   - Error state: Border `#C83C45` + helper text di bawah warna `#C83C45` (12px).

3. **Data Tables (SIAK Core):**
   - Header row: Background `#EDF2F8`, Teks `#5E6C84`, Font 12px SemiBold uppercase, Height `44 px`.
   - Data rows: Height `48 px` (compact) hingga `56 px` (standard), Border bottom `#DCE4EF`.
   - Hover row: Background `#F4F7FB`.
   - Numerik / Finansial: Align right, format mata uang `Rp xx.xxx.xxx`, Tabular Figures.

4. **Status Badges / Chips:**
   - Padding: `4px 10px`, font 12px Medium, radius 6px.
   - Selalu pasangkan dengan ikon indikator (misal titik dot atau ikon svg).

5. **Modal Konfirmasi Sensitif (Keuangan/Approval):**
   - Wajib memiliki ringkasan nominal besar (contoh: "Total Pembayaran: Rp 450.000").
   - Aksi ganda dengan primary action di kanan dan batalkan di kiri.

---

### 7. Do's and Don'ts

| Do's | Don'ts |
|---|---|
| **DO** gunakan angka tabular untuk tanggal, NISN, nominal SPP, dan nilai rapor. | **DON'T** gunakan font dekoratif atau handwriting untuk angka laporan akademik. |
| **DO** berikan feedback visual ganda (warna + teks + ikon) pada tagihan jatuh tempo atau siswa absen. | **DON'T** menggunakan warna merah atau hijau saja tanpa label keterangan status. |
| **DO** pertahankan tombol aksi destruktif (Hapus Akun / Tolak) dengan dialog konfirmasi eksplisit. | **DON'T** memicu penghapusan seketika tanpa double confirmation. |
| **DO** gunakan loading skeleton beranimasi halus daripada blank spinner saat memuat data tabel. | **DON'T** membuat layar kosong saat request backend sedang diproses. |
| **DO** sesuaikan tabel ke card vertikal saat dibuka di aplikasi mobile/tablet. | **DON'T** membiarkan tabel melebar horizontal tanpa kontrol visual di layar smartphone. |

---

### 8. Flutter Implementation Snippet

```dart
import 'package:flutter/material.dart';

class SiakTheme {
  static const Color primaryNavy = Color(0xFF173B65);
  static const Color primaryBlue = Color(0xFF2458C5);
  static const Color secondaryTeal = Color(0xFF0F8588);
  static const Color accentGold = Color(0xFFF2B84B);
  static const Color appBackground = Color(0xFFF4F7FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFEDF2F8);
  static const Color textPrimary = Color(0xFF172B4D);
  static const Color textSecondary = Color(0xFF5E6C84);
  static const Color border = Color(0xFFDCE4EF);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: appBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryBlue,
      onPrimary: Colors.white,
      primaryContainer: primaryNavy,
      onPrimaryContainer: Colors.white,
      secondary: secondaryTeal,
      onSecondary: Colors.white,
      error: Color(0xFFC83C45),
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      outline: primaryBlue,
      outlineVariant: border,
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: border, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
    ),
  );
}
```
