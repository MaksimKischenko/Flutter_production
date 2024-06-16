part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordInit extends ChangePasswordEvent {}

class ChangePasswordAction extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordAction({
    required this.oldPassword,
    required this.newPassword
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}