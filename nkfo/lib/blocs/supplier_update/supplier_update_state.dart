part of 'supplier_update_bloc.dart';

abstract class SupplierUpdateState extends Equatable {
  const SupplierUpdateState();
  
  @override
  List<Object?> get props => [];
}

class SupplierUpdateInitial extends SupplierUpdateState {
  final List<Bank>? banks;
  final Supplier? supplier;

  const SupplierUpdateInitial({
    required this.banks,
    required this.supplier
  });

  @override
  List<Object?> get props => [banks, supplier];
}

class SupplierUpdateInitLoading extends SupplierUpdateState {}

class SupplierUpdateInitError extends SupplierUpdateState {
  final Object? error;

  const SupplierUpdateInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class SupplierUpdateLoading extends SupplierUpdateState {}

class SupplierUpdateError extends SupplierUpdateState {
  final Object? error;

  const SupplierUpdateError({this.error});

  @override
  List<Object?> get props => [error];
}

class SupplierUpdateSuccess extends SupplierUpdateState {
  final Supplier? supplier;

  const SupplierUpdateSuccess({
    required this.supplier
  });

  @override
  List<Object?> get props => [supplier];
}