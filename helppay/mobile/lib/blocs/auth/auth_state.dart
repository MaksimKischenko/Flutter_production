part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final Object error;

  const AuthError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class AuthErrorKomplat extends AuthState {
  final String? errorMessage;
  final int errorCode;

  const AuthErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class AuthSuccess extends AuthState {}

class AuthPinSetSuccess extends AuthState {
  final bool askForBimetrics;
  final KomplatBiometricType? komplatBiometricType;

  const AuthPinSetSuccess({
    required this.askForBimetrics,
    required this.komplatBiometricType
  });

  @override
  List<Object?> get props => [askForBimetrics, komplatBiometricType];
}

class AuthLogOutSuccess extends AuthState {}