import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService  {

  final DataManager dataManager;

  WebSocketService._()
  : dataManager = getIt<DataManager>();

  static final _instance = WebSocketService._();

  static WebSocketService get instance => _instance;

  Future<Either<Failure, WebSocketChannel?>> getConnection() async{
      try {
      final _channel = WebSocketApi.webSocketChannelInit(dataManager);
      log('OPENED');
      return Right(_channel);   
    } 
    on Exception catch (e) {
      return Left(WebSocketFailure(error: e));
    }   
  }

   Future<Either<Failure, WebSocketBodyData?>> getData(String data) async{
      try {
      final _data = WebSocketApi.webSocketGetInfo(data);
      return Right(_data);   
    } 
    on Exception catch (e) {
      await closeConnection();
      return Left(WebSocketFailure(error: e));
    }   
  } 

    Future<Either<Failure, String>> closeConnection() async{
      try {
      await WebSocketApi.webSocketCloseConnection();
      log('CLOSED');
      return const Right('');   
    } 
    on Exception catch (e) {
      return Left(WebSocketFailure(error: e));
    }   
  } 
}
