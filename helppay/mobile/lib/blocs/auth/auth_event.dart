part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRun extends AuthEvent {
  final AuthScreenData data;

  const AuthRun({required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() =>
      'AuthRun { email: ${data.login}, password: ${data.password} }';
}

class AuthSetPin extends AuthEvent {
  final String pin;

  const AuthSetPin({required this.pin});

  @override
  List<Object> get props => [pin];

  @override
  String toString() => 'AuthSetPin';
}

class AuthRefreshToken extends AuthEvent {
  final String token;

  const AuthRefreshToken({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthRefreshToken';
}

class AuthLogOut extends AuthEvent {}
