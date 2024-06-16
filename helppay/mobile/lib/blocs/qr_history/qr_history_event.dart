part of 'qr_history_bloc.dart';

@immutable
abstract class QrHistoryEvent extends Equatable {
  const QrHistoryEvent();

  @override
  List<Object?> get props => [];
}

class GetQROperationEvent extends QrHistoryEvent {
  final String dateFrom;
  final String dateTo;

  const GetQROperationEvent({
    required this.dateFrom,
    required this.dateTo,
  });

  @override
  List<Object?> get props => [];
}

class GetQRCheckDuplicateEvent extends QrHistoryEvent {
  final List<QRTransaction>? qrTransaction;
  final int transactionsCount;
  final int requestId;
  final int advancedInfoRequired;
  const GetQRCheckDuplicateEvent({
    this.qrTransaction,
    required this.transactionsCount,
    required this.requestId,
    required this.advancedInfoRequired,
  });

  @override
  List<Object?> get props => [];
}
