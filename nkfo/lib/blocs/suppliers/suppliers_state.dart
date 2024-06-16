part of 'suppliers_bloc.dart';

abstract class SuppliersState extends Equatable {
  const SuppliersState();
  
  @override
  List<Object?> get props => [];
}

class SuppliersLoading extends SuppliersState {}

class SuppliersLoaded extends SuppliersState {
  final List<Supplier> suppliers;
  final SuppliersSort sort;
  final bool sortAscending;
  final bool isLoadMoreAvaiable;
  final bool postIsAvaliable;


  const SuppliersLoaded({
    required this.suppliers,
    required this.sort,
    required this.sortAscending,
    required this.isLoadMoreAvaiable,
    this.postIsAvaliable = false,
  });

  @override
  List<Object?> get props => [suppliers, sort, sortAscending, isLoadMoreAvaiable, postIsAvaliable];
}

class SuppliersError extends SuppliersState {
  final Object? error;

  const SuppliersError({this.error});

  @override
  List<Object?> get props => [error];
}

class SuppliersGetNotAllow extends SuppliersState {
  final String? message;

  const SuppliersGetNotAllow({this.message});

  @override
  List<Object?> get props => [message];
}
