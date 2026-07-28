import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/features/report_export/domain/report_date_range.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';
import 'package:keyspace/features/report_export/presentation/export_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

/// Menampilkan bottom sheet untuk mengonfigurasi dan men-export laporan PDF.
///
/// [initialType] menentukan jenis laporan yang dipilih saat pertama dibuka.
Future<void> showExportConfigSheet(
  BuildContext context, {
  ReportType initialType = ReportType.finance,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _ExportConfigSheet(initialType: initialType),
  );
}

class _ExportConfigSheet extends ConsumerStatefulWidget {
  const _ExportConfigSheet({required this.initialType});

  final ReportType initialType;

  @override
  ConsumerState<_ExportConfigSheet> createState() => _ExportConfigSheetState();
}

class _ExportConfigSheetState extends ConsumerState<_ExportConfigSheet> {
  late ReportType _reportType;
  ReportRangePreset _preset = ReportRangePreset.activePeriod;
  FinancialPeriod? _selectedPeriod;
  DateTimeRange? _customRange;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _reportType = widget.initialType;
    // Kalori default ke 7 hari terakhir
    if (_reportType == ReportType.calorie) {
      _preset = ReportRangePreset.last7Days;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.onSurface,
                width: 3,
              ),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  children: [
                    const Text(
                      'EXPORT LAPORAN PDF',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Jenis Laporan ──────────────────────────────────────
                    const Text(
                      'JENIS LAPORAN',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _TypeButton(
                            label: 'Laporan\nKeuangan',
                            icon: Icons.account_balance_wallet_outlined,
                            selected: _reportType == ReportType.finance,
                            onTap: _isLoading
                                ? null
                                : () => setState(() {
                                    _reportType = ReportType.finance;
                                    _preset = ReportRangePreset.activePeriod;
                                    _selectedPeriod = null;
                                    _customRange = null;
                                    _errorMessage = null;
                                  }),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TypeButton(
                            label: 'Laporan\nKalori',
                            icon: Icons.local_fire_department_outlined,
                            selected: _reportType == ReportType.calorie,
                            onTap: _isLoading
                                ? null
                                : () => setState(() {
                                    _reportType = ReportType.calorie;
                                    _preset = ReportRangePreset.last7Days;
                                    _selectedPeriod = null;
                                    _customRange = null;
                                    _errorMessage = null;
                                  }),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── Rentang Laporan ────────────────────────────────────
                    const Text(
                      'RENTANG LAPORAN',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),

                    _buildPresetChips(),

                    // Pilih periode tertentu
                    if (_preset == ReportRangePreset.specificPeriod) ...[
                      const SizedBox(height: 12),
                      _buildPeriodPicker(),
                    ],

                    // Rentang kustom
                    if (_preset == ReportRangePreset.custom) ...[
                      const SizedBox(height: 12),
                      _buildCustomRangePicker(),
                    ],

                    const SizedBox(height: 24),

                    // ── Error ──────────────────────────────────────────────
                    if (_errorMessage != null) ...[
                      BrutalCard(
                        color: const Color(0xFFFFCDD2),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // ── Preview Button ─────────────────────────────────────
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      BrutalButton(
                        label: 'PREVIEW PDF',
                        icon: Icons.picture_as_pdf,
                        onPressed: _canPreview ? _runPreview : null,
                      ),
                    const SizedBox(height: 8),
                    const Text(
                      'Preview membuka dialog simpan / cetak / bagikan.',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPresetChips() {
    // Sembunyikan presets yang tidak relevan per tipe laporan
    final presets = ReportRangePreset.values.where((preset) {
      if (_reportType == ReportType.calorie &&
          (preset == ReportRangePreset.activePeriod ||
              preset == ReportRangePreset.specificPeriod)) {
        return false;
      }
      return true;
    }).toList();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: presets.map((preset) {
        return ChoiceChip(
          key: ValueKey('export-preset-${preset.name}'),
          label: Text(preset.label),
          selected: _preset == preset,
          onSelected: _isLoading
              ? null
              : (_) => setState(() {
                  _preset = preset;
                  _selectedPeriod = null;
                  _customRange = null;
                  _errorMessage = null;
                }),
        );
      }).toList(),
    );
  }

  Widget _buildPeriodPicker() {
    final periods = ref.watch(financePeriodsProvider);
    return periods.when(
      data: (values) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Periode:',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          ...values.map((period) {
            final isSelected = _selectedPeriod?.id == period.id;
            return ListTile(
              key: ValueKey('period-radio-${period.id}'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<String>(
                value: period.id,
                groupValue: _selectedPeriod?.id,
                onChanged: _isLoading
                    ? null
                    : (_) => setState(() {
                          _selectedPeriod = period;
                          _errorMessage = null;
                        }),
              ),
              title: Text(
                period.name,
                style: TextStyle(
                  fontWeight:
                      isSelected ? FontWeight.w800 : FontWeight.normal,
                ),
              ),
              subtitle: Text(
                '${_fmtDate(period.startDate)} – ${_fmtDate(period.endDate)}',
                style: const TextStyle(fontSize: 12),
              ),
              onTap: _isLoading
                  ? null
                  : () => setState(() {
                        _selectedPeriod = period;
                        _errorMessage = null;
                      }),
            );
          }),
        ],
      ),
      loading: () => const LinearProgressIndicator(),
      error: (_, _) => const Text('Gagal memuat daftar periode.'),
    );
  }

  Widget _buildCustomRangePicker() {
    final start = _customRange?.start;
    final end = _customRange?.end;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          key: const ValueKey('export-pick-daterange'),
          onPressed: _isLoading ? null : _pickCustomRange,
          icon: const Icon(Icons.date_range),
          label: Text(
            start != null && end != null
                ? '${_fmtDate(start)} – ${_fmtDate(end)}'
                : 'Pilih rentang tanggal',
          ),
        ),
      ],
    );
  }

  bool get _canPreview {
    if (_preset == ReportRangePreset.specificPeriod &&
        _selectedPeriod == null) {
      return false;
    }
    if (_preset == ReportRangePreset.custom && _customRange == null) {
      return false;
    }
    return true;
  }

  ReportDateRange _buildRange() {
    return switch (_preset) {
      ReportRangePreset.today => ReportDateRange.today(),
      ReportRangePreset.last7Days => ReportDateRange.last7Days(),
      ReportRangePreset.last30Days => ReportDateRange.last30Days(),
      ReportRangePreset.activePeriod =>
        _selectedPeriod != null
            ? ReportDateRange.fromPeriod(_selectedPeriod!)
            : ReportDateRange.last30Days(), // fallback
      ReportRangePreset.specificPeriod => ReportDateRange.fromPeriod(
        _selectedPeriod!,
      ),
      ReportRangePreset.custom => ReportDateRange.custom(
        _customRange!.start,
        _customRange!.end,
      ),
    };
  }

  Future<void> _pickCustomRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _customRange,
    );
    if (range != null && mounted) {
      setState(() => _customRange = range);
    }
  }

  Future<void> _runPreview() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final service = ref.read(reportExportServiceProvider);
      final range = _buildRange();
      bool success;
      if (_reportType == ReportType.finance) {
        // Coba ambil periode aktif jika preset = activePeriod
        final effectiveRange = await _resolveActivePeriodRange(range);
        success = await service.previewFinance(effectiveRange);
      } else {
        success = await service.previewCalorie(range);
      }
      if (!mounted) return;
      if (!success) {
        setState(
          () => _errorMessage =
              'Tidak ada data pada rentang yang dipilih, atau preview dibatalkan.',
        );
      }
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Gagal membuat PDF. Coba lagi.');
      debugPrint('Export error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Resolve periode aktif dari database jika preset = activePeriod
  Future<ReportDateRange> _resolveActivePeriodRange(
    ReportDateRange fallback,
  ) async {
    if (_preset != ReportRangePreset.activePeriod) return fallback;
    try {
      final periods = ref.read(financePeriodsProvider).value;
      if (periods == null || periods.isEmpty) return fallback;
      // Periode aktif = periode yang mengandung tanggal hari ini
      final now = DateTime.now();
      final active = periods.firstWhere(
        (p) => !now.isBefore(p.startDate) && !now.isAfter(p.endDate),
        orElse: () => periods.first,
      );
      return ReportDateRange.fromPeriod(active);
    } on Object {
      return fallback;
    }
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
}

// ─── Sub-widget ─────────────────────────────────────────────────────────────

class _TypeButton extends StatelessWidget {
  const _TypeButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFD60A) : Colors.transparent,
          border: Border.all(color: ink, width: 2.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: ink),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
