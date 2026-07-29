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

/**
 * KeySpace Quick Widget (2×1) — shortcut tap ke Chat AI.
 *
 * Tap pada widget membuka MainActivity dengan deep-link ke route /chat.
 * PendingIntent dibuat secara manual untuk menghindari dependency pada
 * HomeWidgetLaunchIntent (yang membawa import androidx.glance dan bisa
 * gagal resolve di widget process).
 */
class QuickWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (widgetId in appWidgetIds) {
            try {
                updateWidget(context, appWidgetManager, widgetId)
            } catch (e: Exception) {
                Log.e("QuickWidget", "Failed to update widget $widgetId", e)
            }
        }
    }

    companion object {
        private const val LAUNCH_ACTION = "es.antonborri.home_widget.action.LAUNCH"

        fun updateWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            widgetId: Int,
        ) {
            val views = RemoteViews(context.packageName, R.layout.widget_quick)

            // Tap → buka app langsung ke /chat
            val intent = Intent(context, MainActivity::class.java).apply {
                action = LAUNCH_ACTION
                data = Uri.parse("keyspace://widget?route=/chat")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            var piFlags = PendingIntent.FLAG_UPDATE_CURRENT
            if (Build.VERSION.SDK_INT >= 23) {
                piFlags = piFlags or PendingIntent.FLAG_IMMUTABLE
            }
            val pendingIntent = PendingIntent.getActivity(context, 0, intent, piFlags)
            views.setOnClickPendingIntent(R.id.widget_quick_root, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
