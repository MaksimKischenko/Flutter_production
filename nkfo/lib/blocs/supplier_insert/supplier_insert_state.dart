part of 'supplier_insert_bloc.dart';

abstract class SupplierInsertState extends Equatable {
  const SupplierInsertState();
  
  @override
  List<Object?> get props => [];
}

class SupplierInsertInitial extends SupplierInsertState {
  final List<Bank> banks;

  const SupplierInsertInitial({
    required this.banks
  });

  @override
  List<Object?> get props => [banks];
}

class SupplierInsertInitLoading extends SupplierInsertState {}

class SupplierInsertInitError extends SupplierInsertState {
  final Object? error;

  const SupplierInsertInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class SupplierInsertLoading extends SupplierInsertState {}

class SupplierInsertError extends SupplierInsertState {
  final Object? error;

  const SupplierInsertError({this.error});

  @override
  List<Object?> get props => [error];
}

class SupplierInsertSuccess extends SupplierInsertState {
  final Supplier? supplier;

  const SupplierInsertSuccess({
    required this.supplier
  });

  @override
  List<Object?> get props => [supplier];
}
