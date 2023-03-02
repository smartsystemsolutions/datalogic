import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'datalogic_platform_interface.dart';

/// An implementation of [DatalogicPlatform] that uses method channels.
class MethodChannelDatalogic extends DatalogicPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('datalogic');
  final eventChanel = const EventChannel("datalogic/barcodeManager");

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getSdkVersion() async {
    final sdkVersion =
        await methodChannel.invokeMethod<String>('getSdkVersion');
    return sdkVersion;
  }

  @override
  Stream<String> listenBarcodes() {
    return eventChanel.receiveBroadcastStream().cast();
  }

  @override
  Future<bool?> isInitialized() async {
    final initialized =
        await methodChannel.invokeMethod<bool>('barcodeManager/isInitialized');
    return initialized;
  }
}
