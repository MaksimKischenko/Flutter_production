// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class UsersInit extends UsersEvent {
  final int typeId;

  const UsersInit({
    required this.typeId,
  });

  @override
  List<Object?> get props => [typeId];
}

class NewUserUpdateTable extends UsersEvent {
  final User newUser;

  const NewUserUpdateTable({
    required this.newUser,
  });

  @override
  List<Object?> get props => [newUser];
}

class EditedUserUpdateTable extends UsersEvent {
  final User user;

  const EditedUserUpdateTable(this.user);

  @override
  List<Object?> get props => [user];
}

class UsersSort extends UsersEvent {

  final bool ascending;
  final int sortIndex;

  const UsersSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];

}


class UsersDeleteUser extends UsersEvent {
  final int userId;

  const UsersDeleteUser(this.userId);

  @override
  List<Object?> get props => [userId];
}