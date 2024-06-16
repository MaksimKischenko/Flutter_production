part of 'supplier_update_bloc.dart';

abstract class SupplierUpdateEvent extends Equatable {
  const SupplierUpdateEvent();

  @override
  List<Object> get props => [];
}

class SupplierUpdateInit extends SupplierUpdateEvent {}

class SupplierUpdateRun extends SupplierUpdateEvent {
  final SupplierUpdateRequest supplier;

  const SupplierUpdateRun(this.supplier);

  @override
  List<Object> get props => [supplier];
}