// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'web_socket_bloc.dart';

abstract class WebSocketEvent extends Equatable {
  const WebSocketEvent();

  @override
  List<Object?> get props => [];
}
class WebSocketInitialize extends WebSocketEvent {}

