package com.datalogic.flutter.device.info

import androidx.annotation.NonNull

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.datalogic.device.info.SYSTEM

object SYSTEMMethodCallHandler: MethodCallHandler {
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        when(call.method) {
            "SDK_VERSION" -> result.success(SYSTEM.SDK_VERSION)
            "BARCODE_SCANNER_TYPE" -> result.success(SYSTEM.BARCODE_SCANNER_TYPE.ordinal)
            else -> result.notImplemented()
        }
    }
}