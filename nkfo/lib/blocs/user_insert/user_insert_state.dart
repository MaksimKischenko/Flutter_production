part of 'user_insert_bloc.dart';

abstract class UserInsertState extends Equatable {
  const UserInsertState();
  
  @override
  List<Object?> get props => [];
}

class UserInsertInitial extends UserInsertState {
  final List<UserType> types;
  final List<Supplier> suppliers;

  const UserInsertInitial({
    required this.types,
    required this.suppliers,
  });

  @override
  List<Object> get props => [types, suppliers];
}

class UserInsertInitLoading extends UserInsertState {}

class UserInsertInitError extends UserInsertState {
  final Object? error;

  const UserInsertInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class UserInsertLoading extends UserInsertState {}

class UserInsertError extends UserInsertState {
  final Object? error;

  const UserInsertError({this.error});

  @override
  List<Object?> get props => [error];
}

class UserInsertSuccess extends UserInsertState {
  final User? user;

  const UserInsertSuccess({
    required this.user
  });

  @override
  List<Object?> get props => [user];
}
