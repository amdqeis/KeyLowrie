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
 * KeySpace Full Widget (4×3) — semua informasi + shortcut Chat AI.
 *
 * Tiga baris:
 *   1. Kalori hari ini | Sisa budget
 *   2. Jadwal / task terdekat
 *   3. Tombol "BUKA CHAT AI"
 */
class FullWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (widgetId in appWidgetIds) {
            try {
                updateWidget(context, appWidgetManager, widgetId)
            } catch (e: Exception) {
                Log.e("FullWidget", "Failed to update widget $widgetId", e)
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
            val views = RemoteViews(context.packageName, R.layout.widget_full)

            // ── Kalori ────────────────────────────────────────────────────────
            val caloriesLabel = prefs.getString("widget_calories_label", "-- kkal") ?: "-- kkal"
            views.setTextViewText(R.id.widget_full_calories, caloriesLabel)
            views.setOnClickPendingIntent(
                R.id.widget_full_calorie_card,
                makeLaunchIntent(context, "/home", 20),
            )

            // ── Budget ────────────────────────────────────────────────────────
            val budgetLabel = prefs.getString("widget_budget_label", "Rp --") ?: "Rp --"
            views.setTextViewText(R.id.widget_full_budget, budgetLabel)
            views.setOnClickPendingIntent(
                R.id.widget_full_budget_card,
                makeLaunchIntent(context, "/finance", 21),
            )

            // ── Jadwal terdekat ───────────────────────────────────────────────
            val nextTitle = prefs.getString("widget_next_title", "Tidak ada jadwal")
                ?: "Tidak ada jadwal"
            val nextTime = prefs.getString("widget_next_time", "") ?: ""
            val nextDate = prefs.getString("widget_next_date", "") ?: ""

            views.setTextViewText(R.id.widget_full_next_title, nextTitle)
            views.setTextViewText(
                R.id.widget_full_next_time,
                if (nextTime.isNotEmpty()) nextTime else "--",
            )
            views.setTextViewText(R.id.widget_full_next_date, nextDate)
            views.setOnClickPendingIntent(
                R.id.widget_full_schedule_card,
                makeLaunchIntent(context, "/scheduler", 22),
            )

            // ── Chat shortcut ─────────────────────────────────────────────────
            views.setOnClickPendingIntent(
                R.id.widget_full_chat_card,
                makeLaunchIntent(context, "/chat", 23),
            )

            // ── Jam update ────────────────────────────────────────────────────
            val updatedAt = prefs.getString("widget_updated_at", "--:--") ?: "--:--"
            views.setTextViewText(R.id.widget_full_updated, updatedAt)

            // ── Tap root → buka home ──────────────────────────────────────────
            views.setOnClickPendingIntent(
                R.id.widget_full_root,
                makeLaunchIntent(context, "/home", 24),
            )

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
