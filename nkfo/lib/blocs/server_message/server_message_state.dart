part of 'server_message_bloc.dart';

abstract class ServerMessageState extends Equatable {
  const ServerMessageState();
  
  @override
  List<Object?> get props => [];
}

class ServerMessageInitial extends ServerMessageState {
  final ServerMessage message;
  final List<Supplier> suppliers;

  const ServerMessageInitial({
    required this.message,
    required this.suppliers
  });
  
  @override
  List<Object?> get props => [message, suppliers];

}

class ServerMessageInitLoading extends ServerMessageState {}

class ServerMessageLoading extends ServerMessageState {}

class ServerMessageInitError extends ServerMessageState {
  final Object? error;

  const ServerMessageInitError({this.error});

  @override
  List<Object?> get props => [error];
}

class ServerMessageError extends ServerMessageState {
  final Object? error;

  const ServerMessageError({this.error});

  @override
  List<Object?> get props => [error];
}

class ServerMessageDeleteSuccess extends ServerMessageState {
  final ServerMessage message;

  const ServerMessageDeleteSuccess({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
