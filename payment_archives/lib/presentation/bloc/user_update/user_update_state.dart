// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_update_bloc.dart';

abstract class UserUpdateState extends Equatable {
  const UserUpdateState();
  
  @override
  List<Object?> get props => [];
}

class UserUpdateInitial extends UserUpdateState {
  final User? user;
  final List<UserType> userTypes;

  const UserUpdateInitial({
    required this.user,
    required this.userTypes
  });

  @override
  List<Object?> get props => [user, userTypes];
}

class UserUpdateLoading extends UserUpdateState {}


class UserUpdateSuccess extends UserUpdateState {
  final User? user;

  const UserUpdateSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserUpdateNetworkError extends UserUpdateState {
  final Object? error;

  const UserUpdateNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}
