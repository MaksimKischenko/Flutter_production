part of 'server_message_insert_bloc.dart';

abstract class ServerMessageInsertState extends Equatable {
  const ServerMessageInsertState();
  
  @override
  List<Object?> get props => [];
}

class ServerMessageInsertInitial extends ServerMessageInsertState {
  final List<Supplier> suppliers;

  const ServerMessageInsertInitial({
    required this.suppliers
  });

  @override
  List<Object> get props => [suppliers];
}

class ServerMessageInsertInitLoading extends ServerMessageInsertState {}

class ServerMessageInsertInitError extends ServerMessageInsertState {
  final Object? error;

  const ServerMessageInsertInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServerMessageInsertLoading extends ServerMessageInsertState {}

class ServerMessageInsertError extends ServerMessageInsertState {
  final Object? error;

  const ServerMessageInsertError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServerMessageInsertSuccess extends ServerMessageInsertState {
  final ServerMessage? message;

  const ServerMessageInsertSuccess({
    required this.message
  });

  @override
  List<Object?> get props => [message];
}