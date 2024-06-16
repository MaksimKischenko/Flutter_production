part of 'payments_bloc.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();
  
  @override
  List<Object?> get props => [];
}

class PaymentsLoading extends PaymentsState {}

class PaymentsInitial extends PaymentsState {}

class PaymentsError extends PaymentsState {
  final ActionType actionType;
  final Object error;

  const PaymentsError({
    required this.actionType,
    required this.error
  });

  @override
  List<Object> get props => [actionType, error];
}

class PaymentsErrorKomplat extends PaymentsState {
  final ActionType actionType;
  final String? errorMessage;
  final int errorCode;

  const PaymentsErrorKomplat({
    required this.actionType,
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [actionType, errorMessage, errorCode];
}

class PaymentsSuccessLoad extends PaymentsState {
  final List<Payment> list;

  const PaymentsSuccessLoad({
    required this.list
  });

  @override
  List<Object> get props => [list];
}

class PaymentsSuccessLoadMore extends PaymentsState {
  final List<Payment> list;

  const PaymentsSuccessLoadMore({
    required this.list
  });

  @override
  List<Object> get props => [list];
}
