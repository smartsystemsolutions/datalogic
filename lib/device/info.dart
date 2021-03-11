import 'dart:async';

import 'package:flutter/services.dart';

enum BarcodeScannerType { none, oneDimensionalReader, twoDimensionalReader }

class DatalogicException implements Exception {
  String message;

  DatalogicException(this.message);
}

class SYSTEM {
  static const MethodChannel _channel =
      const MethodChannel('com.datalogic.flutter.device.info/SYSTEM');

  static Future<String> get sdkVersion async {
    final String version = await _channel.invokeMethod('SDK_VERSION');
    return version;
  }

  static Future<BarcodeScannerType> get barcodeScannerType async {
    final BarcodeScannerType type =
        await _channel.invokeMethod('BARCODE_SCANNER_TYPE');
    if (type == null) {
      throw DatalogicException("no-device");
    }

    return type;
  }
}
