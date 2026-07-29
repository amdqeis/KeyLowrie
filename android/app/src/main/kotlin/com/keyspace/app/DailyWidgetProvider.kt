package com.keyspace.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * KeySpace Daily Widget (4×2) — kalori + sisa budget + jadwal terdekat.
 *
 * Data dibaca dari SharedPreferences yang di-push oleh Flutter via home_widget.
 * Tap pada widget membuka MainActivity, tap tiap kartu membuka screen terkait.
 */
class DailyWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (widgetId in appWidgetIds) {
            try {
                updateWidget(context, appWidgetManager, widgetId)
            } catch (e: Exception) {
                Log.e("DailyWidget", "Failed to update widget $widgetId", e)
            }
        }
    }

    companion object {
        private const val LAUNCH_ACTION = "es.antonborri.home_widget.action.LAUNCH"

        /**
         * Build PendingIntent secara manual (tanpa HomeWidgetLaunchIntent)
         * untuk menghindari dependency pada class Glance.
         * requestCode unik agar multi-card PendingIntent tidak collision.
         */
        private fun makeLaunchIntent(
            context: Context,
            route: String,
            requestCode: Int,
        ): PendingIntent {
            val intent = Intent(context, MainActivity::class.java).apply {
                action = LAUNCH_ACTION
                data = Uri.parse("keyspace://widget?route=$route")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            var flags = PendingIntent.FLAG_UPDATE_CURRENT
            if (Build.VERSION.SDK_INT >= 23) {
                flags = flags or PendingIntent.FLAG_IMMUTABLE
            }
            return PendingIntent.getActivity(context, requestCode, intent, flags)
        }

        fun updateWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            widgetId: Int,
        ) {
            val prefs = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.widget_daily)

            // ── Kalori ───────────────────────────────────────────────────────
            val caloriesLabel = prefs.getString("widget_calories_label", "-- kkal") ?: "-- kkal"
            views.setTextViewText(R.id.widget_daily_calories, caloriesLabel)
            views.setOnClickPendingIntent(
                R.id.widget_daily_calorie_card,
                makeLaunchIntent(context, "/home", 10),
            )

            // ── Budget ────────────────────────────────────────────────────────
            val budgetLabel = prefs.getString("widget_budget_label", "Rp --") ?: "Rp --"
            views.setTextViewText(R.id.widget_daily_budget, budgetLabel)
            views.setOnClickPendingIntent(
                R.id.widget_daily_budget_card,
                makeLaunchIntent(context, "/finance", 11),
            )

            // ── Jadwal terdekat ───────────────────────────────────────────────
            val nextTitle = prefs.getString("widget_next_title", "Tidak ada jadwal")
                ?: "Tidak ada jadwal"
            val nextTime = prefs.getString("widget_next_time", "") ?: ""
            val nextDate = prefs.getString("widget_next_date", "") ?: ""

            views.setTextViewText(R.id.widget_daily_next_title, nextTitle)
            views.setTextViewText(
                R.id.widget_daily_next_time,
                if (nextTime.isNotEmpty()) nextTime else "--",
            )
            views.setTextViewText(R.id.widget_daily_next_date, nextDate)
            views.setOnClickPendingIntent(
                R.id.widget_daily_schedule_card,
                makeLaunchIntent(context, "/scheduler", 12),
            )

            // ── Jam update ────────────────────────────────────────────────────
            val updatedAt = prefs.getString("widget_updated_at", "--:--") ?: "--:--"
            views.setTextViewText(R.id.widget_daily_updated, updatedAt)

            // ── Tap root → buka home ──────────────────────────────────────────
            views.setOnClickPendingIntent(
                R.id.widget_daily_root,
                makeLaunchIntent(context, "/home", 13),
            )

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
