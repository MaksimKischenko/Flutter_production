part of 'confirm_bloc.dart';

abstract class ConfirmEvent extends Equatable {
  const ConfirmEvent();

  @override
  List<Object> get props => [];
}

class ConfirmRun extends ConfirmEvent {}

class ResetStateEvent extends ConfirmEvent {}
