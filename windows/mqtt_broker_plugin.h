#ifndef FLUTTER_PLUGIN_MQTT_BROKER_PLUGIN_H_
#define FLUTTER_PLUGIN_MQTT_BROKER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace mqtt_broker {

class MqttBrokerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MqttBrokerPlugin();

  virtual ~MqttBrokerPlugin();

  // Disallow copy and assign.
  MqttBrokerPlugin(const MqttBrokerPlugin&) = delete;
  MqttBrokerPlugin& operator=(const MqttBrokerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace mqtt_broker

#endif  // FLUTTER_PLUGIN_MQTT_BROKER_PLUGIN_H_
