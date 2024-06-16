part of 'user_update_bloc.dart';

abstract class UserUpdateEvent extends Equatable {
  const UserUpdateEvent();

  @override
  List<Object?> get props => [];
}

class UserUpdateInit extends UserUpdateEvent {}

class UserUpdateRun extends UserUpdateEvent {
  final UserUpdateRequest user;

  const UserUpdateRun(this.user);

  @override
  List<Object?> get props => [user];
}
