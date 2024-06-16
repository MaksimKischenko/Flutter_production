part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final Object? error;

  const AuthError({this.error});

  @override
  List<Object?> get props => [error];
}

class AuthUnauthorized extends AuthState {
  final String? next;
  final bool needToNavigate;

  const AuthUnauthorized({
    required this.needToNavigate,
    this.next
  });

  @override
  List<Object?> get props => [next, needToNavigate];
}

class AuthAuthorized extends AuthState {
  final bool needToNavigate;
  final String? next;

  const AuthAuthorized({
    required this.needToNavigate,
    this.next
  });

  @override
  List<Object?> get props => [needToNavigate, next];
}

class AuthLogOutSuccess extends AuthState {}