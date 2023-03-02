package io.smartsystemsolutions.datalogic

import androidx.annotation.NonNull

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.datalogic.decode.BarcodeManager
import com.datalogic.decode.ReadListener


object BarcodeManager {
    private var manager: BarcodeManager = BarcodeManager()
    

    public object BarcodeManagerMethodCallHandler: MethodCallHandler {

        override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
            when (call.method) {
                "barcodeManager/isInitialized" -> result.success(manager.isInitialized)
                else -> result.notImplemented()
            }
        }

    }

    public class BarcodeScannerStreamHandler: EventChannel.StreamHandler {
        private var listener : ReadListener? = null
        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            if(listener == null) {
                listener = ReadListener { decodeResult -> events?.success(decodeResult.text)}
                manager.addReadListener(listener)
            }
        }

        override fun onCancel(arguments: Any?) {
            if (listener != null) {
                manager.removeReadListener(listener)
                listener = null
            }
        }
    }

}