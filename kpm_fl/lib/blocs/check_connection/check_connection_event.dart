part of 'check_connection_bloc.dart';

abstract class CheckConnectionEvent extends Equatable {
  const CheckConnectionEvent();

  @override
  List<Object> get props => [];
}

class CheckConnectionInit extends CheckConnectionEvent {}