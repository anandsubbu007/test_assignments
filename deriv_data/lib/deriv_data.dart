library deriv_data;

import 'dart:async';

import 'package:deriv_model/models/model.dart';

export 'src/config/di.dart';
export 'src/config/module.dart';
export 'src/socket_adapter.dart';

abstract class SocketPort {
  Stream<List<ActiveSymbols>> get marketsDataStream;
  Stream<Tick> get tickDataStream;
  Stream get errorStream;
  // Stream<String> get selectedMarket;
  // Stream<String?> get selectedSymbol;

  void sendMessage(String message);
  listenToSocket();
  // onError(void Function(dynamic error) errorHandler);
}
