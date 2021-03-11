import 'dart:async';

import 'package:flutter/services.dart';
import 'package:streams_channel/streams_channel.dart';

class BarcodeManager {
  static const MethodChannel _channel =
      const MethodChannel('com.datalogic.flutter.decode/BarcodeManager');

  static StreamsChannel _onReadChannel =
      StreamsChannel('com.datalogic.flutter.decode/BarcodeManager.onRead');

  static Future<bool> get isInitialized async {
    final bool initialized = await _channel.invokeMethod('isInitialized');
    return initialized;
  }

  static Stream<String> onReadStream() {
    return _onReadChannel.receiveBroadcastStream().cast<String>();
  }
}
