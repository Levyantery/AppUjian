package com.example.app_ujian;

import android.app.Activity
import android.app.admin.DevicePolicyManager
import android.content.Context
import android.os.Build

class LockTaskManager(private val activity: Activity) {
    private val devicePolicyManager: DevicePolicyManager =
        activity.getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager

    fun startLockTask() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            if (devicePolicyManager.isLockTaskPermitted(activity.packageName)) {
                activity.startLockTask()
            } else {
                // Request device owner permission if not granted
                // This requires additional setup in the device settings
            }
        }
    }

    fun stopLockTask() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            activity.stopLockTask()
        }
    }
}