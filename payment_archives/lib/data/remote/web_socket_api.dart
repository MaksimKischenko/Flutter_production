import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

mixin WebSocketApi {
  static const _webSocketApi = String.fromEnvironment('webSocketApi', defaultValue: 'ws://192.168.244.113:8082'); 
  static const _webSocketChannelName = 'search_payment_response';
  static WebSocketChannel? _channel;

  static WebSocketChannel? webSocketChannelInit(DataManager dataManager) {
    final jwt = JWT({
        'mode': 'rw',
        'iat': DateTime(DateTime.now().year, DateTime.now().month, 
        DateTime.now().day, DateTime.now().hour, DateTime.now().minute,
        DateTime.now().second).subtract(const Duration(minutes: 10)).millisecondsSinceEpoch * 1000
      },
    ); 
    final _token = jwt.sign(SecretKey(dataManager.tokendata?.jwtSecret ?? ''));  

    // ignore: join_return_with_assignment
    _channel = WebSocketChannel.connect(
      Uri.parse('$_webSocketApi/$_webSocketChannelName/$_token')
    );
    return _channel; 
  }

  static WebSocketBodyData? webSocketGetInfo(String data) {
    final _decodedWebSocketData = WebSocketBodyData.fromJson(Map<String, dynamic>.from(json.decode(data) as Map<String, dynamic>));
    return _decodedWebSocketData;
  }

  static Future<void> webSocketCloseConnection() async{
    await _channel?.sink.close();
  }
}
