package com.example.mqtt_broker

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.moquette.broker.Server
import java.util.Properties


/** MqttBrokerPlugin */
class MqttBrokerPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mqtt_broker")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "startMqttServer"){
      var res = startMqttServer();
      if (res){
        result.success("Server started");
      }else{
        result.error("FAIL", "Server failed to start", "");
      }

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun startMqttServer() : Boolean {
    val properties = Properties();
    properties.setProperty("PORT_PROPERTY_NAME", "1883");
    properties.setProperty("HOST_PROPERTY_NAME", "0.0.0.0");
    properties.setProperty("PASSWORD_FILE_PROPERTY_NAME", "");
    properties.setProperty("ALLOW_ANONYMOUS_PROPERTY_NAME", "allow_anonymous");

    val server = Server();
    server.startServer(properties);
    println("Server started from function");
    return true;
  }
}
