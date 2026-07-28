import 'package:keyspace/features/report_export/domain/report_models.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Membangun PDF laporan keuangan secara lokal.
/// Tidak ada network call, tidak memanggil Gemini.
class FinancePdfBuilder {
  const FinancePdfBuilder();

  Future<pw.Document> build(FinanceReportData data) async {
    final doc = pw.Document(
      title: 'KeySpace Laporan Keuangan',
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
          _buildSummaryTable(data),
          pw.SizedBox(height: 20),
          _buildCategorySection(
            'BREAKDOWN PENGELUARAN',
            data.expenseCategories,
          ),
          if (data.incomeCategories.isNotEmpty) ...[
            pw.SizedBox(height: 16),
            _buildCategorySection('BREAKDOWN PEMASUKAN', data.incomeCategories),
          ],
          pw.SizedBox(height: 20),
          _buildTransactionsSection(data),
        ],
      ),
    );

    return doc;
  }

  pw.Widget _buildHeader(FinanceReportData data) {
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
          'Laporan Keuangan',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 2),
        pw.Text(data.periodName, style: const pw.TextStyle(fontSize: 11)),
        pw.Text(
          '${_fmtDate(data.rangeStart)} – ${_fmtDate(data.rangeEnd)}',
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          'Dibuat: ${_fmtDateTime(data.generatedAt)}  •  Mata uang: ${data.currencyCode}',
          style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.Divider(thickness: 2, color: PdfColors.black),
      ],
    );
  }

  pw.Widget _buildSummaryTable(FinanceReportData data) {
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
            _summaryRow('Budget Periode', _fmtIdr(data.budgetAmount)),
            _summaryRow(
              'Penggunaan Budget',
              _fmtIdr(data.budgetUsage),
              note: '(tidak termasuk reimburse)',
            ),
            _summaryRow(
              'Sisa Budget',
              _fmtIdr(data.remainingBudget),
              isNegative: data.remainingBudget < 0,
            ),
            _summaryRow('Total Pengeluaran', _fmtIdr(data.totalExpense)),
            _summaryRow('Total Pemasukan', _fmtIdr(data.totalIncome)),
            _summaryRow(
              'Saldo Bersih',
              _fmtIdr(data.netBalance),
              isNegative: data.netBalance < 0,
              isBold: true,
            ),
            _summaryRow('Total Reimburse', _fmtIdr(data.totalReimburse)),
            _summaryRow(
              'Jml Transaksi Pengeluaran',
              data.expenseCount.toString(),
            ),
            _summaryRow('Jml Transaksi Pemasukan', data.incomeCount.toString()),
          ],
        ),
      ],
    );
  }

  pw.TableRow _summaryRow(
    String label,
    String value, {
    String? note,
    bool isNegative = false,
    bool isBold = false,
  }) {
    final style = pw.TextStyle(
      fontSize: 9,
      fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      color: isNegative ? PdfColors.red700 : PdfColors.black,
    );
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.white),
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(label, style: style),
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
            child: pw.Text(value, style: style),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildCategorySection(
    String title,
    List<FinanceCategoryRow> categories,
  ) {
    if (categories.isEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Tidak ada data.',
            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
        ],
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        pw.Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(2),
          },
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          children: [_catHeaderRow(), ...categories.map(_catRow)],
        ),
      ],
    );
  }

  pw.TableRow _catHeaderRow() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
      children: [
        _cellHeader('Kategori'),
        _cellHeader('Jml', align: pw.Alignment.centerRight),
        _cellHeader('Total', align: pw.Alignment.centerRight),
      ],
    );
  }

  pw.TableRow _catRow(FinanceCategoryRow row) {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.white),
      children: [
        _cell(row.categoryName),
        _cell(row.transactionCount.toString(), align: pw.Alignment.centerRight),
        _cell(_fmtIdr(row.total), align: pw.Alignment.centerRight),
      ],
    );
  }

  pw.Widget _buildTransactionsSection(FinanceReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'DAFTAR TRANSAKSI',
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        if (data.transactions.isEmpty)
          pw.Text(
            'Tidak ada transaksi pada rentang ini.',
            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          )
        else
          pw.TableHelper.fromTextArray(
            headers: [
              'Tanggal',
              'Jenis',
              'Nama',
              'Kategori',
              'Reimburse',
              'Nominal',
            ],
            data: data.transactions.map((tx) {
              final typeLabel = tx.type == 'expense'
                  ? 'Pengeluaran'
                  : 'Pemasukan';
              final reimburseLabel = tx.type == 'expense'
                  ? (tx.isReimburse ? 'Ya' : 'Tidak')
                  : '-';
              return [
                _fmtDate(tx.date),
                typeLabel,
                tx.name,
                tx.categoryName,
                reimburseLabel,
                '${tx.type == 'expense' ? '-' : '+'}${_fmtIdr(tx.amount)}',
              ];
            }).toList(),
            columnWidths: {
              0: const pw.FixedColumnWidth(58),
              1: const pw.FixedColumnWidth(62),
              2: const pw.FlexColumnWidth(3),
              3: const pw.FlexColumnWidth(2),
              4: const pw.FixedColumnWidth(48),
              5: const pw.FixedColumnWidth(80),
            },
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            headerStyle: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
            cellDecoration: (_, _, _) =>
                const pw.BoxDecoration(color: PdfColors.white),
            headerAlignment: pw.Alignment.centerLeft,
            cellAlignment: pw.Alignment.centerLeft,
            headerPadding: const pw.EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 3,
            ),
            cellPadding: const pw.EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 3,
            ),
          ),
      ],
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

  pw.Widget _cellHeader(
    String text, {
    pw.Alignment align = pw.Alignment.centerLeft,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: pw.Align(
        alignment: align,
        child: pw.Text(
          text,
          style: pw.TextStyle(fontSize: 8.5, fontWeight: pw.FontWeight.bold),
        ),
      ),
    );
  }

  pw.Widget _cell(String text, {pw.Alignment align = pw.Alignment.centerLeft}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: pw.Align(
        alignment: align,
        child: pw.Text(text, style: const pw.TextStyle(fontSize: 8.5)),
      ),
    );
  }

  String _fmtIdr(int amount) {
    final negative = amount < 0;
    final digits = amount.abs().toString();
    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buf.write('.');
      buf.write(digits[i]);
    }
    return '${negative ? '-' : ''}Rp ${buf.toString()}';
  }

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
    final date = _fmtDate(d);
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '$date $h:$m';
  }
}
