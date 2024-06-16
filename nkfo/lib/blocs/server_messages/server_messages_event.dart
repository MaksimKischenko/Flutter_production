part of 'server_messages_bloc.dart';

abstract class ServerMessagesEvent extends Equatable {
  const ServerMessagesEvent();

  @override
  List<Object?> get props => [];
}

class ServerMessagesInit extends ServerMessagesEvent {}

class ServerMessagesLoad extends ServerMessagesEvent {
  final ServerMessageStatus? status;
  final ServerMessageStatus? statusName;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? title;
  final String? text;
  final ServerMessageSort? sort;
  final bool? sortAscending;
  final int loadCount;

  const ServerMessagesLoad({
    this.status,
    this.statusName,
    this.dateFrom,
    this.dateTo,
    this.title,
    this.text,
    this.sort,
    this.sortAscending,
    this.loadCount = AppConfig.serverMessagesGetLoadCount,
  });

  @override
  List<Object?> get props => [status, dateFrom, dateTo, title, text, sort, sortAscending, loadCount];
  
}

class ServerMessagesLoadMore extends ServerMessagesEvent {
  final int offset;

  const ServerMessagesLoadMore(this.offset);

  @override
  List<Object> get props => [offset];

}

class ServerMessagesIncomeDeleteMessage extends ServerMessagesEvent {
  final int messageId;

  const ServerMessagesIncomeDeleteMessage(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class ServerMessagesDeleteMessage extends ServerMessagesEvent {
  final int id;

  const ServerMessagesDeleteMessage(this.id);

  @override
  List<Object> get props => [id];
}

class ServerMessagesIncomeUpdateMessage extends ServerMessagesEvent {
  final ServerMessage message;

  const ServerMessagesIncomeUpdateMessage(this.message);

  @override
  List<Object> get props => [message];
}

class ServerMessagesNewServerMessage extends ServerMessagesEvent {
  final ServerMessage message;

  const ServerMessagesNewServerMessage(this.message);

  @override
  List<Object?> get props => [message];


}