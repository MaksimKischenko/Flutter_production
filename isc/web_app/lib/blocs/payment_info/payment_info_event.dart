part of 'payment_info_bloc.dart';

abstract class PaymentInfoEvent extends Equatable {
  const PaymentInfoEvent();

  @override
  List<Object> get props => [];
}

class PaymentInfoInit extends PaymentInfoEvent {}