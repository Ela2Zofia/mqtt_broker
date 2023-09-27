#include "include/mqtt_broker/mqtt_broker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "mqtt_broker_plugin.h"

void MqttBrokerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  mqtt_broker::MqttBrokerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
