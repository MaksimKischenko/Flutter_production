part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordError extends ChangePasswordState {
  final Object error;

  const ChangePasswordError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class ChangePasswordErrorKomplat extends ChangePasswordState {
  final String? errorMessage;
  final int errorCode;

  const ChangePasswordErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class ChangePasswordActionLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}