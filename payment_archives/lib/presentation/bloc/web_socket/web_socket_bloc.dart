import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/services/web_socket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'web_socket_event.dart';
part 'web_socket_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {

  final WebSocketService service;

  WebSocketBloc() 
  : service = WebSocketService.instance,
    super(WebSocketInitial()) {
    on<WebSocketEvent>(
      _onEvent, 
      transformer: restartable()
    );
  }

  Future<void>? _onEvent(
    WebSocketEvent event,
    Emitter<WebSocketState> emit,
  ) async{
    if (event is WebSocketInitialize) return await _onWebSocketInitialize(event, emit);
    return;
  }


  Future<void> _onWebSocketInitialize(
    WebSocketInitialize event,
    Emitter<WebSocketState> emit,   
  ) async {
    final channelResult = await service.getConnection();
    channelResult.fold(
      (failure) => emit(WebSocketError(error: failure.message)),
      (right) async => await emit.forEach(
         right!.stream, 
         onData: (data) { 
          service.getData(data.toString()).then((value) async =>   
            value.fold(
              (nestedFailure)async {
                await service.closeConnection();
                emit(WebSocketError(error: nestedFailure.message)); 
              }, 
              (nestedRight) async {
                await service.closeConnection();
                emit(WebSocketLoadedInfo(
                  webSocketData: nestedRight
                ));
              }
            )
          );
          return WebSocketClosedConnection();
        },
        onError: (error, stackTrace) => WebSocketError(error: error)
      )
    ); 
  }
}