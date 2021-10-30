import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'active_symbol.dart';

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message)['time'];
    final serverTime = DateTime.fromMillisecondsSinceEpoch(decodedMessage);
    print('--Server Time--');
    print(serverTime);
    print('');

    channel.sink.close();
    showSymbol();
  });
  channel.sink.add('{ "time": 1 }');
}
