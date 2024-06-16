part of 'payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object> get props => [];
}

class PaymentsLoad extends PaymentsEvent {
  final PaymentsFilterData filter;

  const PaymentsLoad({
    required this.filter
  });

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'PaymentsLoad { filter: $filter }';
}

class PaymentsLoadMore extends PaymentsEvent {
  final PaymentsFilterData filter;
  final int lastPaymentId;

  const PaymentsLoadMore({
    required this.filter,
    required this.lastPaymentId
  });

  @override
  List<Object> get props => [filter, lastPaymentId];

  @override
  String toString() => 'PaymentsLoadMore { filter: $filter, lastPaymentId: $lastPaymentId }';
}