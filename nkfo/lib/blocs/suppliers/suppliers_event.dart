part of 'suppliers_bloc.dart';

abstract class SuppliersEvent extends Equatable {
  const SuppliersEvent();

  @override
  List<Object?> get props => [];
}

class SuppliersInit extends SuppliersEvent {
  final SupplierStatus? status;
  final String? unp;
  final String? shortName;
  final SuppliersSort? sort;
  final bool? sortAscending;
  final int loadCount;

  const SuppliersInit({
    this.shortName,
    this.unp,
    this.status,
    this.sort,
    this.sortAscending,
    this.loadCount = AppConfig.suppliersGetLoadCount
  });

  @override
  List<Object?> get props => [status, unp, shortName, sort, sortAscending];

}

class SuppliersLoadMore extends SuppliersEvent {
  final int offset;

  const SuppliersLoadMore(this.offset);

  @override
  List<Object> get props => [offset];
}


class SuppliersNewSupplier extends SuppliersEvent {
  final Supplier supplier;

  const SuppliersNewSupplier(this.supplier);

  @override
  List<Object?> get props => [supplier];
}

class SuppliersUpdateSupplier extends SuppliersEvent {
  final Supplier? supplier;

  const SuppliersUpdateSupplier(this.supplier);

  @override
  List<Object?> get props => [supplier];
}

class SuppliersDeleteSupplier extends SuppliersEvent {
  final Supplier? supplier;

  const SuppliersDeleteSupplier(this.supplier);

  @override
  List<Object?> get props => [supplier];
}