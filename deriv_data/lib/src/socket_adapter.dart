import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:deriv_data/deriv_data.dart';
import 'package:deriv_model/models/model.dart';
import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<SocketAdapter>()])
class SocketAdapter implements SocketPort {
  // static const String socket =
  //     'wss://ws.binaryws.com/websockets/v3?app_id=1089';
  final WebSocketChannel channel;

  SocketAdapter(this.channel);

  @override
  void sendMessage(String message) {
    log('Sending Message: $message');
    channel.sink.add(message);
  }

  bool _isListening = false;
  @override
  listenToSocket() {
    if (_isListening) return;
    _isListening = true;
    channel.stream.listen((event) {
      if (event != null && event is String) {
        final datas = json.decode(event);
        final msgType = datas['msg_type'];
        // print('msgType: $msgType');
        if (msgType == 'active_symbols') {
          final symbols = datas['active_symbols'];
          if (symbols is List) {
            final convertedData = symbols.map((e) {
              return ActiveSymbols.fromJson(e);
            }).toList();
            marketsData.add(convertedData);
          }
        } else if (msgType == 'tick') {
          final tick = datas['tick'];
          if (tick != null) {
            final ticket = Tick.fromMap(tick);
            tickData.add(ticket);
          }
        } else if (msgType == 'forget') {
          // Forgeted Id
        } else {
          log('Unknown Message Type: $msgType');
          // errorController.add('Unknown Event');
        }
      }
    }, onError: (e, stk) {
      errorController.add(e);
    });
  }

  StreamController errorController = StreamController.broadcast();

  StreamController<List<ActiveSymbols>> marketsData =
      StreamController<List<ActiveSymbols>>.broadcast();

  StreamController<Tick> tickData = StreamController<Tick>.broadcast();

  @override
  Stream<List<ActiveSymbols>> get marketsDataStream => marketsData.stream;

  @override
  Stream<Tick> get tickDataStream => tickData.stream;
  @override
  Stream get errorStream => errorController.stream;
}
