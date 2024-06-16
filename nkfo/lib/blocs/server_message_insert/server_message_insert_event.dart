part of 'server_message_insert_bloc.dart';

abstract class ServerMessageInsertEvent extends Equatable {
  const ServerMessageInsertEvent();

  @override
  List<Object> get props => [];
}

class ServerMessageInsertInit extends ServerMessageInsertEvent {}

class ServerMessageInsertRun extends ServerMessageInsertEvent {
  final ServerMessageInsertRequest message;

  const ServerMessageInsertRun(this.message);

  @override
  List<Object> get props => [message];
}