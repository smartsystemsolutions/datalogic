import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'datalogic_method_channel.dart';

abstract class DatalogicPlatform extends PlatformInterface {
  /// Constructs a DatalogicPlatform.
  DatalogicPlatform() : super(token: _token);

  static final Object _token = Object();

  static DatalogicPlatform _instance = MethodChannelDatalogic();

  /// The default instance of [DatalogicPlatform] to use.
  ///
  /// Defaults to [MethodChannelDatalogic].
  static DatalogicPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DatalogicPlatform] when
  /// they register themselves.
  static set instance(DatalogicPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getSdkVersion() {
    throw UnimplementedError("sdkVersion() has not been implemented.");
  }

  Stream<String> listenBarcodes() {
    throw UnimplementedError("listenBarcode() has not been implemented.");
  }

  Future<bool?> isInitialized() {
    throw UnimplementedError("IsInitialized() has not been implemented.");
  }
}
