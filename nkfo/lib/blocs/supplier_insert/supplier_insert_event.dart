part of 'supplier_insert_bloc.dart';

abstract class SupplierInsertEvent extends Equatable {
  const SupplierInsertEvent();

  @override
  List<Object> get props => [];
}

class SupplierInsertInit extends SupplierInsertEvent {}

class SupplierInsertRun extends SupplierInsertEvent {
  final SupplierInsertRequest supplier;

  const SupplierInsertRun(this.supplier);

  @override
  List<Object> get props => [supplier];
}