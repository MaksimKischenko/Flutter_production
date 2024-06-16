part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final Object error;

  const AuthError({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthErrorKomplat extends AuthState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const AuthErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText,
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}

class AuthAuthorized extends AuthState {
  final bool needToNavigate;
  final double maxAmount;
  final String returnUri;
  final String login;
  final String token;
  final String password;
  final String deviceType;
  final String confirmUri;
  final String payerId;
  final List<Payment> payments;

  AuthAuthorized({
    required this.needToNavigate,
    required this.maxAmount,
    required this.returnUri,
    required this.login,
    required this.token,
    required this.password,
    required this.deviceType,
    required this.confirmUri,
    required this.payerId,
    required this.payments,
  });
  @override
  List<Object?> get props => [
        needToNavigate,
        maxAmount,
        payments,
        token,
        login,
        password,
        deviceType,
        confirmUri,
        returnUri,
        payerId,
        payments,
      ];
}

class AuthUnauthorized extends AuthState {}
