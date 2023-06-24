import 'package:flutter/services.dart';

class BlutoothPlugin {
  static const MethodChannel _channel = MethodChannel('bluetooth_enable');

  static Future<String> turnOn() async {
    final response = await _channel.invokeMethod('enable');
    return response.toString();
  }

}
