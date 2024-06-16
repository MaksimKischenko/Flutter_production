part of 'user_update_bloc.dart';

abstract class UserUpdateState extends Equatable {
  const UserUpdateState();

  @override
  List<Object?> get props => [];
}

class UserUpdateInitial extends UserUpdateState {
  final User user;
  final List<UserRole>? userRoles;
  final List<Role>? roles;
  final List<int>? selectedRoles;
  final List<int>? comparisonList;

  const UserUpdateInitial({
    required this.user,
    this.userRoles,
    this.roles,
    this.selectedRoles,
    this.comparisonList,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class UserUpdateInitLoading extends UserUpdateState {}

class UserUpdateInitError extends UserUpdateState {
  final Object? error;

  const UserUpdateInitError({required this.error});

  @override
  List<Object?> get props => [error];
}

class UserUpdateLoading extends UserUpdateState {}

class UserUpdateError extends UserUpdateState {
  final Object? error;

  const UserUpdateError({this.error});

  @override
  List<Object?> get props => [error];
}

class UserUpdateSuccess extends UserUpdateState {
  final User? user;

  const UserUpdateSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}
