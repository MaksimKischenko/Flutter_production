part of 'info_supplier_bloc.dart';

@immutable
abstract class InfoSupplierEvent extends Equatable {
  const InfoSupplierEvent();

  @override
  List<Object?> get props => [];
}

class InfoSupplierLoad extends InfoSupplierEvent {
  final int? supplierUNN;
  final String? supplierName;

  const InfoSupplierLoad({
    this.supplierUNN,
    this.supplierName,
  });

  @override
  List<Object?> get props => [supplierUNN, supplierName];
}

class InfoSupplierSelected extends InfoSupplierEvent {}