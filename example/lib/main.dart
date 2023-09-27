import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mqtt_broker/mqtt_broker.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _mqttBrokerPlugin = MqttBroker();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _mqttBrokerPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void connectToMqttServer() async {
    final client = MqttServerClient("localhost", 'pos');
    client.logging(on: true);

    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();
    try {
      try {
        await client.connect();
      } on NoConnectionException catch (e) {
        // Raised by the client when connection fails.
        print('EXAMPLE::client exception - $e');
        client.disconnect();
      } on SocketException catch (e) {
        // Raised by the socket layer
        print('EXAMPLE::socket exception - $e');
        client.disconnect();
      }

      /// Check we are connected
      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        print('EXAMPLE::Mosquitto client connected');
      } else {
        /// Use status here rather than state if you also want the broker return code.
        print(
            'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
        client.disconnect();
        exit(-1);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () => _mqttBrokerPlugin.startMqttServer(),
              child: const Text("Start server"),
            ),
            TextButton(
              onPressed: () => connectToMqttServer(),
              child: const Text("Connect to server"),
            ),
          ],
        ),
      ),
    );
  }
}
