// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final Object? error;

  const AuthError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
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

class AuthUnauthorized extends AuthState {}

class AuthAuthorized extends AuthState {
  final String? accessToken;
  final String? refreshToken;
  final TokenBodyData? tokenData;
  final bool? saveCredentials;
  final String? login;
  final String? password;

  const AuthAuthorized({
    this.tokenData,
    this.accessToken,
    this.refreshToken,
    this.saveCredentials,
    this.login,
    this.password
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, tokenData, saveCredentials, login, password];
}

class AuthSuccess extends AuthState {}

class AuthLogOutSuccess extends AuthState {}
