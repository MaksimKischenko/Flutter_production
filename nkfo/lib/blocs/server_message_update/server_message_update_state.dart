part of 'server_message_update_bloc.dart';

abstract class ServerMessageUpdateState extends Equatable {
  const ServerMessageUpdateState();
  
  @override
  List<Object?> get props => [];
}

class ServerMessageUpdateInitial extends ServerMessageUpdateState {
  final ServerMessage message;
  final List<Supplier> suppliers;

  const ServerMessageUpdateInitial({
    required this.message,
    required this.suppliers
  });

  @override
  List<Object?> get props => [message];
}

class ServerMessageUpdateInitLoading extends ServerMessageUpdateState {}

class ServerMessageUpdateInitError extends ServerMessageUpdateState {
  final Object? error;

  const ServerMessageUpdateInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServerMessageUpdateLoading extends ServerMessageUpdateState {}

class ServerMessageUpdateError extends ServerMessageUpdateState {
  final Object? error;

  const ServerMessageUpdateError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServerMessageUpdateSuccess extends ServerMessageUpdateState {
  final ServerMessage? message;

  const ServerMessageUpdateSuccess({
    required this.message
  });

  @override
  List<Object?> get props => [message];
}

