part of 'server_message_update_bloc.dart';

abstract class ServerMessageUpdateEvent extends Equatable {
  const ServerMessageUpdateEvent();

  @override
  List<Object?> get props => [];
}


class ServerMessageUpdateInit extends ServerMessageUpdateEvent{}

class ServerMessageUpdateRun extends ServerMessageUpdateEvent {
  final ServerMessageUpdateRequest message;

  const ServerMessageUpdateRun(this.message);

  @override
  List<Object?> get props => [message];
}
