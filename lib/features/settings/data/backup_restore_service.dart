import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// ─── Konstanta ────────────────────────────────────────────────────────────────

/// Nama file database SQLite di storage.
const _dbFileName = 'keyspace.sqlite';

/// Nama entry SQLite di dalam file ZIP backup.
const _dbEntryName = 'keyspace.sqlite';

/// Menghasilkan nama file ZIP backup dengan timestamp.
String _backupFileName() {
  final now = DateTime.now();
  final stamp =
      '${now.year}'
      '${now.month.toString().padLeft(2, '0')}'
      '${now.day.toString().padLeft(2, '0')}'
      '_${now.hour.toString().padLeft(2, '0')}'
      '${now.minute.toString().padLeft(2, '0')}';
  return 'keyspace_backup_$stamp.zip';
}

// ─── Magic bytes ──────────────────────────────────────────────────────────────

/// PK ZIP local file header: `50 4B 03 04`.
const _zipMagic = [0x50, 0x4B, 0x03, 0x04];

/// SQLite format 3 header: "SQLite format 3\000" (16 bytes).
const _sqliteMagic = [
  83, 81, 76, 105, 116, 101, 32, 102, 111, 114, 109, 97, 116, 32, 51, 0,
];

bool _startsWithMagic(List<int> bytes, List<int> magic) {
  if (bytes.length < magic.length) return false;
  for (var i = 0; i < magic.length; i++) {
    if (bytes[i] != magic[i]) return false;
  }
  return true;
}

Future<List<int>> _readFileHeader(File file, int length) async {
  final raf = await file.open();
  try {
    return await raf.read(length);
  } finally {
    await raf.close();
  }
}

// ─── Result types ─────────────────────────────────────────────────────────────

/// Hasil operasi backup atau restore.
sealed class BackupRestoreResult {
  const BackupRestoreResult();
}

class BackupSuccess extends BackupRestoreResult {
  const BackupSuccess();
}

class RestoreSuccess extends BackupRestoreResult {
  const RestoreSuccess();
}

class BackupRestoreCancelled extends BackupRestoreResult {
  const BackupRestoreCancelled();
}

class BackupRestoreFailure extends BackupRestoreResult {
  const BackupRestoreFailure(this.message);
  final String message;
}

// ─── Service ──────────────────────────────────────────────────────────────────

/// Service untuk backup dan restore database KeySpace.
///
/// **Format backup:** file `.zip` berisi satu entry `keyspace.sqlite`.
/// ZIP mudah diidentifikasi, di-share, dan dibuka dengan tools standar.
///
/// **Data yang dibackup:** seluruh database SQLite — food log, keuangan,
/// jadwal, chat, settings, profil. **TIDAK termasuk API key** — key disimpan
/// di secure storage platform dan tidak masuk database.
///
/// **Backward-compat restore:** file `.sqlite` raw (format backup lama) juga
/// diterima dan akan di-restore tanpa modifikasi.
class BackupRestoreService {
  // ── Backup ────────────────────────────────────────────────────────────────

  /// Membuat file ZIP backup lalu membagikannya via system share sheet.
  ///
  /// Alur:
  /// 1. Baca bytes database SQLite.
  /// 2. Bungkus dalam ZIP (entry tunggal `keyspace.sqlite`).
  /// 3. Buka share sheet — user bisa simpan ke Files, Drive, dll.
  Future<BackupRestoreResult> backup() async {
    try {
      final dbFile = await _databaseFile();
      if (!dbFile.existsSync()) {
        return const BackupRestoreFailure('Database file tidak ditemukan.');
      }

      final cacheDir = await getTemporaryDirectory();
      final zipPath = p.join(cacheDir.path, _backupFileName());

      await _createZip(dbFile, zipPath);

      final result = await SharePlus.instance.share(
        ShareParams(
          files: [XFile(zipPath, mimeType: 'application/zip')],
          subject: 'KeySpace Backup',
        ),
      );

      if (result.status == ShareResultStatus.dismissed) {
        return const BackupRestoreCancelled();
      }
      return const BackupSuccess();
    } on Object catch (e) {
      return BackupRestoreFailure('Backup gagal: $e');
    }
  }

  // ── Restore ───────────────────────────────────────────────────────────────

  /// Restore database dari file backup yang dipilih user.
  ///
  /// Menerima dua format:
  /// - `.zip` (format baru) — berisi entry `keyspace.sqlite`.
  /// - `.sqlite` raw (format lama, backward-compat).
  ///
  /// ⚠️ App harus di-restart setelah restore agar database ter-reload.
  Future<BackupRestoreResult> restore() async {
    try {
      final picked = await FilePicker.pickFiles(
        type: FileType.any,
        dialogTitle: 'Pilih file backup KeySpace (.zip atau .sqlite)',
      );

      if (picked.isEmpty) {
        return const BackupRestoreCancelled();
      }

      final pickedPath = picked.single.path;
      if (pickedPath == null) {
        return const BackupRestoreFailure('Path file tidak valid.');
      }

      final pickedFile = File(pickedPath);
      if (!pickedFile.existsSync()) {
        return const BackupRestoreFailure('File yang dipilih tidak ditemukan.');
      }

      final header = await _readFileHeader(pickedFile, 16);

      if (_startsWithMagic(header, _zipMagic)) {
        return await _restoreFromZip(pickedFile);
      } else if (_startsWithMagic(header, _sqliteMagic)) {
        return await _restoreFromSqlite(pickedFile);
      } else {
        return const BackupRestoreFailure(
          'Format file tidak dikenali. '
          'Pilih file backup KeySpace (.zip atau .sqlite).',
        );
      }
    } on Object catch (e) {
      return BackupRestoreFailure('Restore gagal: $e');
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Membuat file ZIP dari [dbFile] dan menulis ke [zipPath].
  Future<void> _createZip(File dbFile, String zipPath) async {
    final archive = Archive();
    final bytes = await dbFile.readAsBytes();
    archive.addFile(ArchiveFile(_dbEntryName, bytes.length, bytes));

    final encoder = ZipEncoder();
    final zipBytes = encoder.encode(archive);
    if (zipBytes == null || zipBytes.isEmpty) {
      throw StateError('ZIP encoder menghasilkan output kosong.');
    }
    await File(zipPath).writeAsBytes(zipBytes, flush: true);
  }

  /// Restore dari ZIP: ekstrak entry `keyspace.sqlite` lalu timpa DB aktif.
  Future<BackupRestoreResult> _restoreFromZip(File zipFile) async {
    final inputStream = InputFileStream(zipFile.path);
    final archive = ZipDecoder().decodeBuffer(inputStream);

    final entry = archive.findFile(_dbEntryName);
    if (entry == null) {
      return const BackupRestoreFailure(
        'File ZIP tidak mengandung data backup KeySpace yang valid.',
      );
    }

    final content = entry.content as List<int>;

    // Validasi isi: harus berupa SQLite yang valid.
    if (!_startsWithMagic(content.take(16).toList(), _sqliteMagic)) {
      return const BackupRestoreFailure(
        'Isi backup tidak berupa database SQLite yang valid.',
      );
    }

    final dbFile = await _databaseFile();
    await File(dbFile.path).writeAsBytes(content, flush: true);
    return const RestoreSuccess();
  }

  /// Restore dari file SQLite raw (format lama, backward-compat).
  Future<BackupRestoreResult> _restoreFromSqlite(File sqliteFile) async {
    final dbFile = await _databaseFile();
    await sqliteFile.copy(dbFile.path);
    return const RestoreSuccess();
  }

  /// Mengembalikan [File] path database SQLite aktif.
  Future<File> _databaseFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, _dbFileName));
  }
}
