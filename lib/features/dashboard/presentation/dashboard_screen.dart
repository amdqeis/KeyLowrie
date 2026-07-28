import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/report_export/domain/report_models.dart';
import 'package:keyspace/features/report_export/presentation/export_config_sheet.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

final dailyLogsProvider = StreamProvider.family<List<FoodLog>, String>(
  (ref, date) => ref.watch(foodLogRepositoryProvider).watchLogsForDate(date),
);

final dailyTotalProvider = StreamProvider.family<DailyNutritionTotal, String>(
  (ref, date) => ref.watch(foodLogRepositoryProvider).watchTotal(date),
);

final effectiveTargetProvider = StreamProvider.family<DailyTarget?, String>(
  (ref, date) => ref.watch(targetRepositoryProvider).watchEffectiveTarget(date),
);

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final key = localDateKey(_date);
    final logs = ref.watch(dailyLogsProvider(key));
    final total = ref.watch(dailyTotalProvider(key));
    final target = ref.watch(effectiveTargetProvider(key));
    final drafts = ref.watch(pendingDraftsProvider).value ?? const <FoodLog>[];
    final apiKeys =
        ref.watch(apiKeysStreamProvider).value ?? const <ApiKeyMetadataData>[];
    final unhealthy =
        apiKeys.isNotEmpty &&
        apiKeys.every(
          (item) =>
              !item.isEnabled ||
              {
                'invalid',
                'blocked',
                'secret_unavailable',
              }.contains(item.healthStatus),
        );
    final ink = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HARI INI'),
        actions: [
          IconButton(
            tooltip: 'Export laporan kalori',
            onPressed: () =>
                showExportConfigSheet(context, initialType: ReportType.calorie),
            icon: const Icon(Icons.picture_as_pdf_outlined),
          ),
          IconButton(
            tooltip: 'Pilih tanggal',
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: KeySpaceColors.ink,
        backgroundColor: KeySpaceColors.signalYellow,
        onRefresh: () async {
          ref.invalidate(dailyLogsProvider(key));
          ref.invalidate(dailyTotalProvider(key));
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          children: [
            // ── Date header ──────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _dayLabel(_date),
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    color: ink,
                    height: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6, left: 8),
                  child: Text(
                    _monthYearLabel(_date),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: ink.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _weekdayLabel(_date),
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: ink.withValues(alpha: 0.5),
                letterSpacing: 1.2,
              ),
            ),

            // ── Alert banners ─────────────────────────────────────
            if (drafts.isNotEmpty) ...[
              const SizedBox(height: 14),
              BrutalCard(
                color: const Color(0xFFFFE79A),
                delay: const Duration(milliseconds: 60),
                child: Row(
                  children: [
                    const Icon(Icons.edit_note),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${drafts.length} pencatatan belum selesai.',
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    BrutalButton(
                      label: 'LANJUTKAN',
                      fullWidth: false,
                      onPressed: () => context.go(AppRoutes.chat),
                    ),
                  ],
                ),
              ),
            ],
            if (apiKeys.isEmpty || unhealthy) ...[
              const SizedBox(height: 12),
              BrutalCard(
                delay: const Duration(milliseconds: 100),
                child: Row(
                  children: [
                    const Icon(Icons.key_off),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'AI belum tersedia. Fitur lokal tetap aktif.',
                      ),
                    ),
                    BrutalButton(
                      label: 'PERIKSA',
                      fullWidth: false,
                      secondary: true,
                      onPressed: () => context.push(AppRoutes.apiKeys),
                    ),
                  ],
                ),
              ),
            ],

            // ── Calorie progress ─────────────────────────────────
            const SizedBox(height: 18),
            BrutalCard(
              color: KeySpaceColors.signalYellow,
              delay: const Duration(milliseconds: 80),
              child: total.when(
                data: (value) => CalorieProgressBar(
                  consumed: value.caloriesKcal,
                  target: target.value?.calorieTarget,
                ),
                loading: () => const Center(child: BrutalProgressIndicator()),
                error: (_, _) => const Text('Ringkasan belum dapat dibuka.'),
              ),
            ),

            // ── Macros ───────────────────────────────────────────
            const SizedBox(height: 14),
            total.when(
              data: (value) => Row(
                children: [
                  _Macro(
                    label: 'PROTEIN',
                    value: value.proteinG,
                    color: const Color(0xFFE8F4FD),
                    delay: const Duration(milliseconds: 120),
                  ),
                  _Macro(
                    label: 'KARBO',
                    value: value.carbsG,
                    color: const Color(0xFFFFF9E6),
                    delay: const Duration(milliseconds: 180),
                  ),
                  _Macro(
                    label: 'LEMAK',
                    value: value.fatG,
                    color: const Color(0xFFFBEDEA),
                    delay: const Duration(milliseconds: 240),
                  ),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),

            // ── Target CTA ───────────────────────────────────────
            if (target.value == null) ...[
              const SizedBox(height: 16),
              BrutalButton(
                label: 'ATUR TARGET KALORI',
                icon: Icons.flag_outlined,
                secondary: true,
                onPressed: () => context.push(AppRoutes.profile),
              ),
            ],

            // ── Action buttons ───────────────────────────────────
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: BrutalButton(
                    label: 'CHAT AI',
                    icon: Icons.chat_bubble_outline,
                    onPressed: () => context.go(AppRoutes.chat),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BrutalButton(
                    label: 'MANUAL',
                    icon: Icons.add,
                    secondary: true,
                    onPressed: () =>
                        context.push('/food-log/new/edit?date=$key'),
                  ),
                ),
              ],
            ),

            // ── Food log list ─────────────────────────────────────
            const SizedBox(height: 24),
            const BrutalSectionHeader('CATATAN MAKAN'),
            const SizedBox(height: 12),
            logs.when(
              data: (values) => values.isEmpty
                  ? EmptyState(
                      title: 'BELUM ADA MAKANAN',
                      message:
                          'Catat lewat chat atau masukkan nilai nutrisi secara manual.',
                      action: BrutalButton(
                        label: 'CATAT MAKANAN',
                        icon: Icons.chat_bubble_outline,
                        onPressed: () => context.go(AppRoutes.chat),
                      ),
                    )
                  : Column(
                      children: values
                          .asMap()
                          .entries
                          .map((e) => _logCard(e.value, e.key))
                          .toList(),
                    ),
              loading: () => const Center(child: BrutalProgressIndicator()),
              error: (_, _) => const EmptyState(
                title: 'DATA BELUM DAPAT DIBUKA',
                message: 'Tarik layar untuk mencoba lagi.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logCard(FoodLog log, int index) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: BrutalCard(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
        delay: Duration(milliseconds: 60 + index * 50),
        child: Row(
          children: [
            // Meal type accent strip
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: KeySpaceColors.signalYellow,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => context.push('/food-log/${log.id}/edit'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (log.originalUserText?.trim().isNotEmpty ?? false)
                          ? log.originalUserText!
                          : log.mealType.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${log.mealType.toUpperCase()} • ${_time(log.consumedAtUtc.toLocal())}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ink.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  log.totalCaloriesKcal.round().toString(),
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ink,
                  ),
                ),
                Text(
                  'KKAL',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    color: ink.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            IconButton(
              tooltip: 'Hapus Food Log',
              onPressed: () => _delete(log),
              icon: Icon(
                Icons.delete_outline,
                color: ink.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete(FoodLog log) async {
    final repository = ref.read(foodLogRepositoryProvider);
    final deletedAt = DateTime.now();
    await repository.softDelete(log.id, deletedAt);
    await ref.read(reminderCoordinatorProvider).reconcileDate(log.localDate);
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: ProviderConfig.undoWindow,
        content: const Text('Food Log dihapus'),
        action: SnackBarAction(
          label: 'URUNGKAN',
          onPressed: () async {
            await repository.undoDelete(log.id);
            await ref
                .read(reminderCoordinatorProvider)
                .reconcileDate(log.localDate);
          },
        ),
      ),
    );
    unawaited(
      Future<void>.delayed(ProviderConfig.undoWindow, () async {
        await repository.purgeExpiredDeletes(DateTime.now());
      }),
    );
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (value != null) setState(() => _date = value);
  }

  String _dayLabel(DateTime d) => d.day.toString().padLeft(2, '0');
  String _monthYearLabel(DateTime d) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MEI',
      'JUN',
      'JUL',
      'AGS',
      'SEP',
      'OKT',
      'NOV',
      'DES',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }

  String _weekdayLabel(DateTime d) {
    const days = [
      'SENIN',
      'SELASA',
      'RABU',
      'KAMIS',
      'JUMAT',
      'SABTU',
      'MINGGU',
    ];
    return days[d.weekday - 1];
  }

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}

class _Macro extends StatelessWidget {
  const _Macro({
    required this.label,
    required this.value,
    required this.color,
    required this.delay,
  });
  final String label;
  final double? value;
  final Color color;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: BrutalCard(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          color: color,
          delay: delay,
          child: Column(
            children: [
              Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  letterSpacing: 1.0,
                  color: ink.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${(value ?? 0).round()}',
                style: GoogleFonts.ibmPlexMono(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: ink,
                ),
              ),
              Text(
                'gram',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: ink.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
