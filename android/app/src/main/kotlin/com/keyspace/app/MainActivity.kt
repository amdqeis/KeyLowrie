package com.keyspace.app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Handle deep-link route passed by widget PendingIntent
        handleWidgetRoute()
    }

    override fun onNewIntent(intent: android.content.Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleWidgetRoute()
    }

    private fun handleWidgetRoute() {
        // Route is read by the home_widget plugin automatically via the intent extras.
        // No manual plugin registration needed — home_widget 0.7+ uses auto-registration.
    }
}
