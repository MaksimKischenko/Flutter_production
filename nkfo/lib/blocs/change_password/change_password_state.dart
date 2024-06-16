part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState{}

class ChangePasswordError extends ChangePasswordState {
  final Object? error;

  const ChangePasswordError({this.error});

  @override
  List<Object?> get props => [error];
}

class ChangePasswordSuccess extends ChangePasswordState{}