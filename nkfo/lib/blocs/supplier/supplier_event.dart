part of 'supplier_bloc.dart';

abstract class SupplierEvent extends Equatable {
  const SupplierEvent();

  @override
  List<Object> get props => [];
}

class SupplierInit extends SupplierEvent {}

class SupplierUpdate extends SupplierEvent {
  final Supplier supplier;

  const SupplierUpdate(this.supplier);

  @override
  List<Object> get props => [supplier];
}

class SupplierDelete extends SupplierEvent {}

class SupplierNewService extends SupplierEvent {
  final SupplierAccount service;

  const SupplierNewService(this.service);

  @override
  List<Object> get props => [service];

}

class SupplierDeleteService extends SupplierEvent {
  final int id;

  const SupplierDeleteService(this.id);

  @override
  List<Object> get props => [id];
}

class SupplierUpdateService extends SupplierEvent {
  final SupplierAccount service;

  const SupplierUpdateService(this.service);

  @override
  List<Object> get props => [service];
}