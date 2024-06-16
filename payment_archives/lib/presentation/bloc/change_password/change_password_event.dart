// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordRun extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordRun({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}
