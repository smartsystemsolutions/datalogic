import 'package:flutter_test/flutter_test.dart';
import 'package:datalogic/datalogic.dart';
import 'package:datalogic/datalogic_platform_interface.dart';
import 'package:datalogic/datalogic_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDatalogicPlatform 
    with MockPlatformInterfaceMixin
    implements DatalogicPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DatalogicPlatform initialPlatform = DatalogicPlatform.instance;

  test('$MethodChannelDatalogic is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDatalogic>());
  });

  test('getPlatformVersion', () async {
    Datalogic datalogicPlugin = Datalogic();
    MockDatalogicPlatform fakePlatform = MockDatalogicPlatform();
    DatalogicPlatform.instance = fakePlatform;
  
    expect(await datalogicPlugin.getPlatformVersion(), '42');
  });
}
