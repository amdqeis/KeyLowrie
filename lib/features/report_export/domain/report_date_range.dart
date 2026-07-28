import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/financial_period_resolver.dart';

/// Preset rentang tanggal laporan.
enum ReportRangePreset {
  today,
  last7Days,
  last30Days,
  activePeriod,
  specificPeriod,
  custom,
}

extension ReportRangePresetLabel on ReportRangePreset {
  String get label => switch (this) {
    ReportRangePreset.today => 'Hari ini',
    ReportRangePreset.last7Days => '7 hari terakhir',
    ReportRangePreset.last30Days => '30 hari terakhir',
    ReportRangePreset.activePeriod => 'Periode aktif',
    ReportRangePreset.specificPeriod => 'Periode tertentu',
    ReportRangePreset.custom => 'Rentang tanggal kustom',
  };
}

/// Rentang tanggal yang digunakan untuk query laporan.
/// [start] dan [end] bersifat inklusif, sudah dinormalisasi ke waktu lokal.
class ReportDateRange {

  factory ReportDateRange.today() {
    final now = FinancialPeriodResolver.normalize(DateTime.now());
    return ReportDateRange(
      start: now,
      end: now,
      label: 'Hari ini (${_formatDate(now)})',
    );
  }

  factory ReportDateRange.last7Days() {
    final end = FinancialPeriodResolver.normalize(DateTime.now());
    final start = end.subtract(const Duration(days: 6));
    return ReportDateRange(start: start, end: end, label: '7 hari terakhir');
  }

  factory ReportDateRange.last30Days() {
    final end = FinancialPeriodResolver.normalize(DateTime.now());
    final start = end.subtract(const Duration(days: 29));
    return ReportDateRange(start: start, end: end, label: '30 hari terakhir');
  }

  factory ReportDateRange.fromPeriod(FinancialPeriod period) {
    final start = FinancialPeriodResolver.normalize(period.startDate);
    final end = FinancialPeriodResolver.normalize(period.endDate);
    return ReportDateRange(
      start: start,
      end: end,
      label: period.name,
      periodName: period.name,
    );
  }

  factory ReportDateRange.custom(DateTime start, DateTime end) {
    final s = FinancialPeriodResolver.normalize(start);
    final e = FinancialPeriodResolver.normalize(end);
    return ReportDateRange(
      start: s,
      end: e,
      label: '${_formatDate(s)} – ${_formatDate(e)}',
    );
  }
  const ReportDateRange({
    required this.start,
    required this.end,
    required this.label,
    this.periodName,
  });

  final DateTime start;
  final DateTime end;
  final String label;

  /// Nama periode keuangan (hanya diisi saat preset = activePeriod / specificPeriod)
  final String? periodName;

  static String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  String get formattedRange => '${_formatDate(start)} – ${_formatDate(end)}';

  /// Konversi start/end ke string 'yyyy-MM-dd' untuk query Drift.
  String get startKey =>
      '${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}';

  String get endKey =>
      '${end.year}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}';

  /// Jumlah hari total dalam rentang (inklusif).
  int get totalDays => end.difference(start).inDays + 1;
}
