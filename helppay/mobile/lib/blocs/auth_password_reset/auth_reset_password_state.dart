part of 'auth_reset_password_bloc.dart';

abstract class AuthResetPasswordState extends Equatable {
  const AuthResetPasswordState();

  @override
  List<Object?> get props => [];
}

class AuthResetInitial extends AuthResetPasswordState {}

class AuthResetLoading extends AuthResetPasswordState {}

class AuthResetError extends AuthResetPasswordState {
  final Object error;

  const AuthResetError({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthResetErrorKomplat extends AuthResetPasswordState {
  final String? errorMessage;
  final int errorCode;

  const AuthResetErrorKomplat(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class AuthResetSuccess extends AuthResetPasswordState {}
