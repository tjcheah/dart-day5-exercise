import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:io';
import 'tick_history.dart';

bool showSymbol() {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {
    final decodedMessage1 = jsonDecode(message);
    final activeSymbol = decodedMessage1['active_symbols'];

    print('--Active Symbols--');
    for (int i = 0; i < 10; i++) {
      var market = activeSymbol[i]['display_name'];
      var symbol = activeSymbol[i]['symbol'];
      if (activeSymbol[i]['exchange_is_open'] == 0) {
        print('Market: $market, Symbol:$symbol (MARKET CLOSED)');
      } else {
        print('Market: $market, Symbol:$symbol (MARKET OPEN)');
      }
    }
    channel.sink.close();
    print('');
    print('Enter your symbol:');
    final input = stdin.readLineSync();
    print('');
    print('--Tick History--');
    getTick(input);
  });
  channel.sink.add('{ "active_symbols": "brief"}');
  return true;
}
