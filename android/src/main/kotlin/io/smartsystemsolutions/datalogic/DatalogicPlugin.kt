package io.smartsystemsolutions.datalogic

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import io.smartsystemsolutions.datalogic.BarcodeManager
import com.datalogic.device.info.SYSTEM

/** DatalogicPlugin */
class DatalogicPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var barcodeManagerChannel : EventChannel
  

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "datalogic")
    channel.setMethodCallHandler(this)

    barcodeManagerChannel = EventChannel(flutterPluginBinding.binaryMessenger, "datalogic/barcodeManager")
    barcodeManagerChannel.setStreamHandler(BarcodeManager.BarcodeScannerStreamHandler())
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when(call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "getSdkVersion" -> result.success(SYSTEM.SDK_VERSION)
      "getBarcodeScannerType" -> result.success(SYSTEM.BARCODE_SCANNER_TYPE.ordinal)
      "barcodeManager/isInitialized" -> BarcodeManager.BarcodeManagerMethodCallHandler.onMethodCall(call, result)
      else -> result.notImplemented()
    }

  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    barcodeManagerChannel.setStreamHandler(null)
  }
}
