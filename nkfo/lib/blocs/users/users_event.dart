part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class UsersInit extends UsersEvent {}

class UsersLoad extends UsersEvent {
  final UsersBlockStatus? blockStatus;
  final UserType? type;
  final int? supplierId;
  final String? fio;
  final UsersSort? sort;
  final bool? sortAscending;
  final int loadCount;

  const UsersLoad({
    this.blockStatus,
    this.type,
    this.supplierId,
    this.fio,
    this.sort,
    this.sortAscending,
    this.loadCount = AppConfig.usersGetLoadCount,
  });

  @override
  List<Object?> get props => [blockStatus, type, supplierId, fio, sort, sortAscending, loadCount];

}

class UsersLoadMore extends UsersEvent {
  final int offset;

  const UsersLoadMore(this.offset);

  @override
  List<Object?> get props => [offset];
}

class UsersDeleteUser extends UsersEvent {
  final int userId;

  const UsersDeleteUser(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UsersDeleteGroupUser extends UsersEvent {
  final List<int> userIds;

  const UsersDeleteGroupUser(this.userIds);

  @override
  List<Object?> get props => [userIds];
}

class UsersChangeUserStatus extends UsersEvent {
  final int id;
  final bool blocked;

  const UsersChangeUserStatus({
    required this.id,
    required this.blocked
  });

  @override
  List<Object?> get props => [id, blocked];
}


class UsersChangeGroupUserStatus extends UsersEvent {
  final List<int> userIds;
  final bool blocked;

  const UsersChangeGroupUserStatus({
    required this.userIds,
    required this.blocked
  });

  @override
  List<Object?> get props => [userIds, blocked];
}

class UsersUpdateUser extends UsersEvent {
  final User user;

  const UsersUpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UsersResetUserPassword extends UsersEvent {
  final String userLogin;

  const UsersResetUserPassword(this.userLogin);

  @override
  List<Object?> get props => [userLogin];
}

class UsersNewUser extends UsersEvent {
  final User user;

  const UsersNewUser(this.user);

  @override
  List<Object?> get props => [user];
}
