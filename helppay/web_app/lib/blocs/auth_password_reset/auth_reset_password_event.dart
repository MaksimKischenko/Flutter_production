part of 'auth_reset_password_bloc.dart';

abstract class AuthResetPasswordEvent extends Equatable {
  const AuthResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class AuthResetPassword extends AuthResetPasswordEvent {
  final AuthScreenResetData data;

  const AuthResetPassword({required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'Email { email: ${data.email}, login: ${data.login} }';
}
