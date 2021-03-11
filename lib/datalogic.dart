
import 'dart:async';

import 'package:flutter/services.dart';

class Datalogic {
  static const MethodChannel _channel =
      const MethodChannel('datalogic');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
