import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/features/home_widget/home_widget_service.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Derived data providers
// ─────────────────────────────────────────────────────────────────────────────

/// Kalori total hari ini.
final todayCaloriesProvider = StreamProvider<double>((ref) {
  final today = localDateKey(DateTime.now());
  return ref.watch(foodLogRepositoryProvider).watchTotal(today).map(
    (total) => total.caloriesKcal,
  );
});

/// Sisa budget periode aktif saat ini.
final currentRemainingBudgetProvider = StreamProvider<int>((ref) async* {
  final period = await ref.watch(activeFinancePeriodProvider.future);
  yield* ref.watch(financeRepositoryProvider).watchSummary(period.id).map(
    (s) => s.remainingBudget,
  );
});

/// Jadwal / task terdekat (di masa depan atau hari ini).
final nextScheduleItemProvider = StreamProvider<ScheduleItem?>((ref) {
  final now = DateTime.now();
  return ref.watch(schedulerRepositoryProvider).watchItems().map((items) {
    // Filter: belum selesai & waktunya >= sekarang (atau hari ini)
    final upcoming = items.where((item) {
      if (item.status == 'completed' || item.status == 'cancelled') {
        return false;
      }
      final t = item.startAtUtc ?? item.dueAtUtc;
      if (t != null) return t.isAfter(now.subtract(const Duration(minutes: 5)));
      // all-day: cek tanggal lokal
      final local = item.localStartDate ?? item.dueDateLocal;
      if (local == null) return false;
      final d = DateTime.tryParse(local);
      return d != null && !d.isBefore(DateTime(now.year, now.month, now.day));
    }).toList();

    if (upcoming.isEmpty) return null;

    // Urutkan: yang punya waktu dulu, lalu all-day
    upcoming.sort((a, b) {
      final at = a.startAtUtc ?? a.dueAtUtc;
      final bt = b.startAtUtc ?? b.dueAtUtc;
      if (at == null && bt == null) return 0;
      if (at == null) return 1;
      if (bt == null) return -1;
      return at.compareTo(bt);
    });
    return upcoming.first;
  });
});

// ─────────────────────────────────────────────────────────────────────────────
// Sync provider — listen semua data dan push ke widget
// ─────────────────────────────────────────────────────────────────────────────

/// Provider yang mendengarkan ketiga sumber data dan meng-update widget HP
/// secara otomatis. Cukup di-watch sekali di root app.
final homeWidgetSyncProvider = Provider<void>((ref) {
  ref.listen(todayCaloriesProvider, (_, next) {
    if (next.hasValue) {
      HomeWidgetService.pushCalories(next.requireValue);
    }
  });

  ref.listen(currentRemainingBudgetProvider, (_, next) {
    if (next.hasValue) {
      HomeWidgetService.pushBudget(next.requireValue);
    }
  });

  ref.listen(nextScheduleItemProvider, (_, next) {
    if (!next.hasValue) return;
    final item = next.requireValue;
    if (item == null) {
      HomeWidgetService.clearNextSchedule();
      return;
    }

    final timeStr = _formatItemTime(item);
    final dateStr = _formatItemDate(item);
    HomeWidgetService.pushNextSchedule(
      title: item.title,
      time: timeStr,
      date: dateStr,
    );
  });
});

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

const _kDayNames = [
  'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min',
];
const _kMonthNames = [
  '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
];

String _formatItemTime(ScheduleItem item) {
  if (item.allDay) return 'Sepanjang hari';
  final t = item.startAtUtc ?? item.dueAtUtc;
  if (t == null) return '';
  final local = t.toLocal();
  final h = local.hour.toString().padLeft(2, '0');
  final m = local.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

String _formatItemDate(ScheduleItem item) {
  DateTime? d;
  final localKey = item.localStartDate ?? item.dueDateLocal;
  if (localKey != null) {
    d = DateTime.tryParse(localKey);
  }
  d ??= (item.startAtUtc ?? item.dueAtUtc)?.toLocal();
  if (d == null) return '';
  final now = DateTime.now();
  if (d.year == now.year && d.month == now.month && d.day == now.day) {
    return 'Hari ini';
  }
  final tomorrow = now.add(const Duration(days: 1));
  if (d.year == tomorrow.year &&
      d.month == tomorrow.month &&
      d.day == tomorrow.day) {
    return 'Besok';
  }
  return '${_kDayNames[d.weekday - 1]}, ${d.day} ${_kMonthNames[d.month]}';
}
