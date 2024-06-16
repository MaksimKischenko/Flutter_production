part of 'search_payment_bloc.dart';

abstract class SearchPaymentEvent extends Equatable {
  const SearchPaymentEvent();

  @override
  List<Object?> get props => [];
}


class SearchPaymentSaveLimits extends SearchPaymentEvent {
  final PaymentLoadedLimit paymentLoadedLimit;
  
  const SearchPaymentSaveLimits({
   required this.paymentLoadedLimit,
  });

  @override
  List<Object?> get props => [paymentLoadedLimit];
}

class SearchPaymentInitialize extends SearchPaymentEvent {
  final SearchPaymentData searchPaymentBody;
  final SearchPaymentMethod searchPaymentMethod;

  const SearchPaymentInitialize({
   required this.searchPaymentBody,
   required this.searchPaymentMethod
  });

  @override
  List<Object?> get props => [searchPaymentBody, searchPaymentMethod];
}

class SearchPaymentSort extends SearchPaymentEvent {

  final bool ascending;
  final int sortIndex;

  const SearchPaymentSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];

}

class SearchPaymentClearData extends SearchPaymentEvent {}

class SearchPaymentRun extends SearchPaymentEvent {
  final WebSocketBodyData? webSocketData;

  const SearchPaymentRun({
   required this.webSocketData
  });
}