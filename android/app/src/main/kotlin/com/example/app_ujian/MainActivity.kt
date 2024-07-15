package com.example.app_ujian;

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "your.package.name/lock_task"
    private lateinit var lockTaskManager: LockTaskManager

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        lockTaskManager = LockTaskManager(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startLockTask" -> {
                    lockTaskManager.startLockTask()
                    result.success(null)
                }
                "stopLockTask" -> {
                    lockTaskManager.stopLockTask()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}