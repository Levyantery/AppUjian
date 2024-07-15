import 'package:flutter/services.dart';

class LockTaskManager {
  static const MethodChannel _channel = MethodChannel('your.package.name/lock_task');

  static Future<void> startLockTask() async {
    await _channel.invokeMethod('startLockTask');
  }

  static Future<void> stopLockTask() async {
    await _channel.invokeMethod('stopLockTask');
  }
}