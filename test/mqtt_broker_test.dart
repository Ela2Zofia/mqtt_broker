import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_broker/mqtt_broker.dart';
import 'package:mqtt_broker/mqtt_broker_platform_interface.dart';
import 'package:mqtt_broker/mqtt_broker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMqttBrokerPlatform
    with MockPlatformInterfaceMixin
    implements MqttBrokerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void startMqttServer() {
    // TODO: implement startMqttServer
  }
}

void main() {
  final MqttBrokerPlatform initialPlatform = MqttBrokerPlatform.instance;

  test('$MethodChannelMqttBroker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMqttBroker>());
  });

  test('getPlatformVersion', () async {
    MqttBroker mqttBrokerPlugin = MqttBroker();
    MockMqttBrokerPlatform fakePlatform = MockMqttBrokerPlatform();
    MqttBrokerPlatform.instance = fakePlatform;

    expect(await mqttBrokerPlugin.getPlatformVersion(), '42');
  });
}
