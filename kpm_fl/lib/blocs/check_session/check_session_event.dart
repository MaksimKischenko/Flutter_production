part of 'check_session_bloc.dart';

abstract class CheckSessionEvent extends Equatable {
  const CheckSessionEvent();

  @override
  List<Object> get props => [];
}

class CheckSessionUserInteraction extends CheckSessionEvent {
  @override
  List<Object> get props => [DateTime.now()];
}

class CheckSessionNeedLogOut extends CheckSessionEvent {}