// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_payment_bloc.dart';

abstract class SearchPaymentState extends Equatable {
  const SearchPaymentState();
  
  @override
  List<Object?> get props => [];
}

class SearchPaymentLoading extends SearchPaymentState {}

class SearchPaymentActualInfo extends SearchPaymentState {
  final bool initialState;
  final List<Payment> payments;
  final SearchPaymentData requestData;
  final PaymentLoadedLimit paymentLoadedLimit;
  final bool isActiveNextLoaded;

  const SearchPaymentActualInfo({
   required this.initialState,
   required this.payments,
   required this.requestData,
   required this.paymentLoadedLimit,
   this.isActiveNextLoaded = false
  });

  @override
  List<Object?> get props => [
    initialState, 
    payments, 
    requestData, 
    paymentLoadedLimit, 
    isActiveNextLoaded
  ];
}

class SearchPaymentPartLoaded extends SearchPaymentState {
  final List<Payment> nextLoadedPayments;


  const SearchPaymentPartLoaded({
    required this.nextLoadedPayments,
  });

  @override
  List<Object?> get props => [nextLoadedPayments];
}

class SearchPaymentNetworkError extends SearchPaymentState {

  final Object? error;

  const SearchPaymentNetworkError({this.error});

  @override
  List<Object?> get props => [error];
}
