part of 'payment_method_bloc.dart';

abstract class PaymentMethodState extends Equatable {
  const PaymentMethodState();

  @override
  List<Object?> get props => [];
}

class RegisterPaymentMethodSuccess extends PaymentMethodState {
  final int requestId;
  final List<MdomResponseParam> paymentMethodData;
  final String? typePan;

  const RegisterPaymentMethodSuccess({
    required this.requestId,
    required this.paymentMethodData,
    this.typePan,
  });

  @override
  List<Object> get props => [requestId, paymentMethodData];
}

class ConfirmPaymentMethodSuccess extends PaymentMethodState {
  final List<MdomResponseParam> paymentMethodData;

  const ConfirmPaymentMethodSuccess({
    required this.paymentMethodData,
  });

  @override
  List<Object> get props => [paymentMethodData];
}

class RegisterPaymentMethodLoading extends PaymentMethodState {}

class RegisterPaymetnMethodError extends PaymentMethodState {
  final Object error;

  const RegisterPaymetnMethodError({required this.error});

  @override
  List<Object> get props => [error];
}

class RegisterPaymentMethodKomplat extends PaymentMethodState {
  final bool? needPop;
  final String? errorMessage;
  final int errorCode;

  const RegisterPaymentMethodKomplat({
    this.needPop,
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}
