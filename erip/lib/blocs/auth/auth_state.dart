part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {}

class AuthInitial extends AuthState {}

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

class AuthAskForBiometrics extends AuthState {
  final String biometricDescription;

  const AuthAskForBiometrics({
    required this.biometricDescription
  });

  @override
  List<Object> get props => [biometricDescription];
}

class AuthSuccessLogin extends AuthState {}

class AuthPinSetup extends AuthState {}