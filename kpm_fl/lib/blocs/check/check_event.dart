part of 'check_bloc.dart';

abstract class CheckEvent extends Equatable {
  const CheckEvent();

  @override
  List<Object> get props => [];
}

class CheckInit extends CheckEvent {}