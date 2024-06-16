part of 'check_session_bloc.dart';

abstract class CheckSessionState extends Equatable {
  const CheckSessionState();
  
  @override
  List<Object> get props => [];
}

class CheckSessionInitial extends CheckSessionState {}

class CheckSessionLoading extends CheckSessionState {}

class CheckSessionLogOut extends CheckSessionState {}
