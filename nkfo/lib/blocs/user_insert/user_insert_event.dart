part of 'user_insert_bloc.dart';

abstract class UserInsertEvent extends Equatable {
  const UserInsertEvent();

  @override
  List<Object> get props => [];
}

class UserInsertInit extends UserInsertEvent {}

class UserInsertRun extends UserInsertEvent {
  final UserInsertRequest user;

  const UserInsertRun(this.user);

  @override
  List<Object> get props => [user];
}
