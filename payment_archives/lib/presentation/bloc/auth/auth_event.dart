part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}


class AuthRun extends AuthEvent {
  final AuthScreenData data;
  final bool? saveCredentials; 

  const AuthRun({
    required this.data,
    this.saveCredentials
  });

  @override
  List<Object?> get props => [data, saveCredentials];

  @override
  String toString() => 'AuthRun { email: ${data.login}, password: ${data.password} }';
}

class AuthCheck extends AuthEvent {
  final String path;

  const AuthCheck(this.path);
  
  @override
  List<Object?> get props => [path];
}

class AuthRefreshToken extends AuthEvent {}

class AuthLogOut extends AuthEvent {}
