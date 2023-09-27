
import 'mqtt_broker_platform_interface.dart';

class MqttBroker {
  Future<String?> getPlatformVersion() {
    return MqttBrokerPlatform.instance.getPlatformVersion();
  }

  void startMqttServer(){
    MqttBrokerPlatform.instance.startMqttServer();
  }
}
