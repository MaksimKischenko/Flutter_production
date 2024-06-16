part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  final bool? balanceRequested;
  const ProductsState({this.balanceRequested = false});

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  final MdomResponseParams accountParams;
  final MdomResponseParams cardParams;
  final List<MdomLoginResponseProductsCurrent> accountsList;
  final List<MdomLoginResponseProductsCurrent> cardsList;
  final MdomLoginResponseProductsCurrent? mainProduct;
  final MainProductType? mainProductType;

  const ProductsInitial({
    required this.accountParams,
    required this.cardParams,
    required this.accountsList,
    required this.cardsList,
    required this.mainProduct,
    required this.mainProductType,
    super.balanceRequested,
  });

  @override
  List<Object?> get props => [
        accountParams,
        cardParams,
        accountsList,
        cardsList,
        mainProduct,
        mainProductType,
        balanceRequested,
      ];
}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {
  final Object error;

  const ProductsError({required this.error});

  @override
  List<Object> get props => [error];
}

class ProductsErrorKomplat extends ProductsState {
  final String? errorMessage;
  final int errorCode;

  const ProductsErrorKomplat({
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class ProductsSuccessMakeMain extends ProductsState {}

class ProductsBalanceLoaded extends ProductsState {
  final Balance? balance;
  const ProductsBalanceLoaded({
    required this.balance,
    super.balanceRequested,
  });
  @override
  List<Object?> get props => [balance];
}

class ProductsSuccessDelete extends ProductsState {}

class ProductsSuccessAdd extends ProductsState {
  final ProductsTab tab;

  const ProductsSuccessAdd({required this.tab});
}

class ProductsSuccessRename extends ProductsState {}
