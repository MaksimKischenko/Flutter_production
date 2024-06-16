part of 'qr_request_status_bloc.dart';

@immutable
abstract class QrRequestStatusEvent extends Equatable {
  const QrRequestStatusEvent();

  @override
  List<Object?> get props => [];
}

class GetRequestStatusRequestRun extends QrRequestStatusEvent {
  final int requestId;
  final double? bankSumLimit;
  final bool continueStatusCheck;
  const GetRequestStatusRequestRun({
    required this.requestId,
    this.bankSumLimit,
    required this.continueStatusCheck,
  });

  @override
  List<Object?> get props => [continueStatusCheck, requestId];
}

class GetRequestStatusRequestDecript extends QrRequestStatusEvent {
  final double? agregatorSumLimit;
  final Timer timer;
  final String decryptedData;
  final int requestId;
  final bool continueStatusCheck;
  // final double paymentSum;
  const GetRequestStatusRequestDecript({
    this.agregatorSumLimit,
    // required this.paymentSum,
    required this.timer,
    required this.decryptedData,
    required this.requestId,
    required this.continueStatusCheck,
  });

  @override
  List<Object?> get props => [continueStatusCheck, requestId];
}

class GetCheckDuplicate extends QrRequestStatusEvent {
  final int requestId;

  const GetCheckDuplicate({
    required this.requestId,
  });

  @override
  List<Object?> get props => [requestId];
}
