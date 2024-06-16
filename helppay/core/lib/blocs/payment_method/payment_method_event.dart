part of 'payment_method_bloc.dart';

abstract class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object?> get props => [];
}

class RegisterPaymentMethod extends PaymentMethodEvent {
  final List<MdomLoginResponseProductsCurrent> accountsList;
  final String typePan;
  final List<MdomResponseParam> paymentMethodData;
  const RegisterPaymentMethod(
      {required this.accountsList,
      required this.paymentMethodData,
      required this.typePan});

  @override
  List<Object?> get props => [paymentMethodData];

  @override
  String toString() => 'Register payment method event emitted';
}

class ConfirmPaymentMethod extends PaymentMethodEvent {
  final RequestIdentifier requestIdentifier;
  final List<MdomResponseParam> paymentMethodData;
  final String typePan;

  // final int otpCode;

  const ConfirmPaymentMethod({
    required this.requestIdentifier,
    required this.paymentMethodData,
    required this.typePan,

    // required this.otpCode,
  });

  @override
  List<Object?> get props => [requestIdentifier];

  @override
  String toString() => 'Register payment method event emitted';
}
