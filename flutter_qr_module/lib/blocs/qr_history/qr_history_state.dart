part of 'qr_history_bloc.dart';

@immutable
abstract class QrHistoryState extends Equatable {
  const QrHistoryState();

  @override
  List<Object?> get props => [];
}

class QrHistoryInitial extends QrHistoryState {}

class QrHistoryLoading extends QrHistoryState {}

class GetQROperationSuccess extends QrHistoryState {
  final List<QRTransaction>? qrTransaction;
  final int transactionsCount;
  const GetQROperationSuccess({
    required this.qrTransaction,
    required this.transactionsCount,
  });
}

class GetQRCheckDuplicateSuccess extends QrHistoryState {
  final String dateOfPayment;
  final String receiptNumber;
  final Receipt? receipt;
  const GetQRCheckDuplicateSuccess({
    required this.dateOfPayment,
    required this.receiptNumber,
    required this.receipt,
  });
}

class QrHistoryError extends QrHistoryState {
  final Object? error;

  const QrHistoryError({this.error});

  @override
  List<Object?> get props => [error];
}

class QrHistoryErrorKomplat extends QrHistoryState {
  final String errorMessage;
  final int errorCode;

  const QrHistoryErrorKomplat({
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object> get props => [errorMessage, errorCode];
}
