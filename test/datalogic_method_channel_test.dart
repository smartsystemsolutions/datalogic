import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datalogic/datalogic_method_channel.dart';

void main() {
  MethodChannelDatalogic platform = MethodChannelDatalogic();
  const MethodChannel channel = MethodChannel('datalogic');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
