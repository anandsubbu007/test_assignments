import 'dart:convert';

import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @Named("socketUrl")
  String get socketUrl => 'wss://ws.binaryws.com/websockets/v3?app_id=1089';
}

class SocketService {
  static final dataInit =
      json.encode({"active_symbols": "brief", "product_type": "basic"});
  static String tickTriger(String symbol) => json.encode({"ticks": symbol});
  static String forgetId(String id) => json.encode({"forget": id});
}
