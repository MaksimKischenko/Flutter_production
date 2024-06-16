part of 'basket_bloc.dart';

abstract class BasketState extends Equatable {
  const BasketState();
  
  @override
  List<Object?> get props => [];
}

class BasketOpened extends BasketState {
  final List<BasketItemWrapper> payments;
  final String kioskReceipt;
  final String barcode;

  const BasketOpened({
    required this.payments,
    required this.kioskReceipt,
    required this.barcode
  });

  @override
  List<Object?> get props => [
    payments,
    kioskReceipt,
    barcode,
  ];
}

class BasketClosed extends BasketState {
  final String? kioskReceipt;
  final String? barcode;

  const BasketClosed({
    this.kioskReceipt,
    this.barcode
  });

  @override
  List<Object?> get props => [kioskReceipt, barcode];

}

class BasketLoading extends BasketState {}

class BasketError extends BasketState {
  final Object error;

  const BasketError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class BasketErrorKomplat extends BasketState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const BasketErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}