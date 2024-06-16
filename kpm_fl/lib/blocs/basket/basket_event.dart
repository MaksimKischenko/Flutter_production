part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object> get props => [];
}

class BasketInit extends BasketEvent {}

class BasketClose extends BasketEvent {}

class BasketAddPayment extends BasketEvent {
  final BasketItemWrapper item;

  const BasketAddPayment(this.item);

  @override
  List<Object> get props => [item];
}

class BasketDeletePayment extends BasketEvent {
  final PayRecordResponse item;

  const BasketDeletePayment(this.item);

  @override
  List<Object> get props => [item];
}

class BasketDeleteAllPayments extends BasketEvent {}
