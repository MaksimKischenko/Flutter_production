part of 'payments_history_bloc.dart';

abstract class PaymentsHistoryEvent extends Equatable {
  const PaymentsHistoryEvent();

  @override
  List<Object> get props => [];
}

class PaymentsHistoryInit extends PaymentsHistoryEvent {}

class PaymentsHistoryLoad extends PaymentsHistoryEvent {
  final PaymentsHistoryFiltersScreenArgs searchFilters;

  const PaymentsHistoryLoad({
    required this.searchFilters
  });

  @override
  List<Object> get props => [searchFilters];
}

class PaymentsHistoryLoadMore extends PaymentsHistoryEvent {
  final int lastPaymentId;

  const PaymentsHistoryLoadMore({
    required this.lastPaymentId
  });

  @override
  List<Object> get props => [lastPaymentId];
}