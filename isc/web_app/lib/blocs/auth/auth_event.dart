part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthRun extends AuthEvent {
  final AuthScreenData data;

  const AuthRun({
    required this.data,
  });

  @override
  List<Object?> get props => [data];

  @override
  String toString() => 'AuthRun { email: ${data.email}, password: ${data.password} }';
}

class AuthCheck extends AuthEvent {
  final String path;

  const AuthCheck(this.path);
  
  @override
  List<Object?> get props => [path];
}

class AuthLogOut extends AuthEvent {}
