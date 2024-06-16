// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_insert_bloc.dart';

abstract class UserInsertState extends Equatable {
  const UserInsertState();
  
  @override
  List<Object?> get props => [];
}

class UserInsertLoading extends UserInsertState {}

class UserInsertInitial extends UserInsertState {
  final List<UserType> userTypes;

  const UserInsertInitial({
    required this.userTypes,
  });

  @override
  List<Object?> get props => [userTypes];
}

class UserInsertSuccess extends UserInsertState {
  final User user;

  const UserInsertSuccess({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UserInsertNetworkError extends UserInsertState {
  final Object? error;

  const UserInsertNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}
