part of 'payments_history_bloc.dart';

abstract class PaymentsHistoryState extends Equatable {
  const PaymentsHistoryState();

  @override
  List<Object?> get props => [];
}

class PaymentsHistoryInitial extends PaymentsHistoryState {}

class PaymentsHistoryLoading extends PaymentsHistoryState {}

class PaymentsHistoryError extends PaymentsHistoryState {
  final ActionType actionType;
  final Object error;

  const PaymentsHistoryError({
    required this.actionType,
    required this.error
  });

  @override
  List<Object> get props => [actionType, error];
}

class PaymentsHistoryErrorKomplat extends PaymentsHistoryState {
  final ActionType actionType;
  final String? errorMessage;
  final int? errorCode;

  const PaymentsHistoryErrorKomplat({
    required this.actionType,
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [actionType, errorMessage, errorCode];
}

class PaymentsHistorySuccessLoad extends PaymentsHistoryState {
  final List<Payment> list;

  const PaymentsHistorySuccessLoad({
    required this.list
  });

  @override
  List<Object> get props => [list];
}

class PaymentsHistorySuccessLoadMore extends PaymentsHistoryState {
  final List<Payment> list;

  const PaymentsHistorySuccessLoadMore({
    required this.list
  });

  @override
  List<Object> get props => [list];
}