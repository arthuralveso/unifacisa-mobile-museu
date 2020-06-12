package com.example.museu

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import com.umair.beacons_plugin.BeaconsActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: BeaconsActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
