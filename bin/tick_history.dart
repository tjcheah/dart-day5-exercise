import 'package:web_socket_channel/io.dart';
import 'dart:convert';

void getTick(String? input) {

  final channel = IOWebSocketChannel.connect(
  'wss://ws.binaryws.com/websockets/v3?app_id=1089');
  
  channel.stream.listen((tick) {
    final decodedMessage = jsonDecode(tick);
    final name = decodedMessage ['tick']['symbol'];
    final price = decodedMessage ['tick']['quote'];

    final serverTimeAsEpoch = decodedMessage['tick']['epoch'];

    final serverTime =
    DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);
    print('o Name: $name Price: $price Time: $serverTime');
  });

  channel.sink.add('{ "ticks": "$input", "subscribe": 1 }');
}