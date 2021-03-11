package com.datalogic.flutter

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

import app.loup.streams_channel.StreamsChannel;
import com.datalogic.flutter.device.info.SYSTEMMethodCallHandler
import com.datalogic.flutter.decode.BarcodeManager


/** DatalogicPlugin */
class DatalogicPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private val channelDescriptions = mapOf<String, MethodChannel.MethodCallHandler>(
          "com.datalogic.flutter.device.info/SYSTEM" to SYSTEMMethodCallHandler,
          "com.datalogic.flutter.decode/BarcodeManager" to BarcodeManager.methodCallHandler
  )
  private lateinit var channels : HashMap<String, MethodChannel>

  private val eventDescriptions = mapOf<String, ()->EventChannel.StreamHandler>(
          "com.datalogic.flutter.decode/BarcodeManager.onRead" to BarcodeManager::onReadStreamHandler
  )
  private lateinit var streams : HashMap<String, StreamsChannel>

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      channels = hashMapOf()
      for ((k, v) in channelDescriptions) {
        channels[k] = MethodChannel(flutterPluginBinding.binaryMessenger, k)
        channels[k]?.setMethodCallHandler(v)
      }

      streams = hashMapOf()
      for ((k, v) in eventDescriptions) {
        streams[k] = StreamsChannel(flutterPluginBinding.binaryMessenger, k)
        streams[k]?.setStreamHandlerFactory { v() }
      }

  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    for ((k,_ ) in channelDescriptions) {
      var channel = channels.remove(k)
      channel?.setMethodCallHandler(null)
    }

    for((k,_) in eventDescriptions) {
      streams.remove(k)
//      event?.setStreamHandler(null)
    }

  }
}
