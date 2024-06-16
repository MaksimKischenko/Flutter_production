part of 'server_message_bloc.dart';

abstract class ServerMessageEvent extends Equatable {
  const ServerMessageEvent();

  @override
  List<Object> get props => [];
}

class ServerMessageInit extends ServerMessageEvent {}

class ServerMessageDelete extends ServerMessageEvent {}