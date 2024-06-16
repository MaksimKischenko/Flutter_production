part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRun extends AuthEvent {
  final String login;
  final String password;
  final bool isAuthSaveChecked;
  final bool isFromSplash;

  const AuthRun({
    required this.login,
    required this.password,
    this.isAuthSaveChecked = false,
    this.isFromSplash = false
  });

  @override
  List<Object> get props => [login, password, isAuthSaveChecked];
}

class AuthSetPin extends AuthEvent {
  final String pin;

  const AuthSetPin(this.pin);

  @override
  List<Object> get props => [pin];
}

class AuthBiometricResponse extends AuthEvent {
  final bool response;

  // ignore: avoid_positional_boolean_parameters
  const AuthBiometricResponse(this.response);

  @override
  List<Object> get props => [response];
}

class AuthLogOut extends AuthEvent {}