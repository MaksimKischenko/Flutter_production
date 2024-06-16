part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheck extends AuthEvent {
  final String path;

  const AuthCheck(this.path);
  
  @override
  List<Object?> get props => [path];
}

class AuthRun extends AuthEvent {
  final String login;
  final String password;
  final String? next;

  const AuthRun({
    required this.login,
    required this.password,
    this.next
  });

  @override
  List<Object?> get props => [login, password, next];
}

class AuthLogOut extends AuthEvent {}