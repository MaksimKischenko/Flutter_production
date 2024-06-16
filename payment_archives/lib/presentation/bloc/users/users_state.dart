// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  final int? typeId;

  const UsersLoaded({
    required this.users,
    this.typeId
  });

  @override
  List<Object?> get props => [users, typeId];
}


class UsersDeleteUserSuccess extends UsersState {
  final int id;

  const UsersDeleteUserSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class UsersAddUserSuccess extends UsersState {}

class UsersEditUserSuccess extends UsersState {}

class UsersError extends UsersState {
  final Object? error;

  const UsersError({this.error});

  @override
  List<Object?> get props => [error];
}


