part of 'supplier_bloc.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();
  
  @override
  List<Object?> get props => [];
}

class SupplierInitial extends SupplierState {
  final Supplier supplier;
  final List<SupplierAccount> services;
  final bool patchIsAvaiableSupplier;
  final bool deleteIsAvaliableSupplier;
  final bool getIsAvailableService;
  final bool postIsAvaliableService;
  final bool patchIsAvaliableService;
  final bool deleteIsAvaliableService;

  const SupplierInitial({
    required this.supplier,
    required this.services,
    this.patchIsAvaiableSupplier = true,
    this.deleteIsAvaliableSupplier = true,
    this.getIsAvailableService = true,
    this.postIsAvaliableService = true,
    this.patchIsAvaliableService = true,
    this.deleteIsAvaliableService = true
  });

  @override
  List<Object> get props => [supplier, services, patchIsAvaiableSupplier, deleteIsAvaliableSupplier,
    getIsAvailableService, postIsAvaliableService, patchIsAvaliableService, deleteIsAvaliableService
  ];
}

class SupplierLoading extends SupplierState {}

class SupplierInitError extends SupplierState {
  final Object? error;

  const SupplierInitError({this.error});

  @override
  List<Object?> get props => [error];
}

class SupplierError extends SupplierState {
  final Object? error;

  const SupplierError({this.error});

  @override
  List<Object?> get props => [error];
}
class SupplierDeleteSuccess extends SupplierState {
  final Supplier? supplier;

  const SupplierDeleteSuccess({
    required this.supplier
  });

  @override
  List<Object?> get props => [supplier];
}

class SupplierServiceDeleteSuccess extends SupplierState {
  final SupplierAccount service;

  const SupplierServiceDeleteSuccess({
    required this.service
  });

  @override
  List<Object> get props => [service];
}