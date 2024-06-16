part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsInit extends ProductsEvent {}

class ProductsMakeMain extends ProductsEvent {
  final MdomLoginResponseProductsCurrent? product;

  const ProductsMakeMain({required this.product});

  @override
  List<Object?> get props => [product];

  @override
  String toString() => 'ProductsMakeMain { product: $product }';
}

class ProductsDelete extends ProductsEvent {
  final MdomLoginResponseProductsCurrent? product;

  const ProductsDelete({required this.product});

  @override
  List<Object?> get props => [product];

  @override
  String toString() => 'ProductsDelete { product: $product }';
}

class GetProductBalance extends ProductsEvent {
  final TypePan typePan;
  final Pan pan;

  const GetProductBalance({
    required this.typePan,
    required this.pan,
  });

  @override
  List<Object?> get props => [pan, typePan];

  // @override
  // String toString() => 'ProductsDelete { product: $product }';
}

class ProductsAdd extends ProductsEvent {
  final ProductsTab tab;
  final List<MdomResponseParam> params;

  const ProductsAdd({required this.tab, required this.params});

  @override
  List<Object> get props => [params];

  @override
  String toString() => 'ProductsAdd { params: $params }';
}

class ProductRename extends ProductsEvent {
  final String pan;
  final MdomResponseParam nameParam;

  const ProductRename({required this.pan, required this.nameParam});

  @override
  List<Object> get props => [pan, nameParam];

  @override
  String toString() => 'ProductRename { pan: $pan, nameParam: $nameParam }';
}
