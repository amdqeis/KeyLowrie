import 'package:keyspace/features/report_export/domain/report_models.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Membangun PDF laporan kalori secara lokal.
/// Tidak ada network call, tidak memanggil Gemini.
/// Nilai nutrisi null ditampilkan sebagai 'N/A' — tidak direkayasa.
class CaloriePdfBuilder {
  const CaloriePdfBuilder();

  Future<pw.Document> build(CalorieReportData data) async {
    final doc = pw.Document(
      title: 'KeySpace Laporan Kalori',
      author: 'KeySpace',
    );

    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
      italic: pw.Font.helveticaOblique(),
      boldItalic: pw.Font.helveticaBoldOblique(),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 36),
          theme: theme,
          buildBackground: (_) => pw.SizedBox(),
        ),
        footer: _buildFooter,
        build: (ctx) => [
          _buildHeader(data),
          pw.SizedBox(height: 16),
          _buildSummary(data),
          pw.SizedBox(height: 20),
          _buildDailySummaryTable(data),
          pw.SizedBox(height: 20),
          _buildFoodItemsTable(data),
          pw.SizedBox(height: 16),
          _buildDisclaimer(),
        ],
      ),
    );

    return doc;
  }

  pw.Widget _buildHeader(CalorieReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'KEYSPACE',
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Laporan Kalori dan Nutrisi',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          '${_fmtDate(data.rangeStart)} – ${_fmtDate(data.rangeEnd)}',
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          'Dibuat: ${_fmtDateTime(data.generatedAt)}',
          style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.Divider(thickness: 2, color: PdfColors.black),
      ],
    );
  }

  pw.Widget _buildSummary(CalorieReportData data) {
    final avgCal = data.avgCalories;
    final avgProtein = data.avgProtein;
    final avgCarbs = data.avgCarbs;
    final avgFat = data.avgFat;
    final hasMacro = avgProtein != null || avgCarbs != null || avgFat != null;
    final targetCal = data.defaultTargetCalories;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'RINGKASAN',
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        pw.Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(2),
          },
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          children: [
            _summaryRow(
              'Total Kalori (semua hari)',
              data.foodItems.isEmpty
                  ? '0 kkal'
                  : '${data.dailySummaries.fold(0.0, (s, d) => s + d.totalCalories).round()} kkal',
            ),
            _summaryRow(
              'Rata-rata Kalori Harian',
              avgCal != null ? '${avgCal.round()} kkal' : 'N/A',
              note: 'dihitung dari hari yang punya data saja',
            ),
            _summaryRow(
              'Target Kalori Harian',
              targetCal != null ? '$targetCal kkal' : 'Belum diatur',
            ),
            _summaryRow('Hari yang memiliki data', '${data.daysWithData} hari'),
            _summaryRow('Hari tanpa data', '${data.daysWithoutData} hari'),
            _summaryRow('Hari di bawah target', '${data.daysBelowTarget} hari'),
            _summaryRow('Hari mencapai target', '${data.daysAtTarget} hari'),
            _summaryRow('Hari di atas target', '${data.daysAboveTarget} hari'),
            if (hasMacro) ...[
              _summaryRow(
                'Rata-rata Protein',
                avgProtein != null
                    ? '${avgProtein.toStringAsFixed(1)} g'
                    : 'Data tidak tersedia',
              ),
              _summaryRow(
                'Rata-rata Karbohidrat',
                avgCarbs != null
                    ? '${avgCarbs.toStringAsFixed(1)} g'
                    : 'Data tidak tersedia',
              ),
              _summaryRow(
                'Rata-rata Lemak',
                avgFat != null
                    ? '${avgFat.toStringAsFixed(1)} g'
                    : 'Data tidak tersedia',
              ),
            ] else
              _summaryRow('Rata-rata Makro', 'Data tidak tersedia'),
          ],
        ),
      ],
    );
  }

  pw.TableRow _summaryRow(String label, String value, {String? note}) {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.white),
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
              if (note != null)
                pw.Text(
                  note,
                  style: pw.TextStyle(fontSize: 7.5, color: PdfColors.grey600),
                ),
            ],
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(value, style: const pw.TextStyle(fontSize: 9)),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildDailySummaryTable(CalorieReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'RINGKASAN HARIAN',
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        if (data.dailySummaries.isEmpty)
          pw.Text(
            'Tidak ada data pada rentang ini.',
            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          )
        else
          pw.TableHelper.fromTextArray(
            headers: [
              'Tanggal',
              'Kalori',
              'Target',
              'Selisih',
              'Protein',
              'Karbo',
              'Lemak',
            ],
            data: data.dailySummaries.map((d) {
              final diff = d.difference;
              final diffStr = diff != null
                  ? '${diff >= 0 ? '+' : ''}${diff.round()}'
                  : 'N/A';
              return [
                _fmtDate(d.date),
                '${d.totalCalories.round()}',
                d.targetCalories != null ? '${d.targetCalories}' : 'N/A',
                diffStr,
                d.proteinG != null
                    ? '${d.proteinG!.toStringAsFixed(1)}g'
                    : 'N/A',
                d.carbsG != null ? '${d.carbsG!.toStringAsFixed(1)}g' : 'N/A',
                d.fatG != null ? '${d.fatG!.toStringAsFixed(1)}g' : 'N/A',
              ];
            }).toList(),
            columnWidths: {
              0: const pw.FixedColumnWidth(60),
              1: const pw.FixedColumnWidth(42),
              2: const pw.FixedColumnWidth(42),
              3: const pw.FixedColumnWidth(42),
              4: const pw.FixedColumnWidth(42),
              5: const pw.FixedColumnWidth(42),
              6: const pw.FixedColumnWidth(42),
            },
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            headerStyle: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
            cellDecoration: (_, _, _) =>
                const pw.BoxDecoration(color: PdfColors.white),
            headerPadding: const pw.EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 3,
            ),
            cellPadding: const pw.EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 3,
            ),
          ),
      ],
    );
  }

  pw.Widget _buildFoodItemsTable(CalorieReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'DAFTAR MAKANAN',
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        if (data.foodItems.isEmpty)
          pw.Text(
            'Tidak ada catatan makanan.',
            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          )
        else
          pw.TableHelper.fromTextArray(
            headers: [
              'Tanggal',
              'Nama Makanan',
              'Porsi',
              'Kalori',
              'Protein',
              'Karbo',
              'Lemak',
            ],
            data: data.foodItems.map((item) {
              return [
                _fmtDate(item.date),
                item.foodName,
                item.portionText,
                '${item.caloriesKcal.round()}',
                item.proteinG != null
                    ? '${item.proteinG!.toStringAsFixed(1)}g'
                    : 'N/A',
                item.carbsG != null
                    ? '${item.carbsG!.toStringAsFixed(1)}g'
                    : 'N/A',
                item.fatG != null ? '${item.fatG!.toStringAsFixed(1)}g' : 'N/A',
              ];
            }).toList(),
            columnWidths: {
              0: const pw.FixedColumnWidth(58),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FixedColumnWidth(40),
              4: const pw.FixedColumnWidth(40),
              5: const pw.FixedColumnWidth(40),
              6: const pw.FixedColumnWidth(40),
            },
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            headerStyle: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
            cellDecoration: (_, _, _) =>
                const pw.BoxDecoration(color: PdfColors.white),
            headerPadding: const pw.EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 3,
            ),
            cellPadding: const pw.EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 3,
            ),
          ),
      ],
    );
  }

  pw.Widget _buildDisclaimer() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
        color: PdfColors.grey50,
      ),
      child: pw.Text(
        'Informasi kalori dan nutrisi pada laporan ini dapat berupa estimasi '
        'berdasarkan input pengguna dan hasil pemrosesan AI. Laporan ini bukan '
        'pengganti saran medis atau konsultasi tenaga kesehatan.',
        style: pw.TextStyle(
          fontSize: 7.5,
          color: PdfColors.grey700,
          fontStyle: pw.FontStyle.italic,
        ),
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context ctx) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Dibuat oleh KeySpace',
          style: pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
        pw.Text(
          'Halaman ${ctx.pageNumber} dari ${ctx.pagesCount}',
          style: pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
      ],
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  String _fmtDate(DateTime d) {
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

  String _fmtDateTime(DateTime d) {
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '${_fmtDate(d)} $h:$m';
  }
}
