part of 'web_socket_bloc.dart';

abstract class WebSocketState extends Equatable {
  const WebSocketState();
  
  @override
  List<Object?> get props => [];
}
class WebSocketInitial extends WebSocketState {}

class WebSocketInitialized extends WebSocketState {
  final WebSocketChannel? channel;

  const WebSocketInitialized({this.channel});

  @override
  List<Object?> get props => [channel];
}


class WebSocketLoadedInfo extends WebSocketState {
  final WebSocketBodyData? webSocketData;

  const WebSocketLoadedInfo({
   required this.webSocketData
  });

  @override
  List<Object?> get props => [webSocketData];
}

class WebSocketError extends WebSocketState {

  final Object? error;

  const WebSocketError({this.error});

  @override
  List<Object?> get props => [error];
}

class WebSocketClosedConnection extends WebSocketState {}