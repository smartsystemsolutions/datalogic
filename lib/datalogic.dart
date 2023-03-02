import 'dart:async';

import 'datalogic_platform_interface.dart';

class Datalogic {
  Future<String?> getPlatformVersion() {
    return DatalogicPlatform.instance.getPlatformVersion();
  }

  Future<String?> getSdkVersion() {
    return DatalogicPlatform.instance.getSdkVersion();
  }

  Stream<String> listenBarcodes() {
    return DatalogicPlatform.instance.listenBarcodes();
  }

  Future<bool?> isInitialized() {
    return DatalogicPlatform.instance.isInitialized();
  }
}
