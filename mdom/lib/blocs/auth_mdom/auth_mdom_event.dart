part of 'auth_mdom_bloc.dart';

abstract class AuthMdomEvent extends Equatable {
  const AuthMdomEvent();

  @override
  List<Object> get props => [];
}

class AuthMdomRun extends AuthMdomEvent {
  final String email;
  final String password;
  final bool isAuthSaveChecked;
  final bool isFromSplash;

  const AuthMdomRun({
    required this.email,
    required this.password,
    this.isAuthSaveChecked = false,
    this.isFromSplash = false,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthMdomSetPin extends AuthMdomEvent {
  final String pin;

  const AuthMdomSetPin(this.pin);

  @override
  List<Object> get props => [pin];
}

class AuthMdomBiometricResponse extends AuthMdomEvent {
  final bool response;

  // ignore: avoid_positional_boolean_parameters
  const AuthMdomBiometricResponse(this.response);

  @override
  List<Object> get props => [response];
}

class AuthCheck extends AuthMdomEvent {
  final String path;

  const AuthCheck(this.path);

  @override
  List<Object> get props => [path];
}

class AuthMdomLogOut extends AuthMdomEvent {}
