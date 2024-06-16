part of 'payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object> get props => [];
}

class PaymentsInit extends PaymentsEvent {
  final double maxAmount;
  final List<Payment> payments;

  const PaymentsInit(this.maxAmount, this.payments);

  @override
  List<Object> get props => [maxAmount, payments];
}

class PaymentsDeletePayment extends PaymentsEvent {
  final Payment payment;

  const PaymentsDeletePayment(this.payment);

  @override
  List<Object> get props => [payment];
}

class PaymentsUpdate extends PaymentsEvent {}