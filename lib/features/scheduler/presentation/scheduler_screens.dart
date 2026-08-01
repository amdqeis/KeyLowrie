import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

// ─── Upcoming schedules provider ────────────────────────────────────────────

/// Mengembalikan semua item jadwal yang dimulai/jatuh tempo dalam [hoursAhead] jam
/// ke depan dan belum selesai — dipakai sebagai pengingat mendekati.
final upcomingSchedulesProvider = Provider<List<ScheduleItem>>((ref) {
  final now = DateTime.now();
  final horizon = now.add(const Duration(hours: 24));
  final items =
      ref.watch(scheduleItemsProvider).value ?? const <ScheduleItem>[];
  return items.where((item) {
    if (item.status != 'pending') return false;
    // Ambil waktu mulai atau deadline
    final anchor =
        item.startAtUtc?.toLocal() ??
        item.dueAtUtc?.toLocal() ??
        _localDateToDateTime(item.localStartDate ?? item.dueDateLocal);
    if (anchor == null) return false;
    return anchor.isAfter(now) && anchor.isBefore(horizon);
  }).toList()..sort((a, b) {
    final aT = a.startAtUtc ?? a.dueAtUtc;
    final bT = b.startAtUtc ?? b.dueAtUtc;
    if (aT == null && bT == null) return 0;
    if (aT == null) return 1;
    if (bT == null) return -1;
    return aT.compareTo(bT);
  });
});

DateTime? _localDateToDateTime(String? dateKey) {
  if (dateKey == null) return null;
  return DateTime.tryParse(dateKey);
}

// ─── helpers ─────────────────────────────────────────────────────────────────

const _kDayNames = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];
const _kMonthNames = [
  '',
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

String _formatShortDate(DateTime d) =>
    '${_kDayNames[d.weekday - 1]}, ${d.day} ${_kMonthNames[d.month]}';

// ─── Priority helpers ─────────────────────────────────────────────────────────

Color _priorityColor(String priority) => switch (priority.toLowerCase()) {
  'high' => const Color(0xFFE4572E),
  'medium' => const Color(0xFFFFD60A),
  _ => const Color(0xFF3BB273),
};

String _priorityLabel(String priority) => switch (priority.toLowerCase()) {
  'high' => 'Prioritas Tinggi',
  'medium' => 'Prioritas Sedang',
  _ => 'Prioritas Rendah',
};

// ─────────────────────────────────────────────────────────────────────────────

enum SchedulerViewMode { hourly, daily, weekly, tasks }

class SchedulerScreen extends ConsumerStatefulWidget {
  const SchedulerScreen({super.key});

  @override
  ConsumerState<SchedulerScreen> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends ConsumerState<SchedulerScreen> {
  var _selectedDate = DateTime.now();
  var _mode = SchedulerViewMode.daily;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(scheduleItemsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('JADWAL'),
        actions: [
          IconButton(
            tooltip: 'Buat jadwal manual',
            onPressed: () => context.push(AppRoutes.schedulerNew),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.schedulerNew),
        icon: const Icon(Icons.add),
        label: const Text('BUAT'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Upcoming Reminders Banner ─────────────────────────────────
            const _UpcomingBanner(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: SegmentedButton<SchedulerViewMode>(
                segments: const [
                  ButtonSegment(
                    value: SchedulerViewMode.hourly,
                    label: Text('JAM'),
                  ),
                  ButtonSegment(
                    value: SchedulerViewMode.daily,
                    label: Text('HARI'),
                  ),
                  ButtonSegment(
                    value: SchedulerViewMode.weekly,
                    label: Text('MINGGU'),
                  ),
                  ButtonSegment(
                    value: SchedulerViewMode.tasks,
                    label: Text('TASK'),
                  ),
                ],
                selected: {_mode},
                onSelectionChanged: (selection) =>
                    setState(() => _mode = selection.first),
              ),
            ),
            if (_mode != SchedulerViewMode.tasks)
              _DateSelector(
                value: _selectedDate,
                weekly: _mode == SchedulerViewMode.weekly,
                onChanged: (value) => setState(() => _selectedDate = value),
              ),
            Expanded(
              child: items.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) =>
                    Center(child: Text('Jadwal gagal dimuat: $error')),
                data: (rows) => _ScheduleList(
                  rows: _filter(rows),
                  mode: _mode,
                  selectedDate: _selectedDate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ScheduleItem> _filter(List<ScheduleItem> rows) {
    if (_mode == SchedulerViewMode.tasks) {
      return rows.where((row) => row.itemType == 'task').toList();
    }
    final start = _mode == SchedulerViewMode.weekly
        ? _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1))
        : _selectedDate;
    final end = start.add(
      Duration(days: _mode == SchedulerViewMode.weekly ? 7 : 1),
    );
    // Normalisasi ke awal hari (midnight) agar perbandingan tanggal tidak
    // terpengaruh komponen jam yang ada di _selectedDate (dari DateTime.now()).
    final startDay = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day);
    return rows.where((row) {
      final local = row.localStartDate ?? row.dueDateLocal;
      if (local != null) {
        final parsed = DateTime.tryParse(local);
        return parsed != null &&
            !parsed.isBefore(startDay) &&
            parsed.isBefore(endDay);
      }
      final instant = row.startAtUtc ?? row.dueAtUtc;
      return instant != null &&
          !instant.toLocal().isBefore(startDay) &&
          instant.toLocal().isBefore(endDay);
    }).toList();
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({
    required this.value,
    required this.weekly,
    required this.onChanged,
  });

  final DateTime value;
  final bool weekly;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final isToday =
        !weekly &&
        value.year == DateTime.now().year &&
        value.month == DateTime.now().month &&
        value.day == DateTime.now().day;

    // For weekly: Monday of the selected week
    final weekStart = weekly
        ? value.subtract(Duration(days: value.weekday - 1))
        : null;
    final weekEnd = weekStart?.add(const Duration(days: 6));

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Row(
        children: [
          IconButton(
            tooltip: weekly ? 'Minggu sebelumnya' : 'Hari sebelumnya',
            onPressed: () =>
                onChanged(value.subtract(Duration(days: weekly ? 7 : 1))),
            icon: const Icon(Icons.chevron_left, size: 26),
          ),
          Expanded(
            child: Semantics(
              header: true,
              child: Column(
                children: [
                  if (!weekly) ...[
                    Text(
                      _kDayNames[value.weekday - 1].toUpperCase(),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: ink.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${value.day}',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: ink,
                            height: 1,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_kMonthNames[value.month]} ${value.year}',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: ink,
                          ),
                        ),
                        if (isToday) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: KeySpaceColors.signalYellow,
                              border: Border.all(color: ink, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'HARI INI',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                                color: ink,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ] else ...[
                    Text(
                      'MINGGU INI',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: ink.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${weekStart!.day} ${_kMonthNames[weekStart.month]} – '
                      '${weekEnd!.day} ${_kMonthNames[weekEnd.month]} ${weekEnd.year}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: ink,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: weekly ? 'Minggu berikutnya' : 'Hari berikutnya',
            onPressed: () =>
                onChanged(value.add(Duration(days: weekly ? 7 : 1))),
            icon: const Icon(Icons.chevron_right, size: 26),
          ),
        ],
      ),
    );
  }
}

class _ScheduleList extends ConsumerWidget {
  const _ScheduleList({
    required this.rows,
    required this.mode,
    required this.selectedDate,
  });

  final List<ScheduleItem> rows;
  final SchedulerViewMode mode;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 48,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.25),
              ),
              const SizedBox(height: 16),
              Text(
                'Belum ada jadwal',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Ketuk tombol BUAT untuk menambahkan jadwal baru.',
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // In weekly mode, group by day
    if (mode == SchedulerViewMode.weekly) {
      return _WeeklyGroupedList(rows: rows, ref: ref);
    }

    // Sort by time ascending (all-day first)
    final sorted = [...rows];
    sorted.sort((a, b) {
      final aTime = a.startAtUtc ?? a.dueAtUtc;
      final bTime = b.startAtUtc ?? b.dueAtUtc;
      if (a.allDay && !b.allDay) return -1;
      if (!a.allDay && b.allDay) return 1;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1;
      if (bTime == null) return -1;
      return aTime.compareTo(bTime);
    });

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
      itemCount: sorted.length,
      itemBuilder: (context, index) => _ScheduleCard(
        row: sorted[index],
        showDate: mode == SchedulerViewMode.tasks,
        onToggleComplete: (val) async {
          await ref
              .read(schedulerRepositoryProvider)
              .setCompleted(sorted[index].id, val);
          await ref
              .read(schedulerReminderCoordinatorProvider)
              .reconcileItem(sorted[index].id);
        },
        onTap: () =>
            context.push(AppRoutes.schedulerDetailPath(sorted[index].id)),
      ),
    );
  }
}

// ─── Weekly grouped list ──────────────────────────────────────────────────────

class _WeeklyGroupedList extends StatelessWidget {
  const _WeeklyGroupedList({required this.rows, required this.ref});
  final List<ScheduleItem> rows;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    // Group by local date key (YYYY-MM-DD)
    final Map<String, List<ScheduleItem>> groups = {};
    for (final row in rows) {
      final key =
          row.localStartDate ??
          row.dueDateLocal ??
          (row.startAtUtc ?? row.dueAtUtc)?.toLocal().toString().substring(
            0,
            10,
          ) ??
          'unknown';
      (groups[key] ??= []).add(row);
    }
    final sortedKeys = groups.keys.toList()..sort();

    final items = <Widget>[];
    for (final key in sortedKeys) {
      final date = DateTime.tryParse(key);
      final dayRows = groups[key]!;
      dayRows.sort((a, b) {
        final aT = a.startAtUtc ?? a.dueAtUtc;
        final bT = b.startAtUtc ?? b.dueAtUtc;
        if (a.allDay && !b.allDay) return -1;
        if (!a.allDay && b.allDay) return 1;
        if (aT == null && bT == null) return 0;
        if (aT == null) return 1;
        if (bT == null) return -1;
        return aT.compareTo(bT);
      });

      items.add(
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: _DayHeader(date: date, dateKey: key),
        ),
      );
      for (final row in dayRows) {
        items.add(
          _ScheduleCard(
            row: row,
            showDate: false,
            onToggleComplete: (val) async {
              await ref
                  .read(schedulerRepositoryProvider)
                  .setCompleted(row.id, val);
              await ref
                  .read(schedulerReminderCoordinatorProvider)
                  .reconcileItem(row.id);
            },
            onTap: () => context.push(AppRoutes.schedulerDetailPath(row.id)),
          ),
        );
      }
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
      children: items,
    );
  }
}

// ─── Day header for weekly view ───────────────────────────────────────────────

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.date, required this.dateKey});
  final DateTime? date;
  final String dateKey;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final now = DateTime.now();
    final isToday =
        date != null &&
        date!.year == now.year &&
        date!.month == now.month &&
        date!.day == now.day;

    final label = date != null ? _formatShortDate(date!) : dateKey;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isToday ? KeySpaceColors.signalYellow : Colors.transparent,
            border: Border.all(color: ink, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: ink,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 2, color: ink)),
      ],
    );
  }
}

// ─── Upcoming reminders banner ──────────────────────────────────────────────

/// Banner horizontal-scroll yang menampilkan jadwal-jadwal yang akan
/// dimulai/jatuh tempo dalam 24 jam ke depan.
class _UpcomingBanner extends ConsumerWidget {
  const _UpcomingBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcoming = ref.watch(upcomingSchedulesProvider);
    if (upcoming.isEmpty) return const SizedBox.shrink();

    final ink = Theme.of(context).colorScheme.onSurface;
    final now = DateTime.now();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        border: Border(
          bottom: BorderSide(color: ink.withValues(alpha: 0.18), width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_active,
                  size: 15,
                  color: const Color(0xFFE6A800),
                ),
                const SizedBox(width: 6),
                Text(
                  'PENGINGAT — JADWAL MENDEKATI',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: const Color(0xFFB07800),
                  ),
                ),
                const Spacer(),
                Text(
                  '${upcoming.length} item',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: ink.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              itemCount: upcoming.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = upcoming[index];
                final anchor =
                    item.startAtUtc?.toLocal() ?? item.dueAtUtc?.toLocal();
                final diff = anchor?.difference(now);
                final diffLabel = _formatDiff(diff);
                final isTask = item.itemType == 'task';
                return GestureDetector(
                  onTap: () =>
                      context.push(AppRoutes.schedulerDetailPath(item.id)),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isTask
                          ? const Color(0xFFBDE0FE)
                          : const Color(0xFFFFE79A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ink, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: ink.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isTask
                                    ? const Color(0xFF4A90D9)
                                    : const Color(0xFFE6A800),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                isTask ? 'TASK' : 'EVENT',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (diffLabel != null)
                              Text(
                                diffLabel,
                                style: GoogleFonts.ibmPlexMono(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFB07800),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: ink,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String? _formatDiff(Duration? diff) {
    if (diff == null) return null;
    final totalMinutes = diff.inMinutes;
    if (totalMinutes < 1) return 'Sekarang';
    if (totalMinutes < 60) return '${totalMinutes}m lagi';
    final hours = diff.inHours;
    final minutes = totalMinutes - hours * 60;
    return minutes > 0 ? '${hours}j ${minutes}m' : '${hours}j lagi';
  }
}

// ─── Individual schedule card ─────────────────────────────────────────────────

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.row,
    required this.showDate,
    required this.onToggleComplete,
    required this.onTap,
  });

  final ScheduleItem row;
  final bool showDate;
  final ValueChanged<bool> onToggleComplete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final isTask = row.itemType == 'task';
    final isDone = row.status == 'completed';

    // ─── Compute time display ─────────────────────────────────────────
    final String? hourStr;
    final String? minStr;
    final String? timeLabel;

    if (row.allDay) {
      hourStr = null;
      minStr = null;
      timeLabel = 'Sepanjang hari';
    } else if (row.startAtUtc != null) {
      final t = TimeOfDay.fromDateTime(row.startAtUtc!.toLocal());
      hourStr = t.hour.toString().padLeft(2, '0');
      minStr = t.minute.toString().padLeft(2, '0');
      timeLabel = null;
    } else if (row.dueAtUtc != null) {
      final t = TimeOfDay.fromDateTime(row.dueAtUtc!.toLocal());
      hourStr = t.hour.toString().padLeft(2, '0');
      minStr = t.minute.toString().padLeft(2, '0');
      timeLabel = 'Deadline';
    } else {
      hourStr = null;
      minStr = null;
      timeLabel = 'Tanpa jam';
    }

    // ─── Compute date display ─────────────────────────────────────────
    final dateStr = () {
      if (!showDate) return null;
      final local = row.localStartDate ?? row.dueDateLocal;
      if (local != null) {
        final d = DateTime.tryParse(local);
        if (d != null) return _formatShortDate(d);
      }
      final dt = (row.startAtUtc ?? row.dueAtUtc)?.toLocal();
      if (dt != null) return _formatShortDate(dt);
      return null;
    }();

    final cardColor = isTask
        ? const Color(0xFFBDE0FE)
        : const Color(0xFFFFE79A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: BrutalCard(
        padding: EdgeInsets.zero,
        color: isDone ? Theme.of(context).colorScheme.surface : cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Time column ────────────────────────────────────────
                SizedBox(
                  width: 52,
                  child: hourStr != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              hourStr,
                              style: GoogleFonts.ibmPlexMono(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: isDone
                                    ? ink.withValues(alpha: 0.35)
                                    : ink,
                                height: 1,
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 2,
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              color: isDone
                                  ? ink.withValues(alpha: 0.2)
                                  : ink.withValues(alpha: 0.5),
                            ),
                            Text(
                              minStr!,
                              style: GoogleFonts.ibmPlexMono(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDone
                                    ? ink.withValues(alpha: 0.35)
                                    : ink.withValues(alpha: 0.7),
                                height: 1,
                              ),
                            ),
                            if (timeLabel != null)
                              Text(
                                timeLabel,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  color: ink.withValues(alpha: 0.5),
                                  letterSpacing: 0,
                                ),
                              ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              row.allDay
                                  ? Icons.wb_sunny_outlined
                                  : Icons.access_time_outlined,
                              size: 20,
                              color: ink.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              timeLabel ?? '',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: ink.withValues(alpha: 0.45),
                              ),
                            ),
                          ],
                        ),
                ),

                // ── Divider ────────────────────────────────────────────
                Container(
                  width: 2,
                  height: 52,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: ink.withValues(alpha: 0.15),
                ),

                // ── Content ────────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type badge + checkbox
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isTask
                                  ? const Color(0xFF4A90D9)
                                  : const Color(0xFFE6A800),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              isTask ? 'TASK' : 'EVENT',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (isTask)
                            Transform.scale(
                              scale: 0.85,
                              child: Checkbox(
                                value: isDone,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (v) => onToggleComplete(v ?? false),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Title
                      Text(
                        row.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDone ? ink.withValues(alpha: 0.4) : ink,
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : null,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Date + priority row
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          if (dateStr != null)
                            _InfoPill(
                              icon: Icons.calendar_month_outlined,
                              label: dateStr,
                              ink: ink,
                            ),
                          _InfoPill(
                            icon: Icons.flag_outlined,
                            label: _priorityLabel(row.priority),
                            color: _priorityColor(row.priority),
                            ink: ink,
                          ),
                          if (row.recurrenceType != 'none')
                            _InfoPill(
                              icon: Icons.repeat,
                              label: row.recurrenceType.toUpperCase(),
                              ink: ink,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Arrow ──────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.chevron_right,
                    color: ink.withValues(alpha: 0.35),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Small info pill ──────────────────────────────────────────────────────────

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.label,
    required this.ink,
    this.color,
  });
  final IconData icon;
  final String label;
  final Color ink;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: (color ?? ink).withValues(alpha: 0.10),
        border: Border.all(
          color: (color ?? ink).withValues(alpha: 0.30),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color ?? ink.withValues(alpha: 0.6)),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color != null
                  ? color!.withValues(alpha: 0.85)
                  : ink.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleDetailScreen extends ConsumerWidget {
  const ScheduleDetailScreen({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows =
        ref.watch(scheduleItemsProvider).value ?? const <ScheduleItem>[];
    final row = rows.where((item) => item.id == id).firstOrNull;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL JADWAL'),
        actions: [
          IconButton(
            tooltip: 'Edit seluruh rangkaian',
            onPressed: () => context.push(AppRoutes.schedulerEditPath(id)),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: row == null
          ? const Center(child: Text('Jadwal tidak ditemukan'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                BrutalCard(
                  color: const Color(0xFFFFE79A),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        row.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 12),
                      Text(row.description ?? 'Tanpa deskripsi'),
                      const SizedBox(height: 8),
                      Text('TIPE: ${row.itemType.toUpperCase()}'),
                      Text('STATUS: ${row.status.toUpperCase()}'),
                      Text('TIMEZONE: ${row.timezone}'),
                      Text('RECURRENCE: ${row.recurrenceType.toUpperCase()}'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                BrutalButton(
                  label: 'EDIT SELURUH RANGKAIAN',
                  icon: Icons.edit,
                  onPressed: () =>
                      context.push(AppRoutes.schedulerEditPath(id)),
                ),
                const SizedBox(height: 8),
                BrutalButton(
                  label: 'HAPUS',
                  icon: Icons.delete,
                  secondary: true,
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Hapus jadwal?'),
                        content: const Text(
                          'Seluruh rangkaian dan reminder akan dihapus.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext, false),
                            child: const Text('BATAL'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: const Text('HAPUS'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed != true || !context.mounted) return;
                    await ref
                        .read(schedulerReminderCoordinatorProvider)
                        .cancelItem(id);
                    await ref
                        .read(schedulerRepositoryProvider)
                        .deleteSeries(id);
                    if (context.mounted) context.pop();
                  },
                ),
              ],
            ),
    );
  }
}

class ScheduleEditorScreen extends ConsumerStatefulWidget {
  const ScheduleEditorScreen({this.id, this.initialDraft, super.key});
  final String? id;
  final ScheduleDraft? initialDraft;

  @override
  ConsumerState<ScheduleEditorScreen> createState() =>
      _ScheduleEditorScreenState();
}

class _ScheduleEditorScreenState extends ConsumerState<ScheduleEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  ScheduleItemType _type = ScheduleItemType.event;
  SchedulePriority _priority = SchedulePriority.medium;
  ScheduleRecurrenceType _recurrence = ScheduleRecurrenceType.none;
  DateTime _date = DateTime.now();
  TimeOfDay _start = TimeOfDay.now();
  TimeOfDay _end = TimeOfDay.fromDateTime(
    DateTime.now().add(const Duration(hours: 1)),
  );
  bool _allDay = false;
  bool _taskHasDeadline = true;
  bool _dayReminderEnabled = true;
  bool _minutesReminderEnabled = true;
  int _minutesReminder = 30;
  String? _categoryId;
  bool _saving = false;
  List<ScheduleConflict> _conflicts = const [];

  @override
  void initState() {
    super.initState();
    final draft = widget.initialDraft;
    if (draft != null) _loadDraft(draft);
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadExisting());
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _loadExisting() async {
    final repository = ref.read(schedulerRepositoryProvider);
    final row = await repository.findById(widget.id!);
    if (row == null || !mounted) return;
    final reminderSelection = await repository.reminderSelectionForItem(
      widget.id!,
    );
    if (!mounted) return;
    _title.text = row.title;
    _description.text = row.description ?? '';
    _type = ScheduleItemType.values.byName(row.itemType);
    _priority = SchedulePriority.values.byName(row.priority);
    _recurrence = ScheduleRecurrenceType.values.byName(row.recurrenceType);
    _categoryId = row.categoryId;
    _allDay = row.allDay;
    _taskHasDeadline = row.dueAtUtc != null || row.dueDateLocal != null;
    final value = row.startAtUtc?.toLocal() ?? row.dueAtUtc?.toLocal();
    if (value != null) {
      _date = value;
      _start = TimeOfDay.fromDateTime(value);
    }
    if (row.endAtUtc != null) {
      _end = TimeOfDay.fromDateTime(row.endAtUtc!.toLocal());
    }
    _dayReminderEnabled = reminderSelection.dayBeforeEnabled;
    _minutesReminderEnabled = reminderSelection.minutesBeforeEnabled;
    _minutesReminder = reminderSelection.minutesBeforeOffset;
    setState(() {});
  }

  void _loadDraft(ScheduleDraft draft) {
    _title.text = draft.title;
    _description.text = draft.description ?? '';
    _type = draft.itemType;
    _priority = draft.priority;
    _recurrence = draft.recurrence.type;
    _categoryId = draft.categoryId;
    _allDay = draft.allDay;
    final value = draft.startAtUtc?.toLocal() ?? draft.dueAtUtc?.toLocal();
    if (value != null) {
      _date = value;
      _start = TimeOfDay.fromDateTime(value);
    }
    if (draft.endAtUtc != null) {
      _end = TimeOfDay.fromDateTime(draft.endAtUtc!.toLocal());
    }
    final reminderSelection = ScheduleReminderSelection.fromOffsets(
      draft.reminderOffsets,
    );
    _dayReminderEnabled = reminderSelection.dayBeforeEnabled;
    _minutesReminderEnabled = reminderSelection.minutesBeforeEnabled;
    _minutesReminder = reminderSelection.minutesBeforeOffset;
    _taskHasDeadline = draft.dueAtUtc != null || draft.dueDateLocal != null;
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(scheduleCategoriesProvider).value ?? const [];
    _categoryId ??= categories.firstOrNull?.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'BUAT JADWAL' : 'EDIT JADWAL'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (widget.initialDraft?.assumptions.isNotEmpty ?? false)
              BrutalCard(
                color: const Color(0xFFFFE79A),
                child: Text(
                  'ASUMSI GEMINI\n${widget.initialDraft!.assumptions.join('\n')}',
                ),
              ),
            if (_conflicts.isNotEmpty)
              BrutalCard(
                color: const Color(0xFFFFA62B),
                child: Text(
                  'BENTROK DENGAN\n${_conflicts.map((item) => item.title).join(', ')}\n'
                  'Kamu tetap dapat menyimpan.',
                ),
              ),
            const SizedBox(height: 12),
            SegmentedButton<ScheduleItemType>(
              segments: const [
                ButtonSegment(
                  value: ScheduleItemType.event,
                  label: Text('EVENT'),
                ),
                ButtonSegment(
                  value: ScheduleItemType.task,
                  label: Text('TASK'),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (value) =>
                  setState(() => _type = value.first),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Judul'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Judul wajib diisi'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            const SizedBox(height: 12),
            if (_type == ScheduleItemType.event)
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: const Text('Sepanjang hari'),
                value: _allDay,
                onChanged: (value) => setState(() => _allDay = value),
              ),
            if (_type == ScheduleItemType.task)
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: const Text('Task memiliki deadline'),
                subtitle: const Text(
                  'Task tanpa deadline disimpan tanpa pengingat.',
                ),
                value: _taskHasDeadline,
                onChanged: (value) => setState(() {
                  _taskHasDeadline = value;
                  if (!value) {
                    _dayReminderEnabled = false;
                    _minutesReminderEnabled = false;
                  }
                }),
              ),
            if (_type == ScheduleItemType.event || _taskHasDeadline)
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(localDateKey(_date)),
              ),
            if ((_type == ScheduleItemType.event && !_allDay) ||
                (_type == ScheduleItemType.task && _taskHasDeadline))
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickTime(start: true),
                      child: Text('MULAI ${_start.format(context)}'),
                    ),
                  ),
                  if (_type == ScheduleItemType.event) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pickTime(start: false),
                        child: Text('SELESAI ${_end.format(context)}'),
                      ),
                    ),
                  ],
                ],
              ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _categoryId,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Kategori'),
              items: categories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _categoryId = value),
              validator: (value) =>
                  value == null ? 'Kategori wajib dipilih' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<SchedulePriority>(
              initialValue: _priority,
              decoration: const InputDecoration(labelText: 'Prioritas'),
              items: SchedulePriority.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _priority = value!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ScheduleRecurrenceType>(
              initialValue: _recurrence,
              decoration: const InputDecoration(labelText: 'Pengulangan'),
              items: ScheduleRecurrenceType.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _recurrence = value!),
            ),
            const SizedBox(height: 12),
            BrutalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PENGINGAT',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('1 hari sebelumnya'),
                    value: _dayReminderEnabled,
                    onChanged:
                        _type == ScheduleItemType.task && !_taskHasDeadline
                        ? null
                        : (value) => setState(
                            () => _dayReminderEnabled = value ?? false,
                          ),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('$_minutesReminder menit sebelumnya'),
                    subtitle: _allDay
                        ? const Text('Pada event all-day: hari kegiatan 09.00')
                        : null,
                    value: _minutesReminderEnabled,
                    onChanged:
                        _type == ScheduleItemType.task && !_taskHasDeadline
                        ? null
                        : (value) => setState(
                            () => _minutesReminderEnabled = value ?? false,
                          ),
                  ),
                  DropdownButtonFormField<int>(
                    initialValue: _minutesReminder,
                    decoration: const InputDecoration(
                      labelText: 'Reminder kedua',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 15,
                        child: Text('15 menit sebelumnya'),
                      ),
                      DropdownMenuItem(
                        value: 30,
                        child: Text('30 menit sebelumnya'),
                      ),
                    ],
                    onChanged: _minutesReminderEnabled
                        ? (value) => setState(() => _minutesReminder = value!)
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BrutalButton(
              label: _conflicts.isEmpty ? 'TINJAU & SIMPAN' : 'TETAP SIMPAN',
              icon: Icons.save,
              onPressed: _saving ? null : _save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (value != null && mounted) setState(() => _date = value);
  }

  Future<void> _pickTime({required bool start}) async {
    final value = await showTimePicker(
      context: context,
      initialTime: start ? _start : _end,
    );
    if (value == null || !mounted) return;
    setState(() => start ? _start = value : _end = value);
  }

  DateTime _combine(TimeOfDay value) =>
      DateTime(_date.year, _date.month, _date.day, value.hour, value.minute);

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final categories = ref.read(scheduleCategoriesProvider).value ?? const [];
    final category = categories.firstWhere((row) => row.id == _categoryId);
    final start =
        (_type == ScheduleItemType.event && _allDay) ||
            (_type == ScheduleItemType.task && !_taskHasDeadline)
        ? null
        : _combine(_start);
    final end = _type == ScheduleItemType.event && !_allDay
        ? _combine(_end)
        : null;
    final draft = ScheduleDraft(
      itemType: _type,
      title: _title.text,
      description: _description.text,
      startAtUtc: _type == ScheduleItemType.event ? start?.toUtc() : null,
      endAtUtc: end?.toUtc(),
      dueAtUtc: _type == ScheduleItemType.task && _taskHasDeadline
          ? start?.toUtc()
          : null,
      localStartDate: _type == ScheduleItemType.event
          ? localDateKey(_date)
          : null,
      dueDateLocal: _type == ScheduleItemType.task && _taskHasDeadline
          ? localDateKey(_date)
          : null,
      allDay: _type == ScheduleItemType.event && _allDay,
      categoryId: category.id,
      categoryName: category.name,
      priority: _priority,
      timezone: await ref.read(localTimezoneProvider.future),
      recurrence: ScheduleRecurrence(
        type: _recurrence,
        weekdays: _recurrence == ScheduleRecurrenceType.weekly
            ? [_date.weekday]
            : const [],
      ),
      reminderOffsets: [
        if (_dayReminderEnabled) 1440,
        if (_minutesReminderEnabled) _minutesReminder,
      ],
    );
    if (start != null && end != null && _conflicts.isEmpty) {
      final conflicts = await ref
          .read(schedulerRepositoryProvider)
          .conflicts(excludingId: widget.id, startAtUtc: start, endAtUtc: end);
      if (conflicts.isNotEmpty && mounted) {
        setState(() => _conflicts = conflicts);
        return;
      }
    }
    setState(() => _saving = true);
    try {
      if (widget.id != null) {
        await ref
            .read(schedulerReminderCoordinatorProvider)
            .cancelItem(widget.id!);
      }
      final id = await ref
          .read(schedulerRepositoryProvider)
          .saveDraft(
            draft,
            id: widget.id,
            source: widget.initialDraft == null ? 'manual' : 'gemini',
            reminderSelection: ScheduleReminderSelection(
              dayBeforeEnabled: _dayReminderEnabled,
              minutesBeforeEnabled: _minutesReminderEnabled,
              minutesBeforeOffset: _minutesReminder,
            ),
          );
      final result = await ref
          .read(schedulerReminderCoordinatorProvider)
          .reconcileItem(id);
      if (!mounted) return;
      if (result.hasIssues) {
        final message = result.scheduledCount == 0
            ? 'Jadwal tersimpan, tetapi tidak ada pengingat yang dapat dijadwalkan.'
            : 'Jadwal tersimpan. Sebagian pengingat tidak dapat dijadwalkan.';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
      context.go(AppRoutes.schedulerDetailPath(id));
    } on Object catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Jadwal gagal disimpan: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
