part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class ChangePasswordRun extends ChangePasswordEvent {
  final String password;
  final String newPassword;
  
  const ChangePasswordRun({
    required this.password,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [password, newPassword];
  
}
