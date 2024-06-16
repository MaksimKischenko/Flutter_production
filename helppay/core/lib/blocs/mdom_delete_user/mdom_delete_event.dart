part of 'mdom_delete_bloc.dart';

@immutable
abstract class MdomDeleteEvent {
  const MdomDeleteEvent();

  List<Object> get props => [];
}

class MdomDeleteAccount extends MdomDeleteEvent {
  final int? userId;
  final String login;

  const MdomDeleteAccount({required this.login, this.userId});

  @override
  List<Object> get props => [login];
}
