part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object?> get props => [];
}

class UsersInitLoading extends UsersState {}

class UsersInitError extends UsersState {
  final Object? error;

  const UsersInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  final UsersSort sort;
  final bool sortAscending;
  final bool isLoadMoreAvaiable;
  final List<UserType> types;
  final UserType? selectedType;
  final List<Supplier> suppliers;
  final int? supplierId;
  final bool getIsAvaliableUser;
  final bool getIsAvaliableUserType ;
  final bool postIsAvaliableUser;
  final bool patchIsAvaliableUser;
  final bool deleteIsAvaliableUser;
  final bool getIsAvaliableSupplier;
  final bool resetPasswordIsAvaliableUser;


  const UsersLoaded({
    required this.users,
    required this.sort,
    required this.sortAscending,
    required this.isLoadMoreAvaiable,
    required this.types,
    required this.selectedType,
    required this.suppliers,
    required this.supplierId,
    this.getIsAvaliableUser = true,
    this.getIsAvaliableUserType = true,
    this.postIsAvaliableUser = true,
    this.patchIsAvaliableUser = true,
    this.deleteIsAvaliableUser = true,
    this.getIsAvaliableSupplier = true,
    this.resetPasswordIsAvaliableUser = true
  });

  @override
  List<Object?> get props => [users, sort, sortAscending, isLoadMoreAvaiable, types, selectedType, suppliers, supplierId,
   getIsAvaliableUser, getIsAvaliableUserType, postIsAvaliableUser, patchIsAvaliableUser, deleteIsAvaliableUser, 
   getIsAvaliableSupplier, resetPasswordIsAvaliableUser
  ];
}

class UsersError extends UsersState {
  final Object? error;

  const UsersError({this.error});

  @override
  List<Object?> get props => [error];
}

class UsersDeleteUserSuccess extends UsersState {
  final int id;

  const UsersDeleteUserSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class UsersDeleteGroupUserSuccess extends UsersState {}

class UsersChangeUserStatusSuccess extends UsersState {}

class UsersResetUserPasswordSuccess extends UsersState {}

class UserGetNotAllow extends UsersState {
  final String? message;

  const UserGetNotAllow({this.message});

  @override
  List<Object?> get props => [message];
}