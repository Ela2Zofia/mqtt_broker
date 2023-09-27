import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mqtt_broker_platform_interface.dart';

/// An implementation of [MqttBrokerPlatform] that uses method channels.
class MethodChannelMqttBroker extends MqttBrokerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mqtt_broker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void startMqttServer(){
    methodChannel.invokeMethod('startMqttServer'); 
  }
}
