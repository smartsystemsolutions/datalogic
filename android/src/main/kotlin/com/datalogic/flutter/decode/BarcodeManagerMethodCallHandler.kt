package com.datalogic.flutter.decode

import androidx.annotation.NonNull

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.EventChannel.EventSink

import com.datalogic.decode.BarcodeManager
import com.datalogic.decode.ReadListener
import io.flutter.plugin.common.EventChannel


object BarcodeManager {
    val methodCallHandler : MethodCallHandler = BarcodeManagerMethodCallHandler

    private var manager: BarcodeManager = BarcodeManager()

    public fun onReadStreamHandler(): EventChannel.StreamHandler {
        return BarcodeManagerOnReadHandler()
    }


    private object BarcodeManagerMethodCallHandler: MethodCallHandler {

        override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
            when (call.method) {
                "isInitialized" -> result.success(manager.isInitialized)
                else -> result.notImplemented()
            }
        }

    }

    public class BarcodeManagerOnReadHandler : StreamHandler {
        private var listener : ReadListener? = null
        override fun onListen(p0: Any?, sink: EventSink) {
            if (listener == null) {
                listener = ReadListener { decodeResult -> sink.success(decodeResult.text) }
                manager.addReadListener(listener)
            }
        }

        override fun onCancel(p0: Any?) {
            if (listener != null) {
                manager.removeReadListener(listener)
                listener = null
            }

        }
    }

}