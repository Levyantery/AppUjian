  import 'package:flutter/services.dart';

    class LockTaskManager {
      static const platform = MethodChannel('com.example.app/locktask');

      static Future<void> startLockTask() async {
        try {
          await platform.invokeMethod('startLockTask');
        } on PlatformException catch (e) {
          print("Failed to start lock task: '${e.message}'.");
        }
      }

      static Future<void> stopLockTask() async {
        try {
          await platform.invokeMethod('stopLockTask');
        } on PlatformException catch (e) {
          print("Failed to stop lock task: '${e.message}'.");
        }
      }
    }