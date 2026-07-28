import 'dart:io';

import 'package:keyspace/features/report_export/data/calorie_report_query.dart';
import 'package:keyspace/features/report_export/data/finance_report_query.dart';
import 'package:keyspace/features/report_export/domain/calorie_pdf_builder.dart';
import 'package:keyspace/features/report_export/domain/finance_pdf_builder.dart';
import 'package:keyspace/features/report_export/domain/report_date_range.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

sealed class ExportResult {}

class ExportSuccess extends ExportResult {
  ExportSuccess(this.tempFilePath);
  final String tempFilePath;
}

class ExportEmpty extends ExportResult {}

class ExportError extends ExportResult {
  ExportError(this.message);
  final String message;
}

/// Koordinator export PDF. Semua operasi berjalan lokal di device.
/// Tidak memanggil Gemini atau network.
class ReportExportService {
  ReportExportService({required this.financeQuery, required this.calorieQuery});

  final FinanceReportQuery financeQuery;
  final CalorieReportQuery calorieQuery;

  /// Generate finance PDF dan preview menggunakan Printing.
  /// Mengembalikan [ExportResult] untuk error handling.
  Future<ExportResult> exportFinance(ReportDateRange range) async {
    try {
      final data = await financeQuery.fetch(range);
      if (data.isEmpty) return ExportEmpty();
      final doc = await const FinancePdfBuilder().build(data);
      final bytes = await doc.save();
      final path = await _saveTempFile(bytes, _filenameFinance(data));
      return ExportSuccess(path);
    } on Object catch (e) {
      return ExportError('Gagal membuat laporan keuangan: ${e.runtimeType}');
    }
  }

  /// Generate calorie PDF dan preview menggunakan Printing.
  Future<ExportResult> exportCalorie(ReportDateRange range) async {
    try {
      final data = await calorieQuery.fetch(range);
      if (data.isEmpty) return ExportEmpty();
      final doc = await const CaloriePdfBuilder().build(data);
      final bytes = await doc.save();
      final path = await _saveTempFile(bytes, _filenameCalorie(data));
      return ExportSuccess(path);
    } on Object catch (e) {
      return ExportError('Gagal membuat laporan kalori: ${e.runtimeType}');
    }
  }

  /// Preview PDF menggunakan native print/share dialog.
  /// Mengembalikan false jika user membatalkan.
  Future<bool> previewFinance(ReportDateRange range) async {
    final data = await financeQuery.fetch(range);
    if (data.isEmpty) return false;
    final doc = await const FinancePdfBuilder().build(data);
    return _openPreview(doc, _filenameFinance(data));
  }

  Future<bool> previewCalorie(ReportDateRange range) async {
    final data = await calorieQuery.fetch(range);
    if (data.isEmpty) return false;
    final doc = await const CaloriePdfBuilder().build(data);
    return _openPreview(doc, _filenameCalorie(data));
  }

  Future<bool> _openPreview(pw.Document doc, String filename) async {
    try {
      final bytes = await doc.save();
      return Printing.layoutPdf(onLayout: (_) async => bytes, name: filename);
    } on Object {
      return false;
    }
  }

  Future<String> _saveTempFile(List<int> bytes, String filename) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// Bersihkan file temp setelah tidak dibutuhkan.
  Future<void> cleanupTempFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } on Object {
      // Abaikan error cleanup
    }
  }

  String _filenameFinance(FinanceReportData data) {
    final periodSlug = _sanitize(data.periodName);
    return 'KeySpace_Laporan_Keuangan_$periodSlug.pdf';
  }

  String _filenameCalorie(CalorieReportData data) {
    final start = _dateSlug(data.rangeStart);
    final end = _dateSlug(data.rangeEnd);
    return 'KeySpace_Laporan_Kalori_${start}_$end.pdf';
  }

  String _sanitize(String value) {
    return value
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), '_');
  }

  String _dateSlug(DateTime d) {
    final y = d.year.toString();
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}
