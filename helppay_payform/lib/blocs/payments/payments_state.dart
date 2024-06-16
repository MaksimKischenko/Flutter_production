part of 'payments_bloc.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();
  
  @override
  List<Object?> get props => [];
}

class PaymentsLoading extends PaymentsState {}

class PaymentsInitial extends PaymentsState {
  final double maxAmount;
  final double totalAmount;
  final double remainingAmount;
  final List<Payment> payments;
  
  const PaymentsInitial({
    required this.maxAmount,
    required this.totalAmount,
    required this.remainingAmount,
    required this.payments
  });

  @override
  List<Object> get props => [maxAmount, totalAmount, remainingAmount, payments];
}

class PaymentsDeletePaymentSuccess extends PaymentsState {
  final int id;

  const PaymentsDeletePaymentSuccess(this.id);

  @override
  List<Object> get props => [id];
}

class PaymentsError extends PaymentsState {
  final Object error;

  const PaymentsError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class PaymentsErrorKomplat extends PaymentsState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const PaymentsErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}