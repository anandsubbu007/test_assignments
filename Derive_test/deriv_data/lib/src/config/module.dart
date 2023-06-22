import 'package:deriv_data/deriv_data.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  WebSocketChannel channel(@Named('socketUrl') String url) =>
      WebSocketChannel.connect(Uri.parse(url));

  @lazySingleton
  SocketPort providerNetworkService(WebSocketChannel channel) =>
      SocketAdapter(channel);
}
