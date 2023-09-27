import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mqtt_broker_method_channel.dart';

abstract class MqttBrokerPlatform extends PlatformInterface {
  /// Constructs a MqttBrokerPlatform.
  MqttBrokerPlatform() : super(token: _token);

  static final Object _token = Object();

  static MqttBrokerPlatform _instance = MethodChannelMqttBroker();

  /// The default instance of [MqttBrokerPlatform] to use.
  ///
  /// Defaults to [MethodChannelMqttBroker].
  static MqttBrokerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MqttBrokerPlatform] when
  /// they register themselves.
  static set instance(MqttBrokerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void startMqttServer();
}
