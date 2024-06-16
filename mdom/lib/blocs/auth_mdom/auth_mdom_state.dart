part of 'auth_mdom_bloc.dart';

abstract class AuthMdomState extends Equatable {
  const AuthMdomState();

  @override
  List<Object?> get props => [];
}

class AuthMdomInitial extends AuthMdomState {}

class AuthMdomLoading extends AuthMdomState {}

class AuthMdomError extends AuthMdomState {
  final Object error;

  const AuthMdomError({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthMdomErrorKomplat extends AuthMdomState {
  final String? errorMessage;
  final int errorCode;

  const AuthMdomErrorKomplat({
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class AuthUnauthorized extends AuthMdomState {
  final bool needToNavigate;
  const AuthUnauthorized({required this.needToNavigate});

  @override
  List<Object?> get props => [];
}

class AuthAuthorized extends AuthMdomState {
  final bool needToNavigate;

  const AuthAuthorized({
    required this.needToNavigate,
  });

  @override
  List<Object?> get props => [needToNavigate];
}

class AuthMdomAskForBiometrics extends AuthMdomState {
  final String biometricDescription;

  const AuthMdomAskForBiometrics({
    required this.biometricDescription,
  });

  @override
  List<Object> get props => [biometricDescription];
}

class AuthMdomSuccessLogin extends AuthMdomState {}

class AuthMdomPinSetup extends AuthMdomState {}
