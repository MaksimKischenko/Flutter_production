part of 'user_update_bloc.dart';

abstract class UserUpdateEvent extends Equatable {
  const UserUpdateEvent();

  @override
  List<Object> get props => [];
}

class UserUpdateInit extends UserUpdateEvent {}

class UserUpdateRun extends UserUpdateEvent {
  final UserUpdateRequest user;
  final List<int>? listOFSelectedItemIds;

  const UserUpdateRun(this.user, this.listOFSelectedItemIds);

  @override
  List<Object> get props => [user];
}
