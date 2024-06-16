part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthRun extends AuthEvent {
  final String path;
  final String? token;
  final double? maxAmount;

  const AuthRun({
    required this.path,
    required this.token,
    required this.maxAmount
  });

  @override
  List<Object?> get props => [path, token, maxAmount];
}

class AuthLogOut extends AuthEvent {}