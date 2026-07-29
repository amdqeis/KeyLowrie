import 'package:home_widget/home_widget.dart';

/// Kunci-kunci SharedPreferences yang dibaca oleh Android AppWidget Provider.
abstract final class _Keys {
  static const appId = 'com.keyspace.app';
  static const calories = 'widget_calories_kcal';
  static const caloriesLabel = 'widget_calories_label';
  static const remainingBudget = 'widget_remaining_budget';
  static const budgetLabel = 'widget_budget_label';
  static const nextTitle = 'widget_next_title';
  static const nextTime = 'widget_next_time';
  static const nextDate = 'widget_next_date';
  static const hasNext = 'widget_has_next';
  static const updatedAt = 'widget_updated_at';
}

/// Service untuk push data dari Flutter ke Android Home Screen Widget.
///
/// Data disimpan di SharedPreferences via [HomeWidget.saveWidgetData] dan
/// dibaca langsung oleh Kotlin [AppWidgetProvider] tanpa menjalankan Dart VM.
class HomeWidgetService {
  static bool _initialized = false;

  /// Inisialisasi sekali saat app pertama kali dibuka.
  static Future<void> initialize() async {
    if (_initialized) return;
    await HomeWidget.setAppGroupId(_Keys.appId);
    _initialized = true;
  }

  /// Push data kalori hari ini (dalam kkal).
  static Future<void> pushCalories(double kcal) async {
    final rounded = kcal.round();
    await HomeWidget.saveWidgetData(_Keys.calories, rounded);
    await HomeWidget.saveWidgetData(
      _Keys.caloriesLabel,
      '$rounded kkal',
    );
    await _markUpdated();
    await _updateWidgets();
  }

  /// Push sisa budget bulan ini (dalam IDR).
  static Future<void> pushBudget(int remainingRp) async {
    final label = _formatIdr(remainingRp);
    await HomeWidget.saveWidgetData(_Keys.remainingBudget, remainingRp);
    await HomeWidget.saveWidgetData(_Keys.budgetLabel, label);
    await _markUpdated();
    await _updateWidgets();
  }

  /// Push jadwal/task terdekat.
  static Future<void> pushNextSchedule({
    required String title,
    required String time,
    required String date,
  }) async {
    await HomeWidget.saveWidgetData(_Keys.hasNext, true);
    await HomeWidget.saveWidgetData(_Keys.nextTitle, title);
    await HomeWidget.saveWidgetData(_Keys.nextTime, time);
    await HomeWidget.saveWidgetData(_Keys.nextDate, date);
    await _markUpdated();
    await _updateWidgets();
  }

  /// Push informasi bahwa tidak ada jadwal terdekat.
  static Future<void> clearNextSchedule() async {
    await HomeWidget.saveWidgetData(_Keys.hasNext, false);
    await HomeWidget.saveWidgetData(_Keys.nextTitle, 'Tidak ada jadwal');
    await HomeWidget.saveWidgetData(_Keys.nextTime, '');
    await HomeWidget.saveWidgetData(_Keys.nextDate, '');
    await _markUpdated();
    await _updateWidgets();
  }

  /// Push semua data sekaligus.
  static Future<void> pushAll({
    required double caloriesKcal,
    required int remainingBudgetRp,
    String? nextTitle,
    String? nextTime,
    String? nextDate,
  }) async {
    final rounded = caloriesKcal.round();
    await HomeWidget.saveWidgetData(_Keys.calories, rounded);
    await HomeWidget.saveWidgetData(_Keys.caloriesLabel, '$rounded kkal');
    await HomeWidget.saveWidgetData(_Keys.remainingBudget, remainingBudgetRp);
    await HomeWidget.saveWidgetData(_Keys.budgetLabel, _formatIdr(remainingBudgetRp));
    final hasNext = nextTitle != null;
    await HomeWidget.saveWidgetData(_Keys.hasNext, hasNext);
    await HomeWidget.saveWidgetData(_Keys.nextTitle, nextTitle ?? 'Tidak ada jadwal');
    await HomeWidget.saveWidgetData(_Keys.nextTime, nextTime ?? '');
    await HomeWidget.saveWidgetData(_Keys.nextDate, nextDate ?? '');
    await _markUpdated();
    await _updateWidgets();
  }

  static Future<void> _markUpdated() async {
    final now = DateTime.now();
    final label =
        '${_pad(now.hour)}:${_pad(now.minute)}';
    await HomeWidget.saveWidgetData(_Keys.updatedAt, label);
  }

  static Future<void> _updateWidgets() async {
    await HomeWidget.updateWidget(
      androidName: 'QuickWidgetProvider',
    );
    await HomeWidget.updateWidget(
      androidName: 'DailyWidgetProvider',
    );
    await HomeWidget.updateWidget(
      androidName: 'FullWidgetProvider',
    );
  }

  static String _formatIdr(int amount) {
    if (amount < 0) return '-Rp ${_formatNumber(-amount)}';
    return 'Rp ${_formatNumber(amount)}';
  }

  static String _formatNumber(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');

  // ─── Navigation helpers ─────────────────────────────────────────────────────

  /// URI yang dipakai saat app dibuka pertama kali dari widget tap.
  /// Bisa null jika app dibuka secara normal.
  static Future<Uri?> initialLaunchUri() =>
      HomeWidget.initiallyLaunchedFromHomeWidget();

  /// Stream URI yang masuk saat widget di-tap sementara app sudah berjalan.
  static Stream<Uri?> widgetClickStream() => HomeWidget.widgetClicked;
}
