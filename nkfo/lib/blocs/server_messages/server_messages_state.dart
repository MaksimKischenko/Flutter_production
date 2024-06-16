part of 'server_messages_bloc.dart';

abstract class ServerMessagesState extends Equatable {
  const ServerMessagesState();
  
  @override
  List<Object?> get props => [];
}

class ServerMessagesInitLoading extends ServerMessagesState {}

class ServerMessagesInitError extends ServerMessagesState {
  final Object? error;

  const ServerMessagesInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServerMessagesLoading extends ServerMessagesState {}

class ServerMessagesLoaded extends ServerMessagesState {
  final List <ServerMessage> messages; 
  final ServerMessageSort sort; 
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? title;
  final String? text;
  final bool sortAscending;
  final bool isLoadMoreAvaiable;
  final bool getIsAvaliable;
  final bool postIsAvaliable;
  final bool patchIsAvaliable;
  final bool deleteIsAvaliable;

  const ServerMessagesLoaded({
    required this.messages,
    required this.sort,
    required this.dateFrom,
    required this.dateTo,
    required this.title,
    required this.text,
    required this.sortAscending,
    required this.isLoadMoreAvaiable,
    this.getIsAvaliable = true,
    this.postIsAvaliable = true,
    this.patchIsAvaliable = true,
    this.deleteIsAvaliable = true,      
  });

   @override
   List<Object?> get props => [messages, sort, dateFrom, dateTo, title, text, sortAscending, 
     isLoadMoreAvaiable, getIsAvaliable, postIsAvaliable, patchIsAvaliable, deleteIsAvaliable
   ];
}

class ServerMessagesError extends ServerMessagesState {
  final Object? error;

  const ServerMessagesError({this.error});

  @override
  List<Object?> get props => [error];
}

class ServerMessagesDeleteSuccess extends ServerMessagesState {
  final int id;

  const ServerMessagesDeleteSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class ServerMessageGetNotAllow extends ServerMessagesState {
  final String? message;

  const ServerMessageGetNotAllow({this.message});

  @override
  List<Object?> get props => [message];
}