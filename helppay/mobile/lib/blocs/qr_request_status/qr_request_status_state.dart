part of 'qr_request_status_bloc.dart';

@immutable
abstract class QrRequestStatusState extends Equatable {
  final String decriptedData;
  final bool continueStatusCheck;
  final int? requestId;

  const QrRequestStatusState({
    this.continueStatusCheck = false,
    this.requestId,
    this.decriptedData = '',
  });

  @override
  List<Object?> get props => [continueStatusCheck];
}

class QrRequestStatusInitial extends QrRequestStatusState {
  const QrRequestStatusInitial({
    super.continueStatusCheck,
  });
}

class QrRequestStatusInProgress extends QrRequestStatusState {
  const QrRequestStatusInProgress({
    super.continueStatusCheck,
    super.decriptedData,
  });

  @override
  List<Object> get props => [];
}

class QrRequestStatusStopChecking extends QrRequestStatusState {
  // final GetQrRequestLoaded? state;
  const QrRequestStatusStopChecking({
    super.decriptedData,
    super.continueStatusCheck,
  });

  @override
  List<Object> get props => [];
}

class QrRequestStatusContinueChecking extends QrRequestStatusState {
  // final GetQrRequestLoaded? state;
  const QrRequestStatusContinueChecking({
    super.decriptedData,
    super.continueStatusCheck,
    super.requestId,
  });

  @override
  List<Object> get props => [decriptedData, continueStatusCheck];
}

class QrRequestStatusPaymentRequestSuccess extends QrRequestStatusState {
  final bool showPinWidget;
  final int requestId;
  final String infoMessage;
  // final num paymentSum;

  const QrRequestStatusPaymentRequestSuccess({
    required this.showPinWidget,

    // required this.paymentSum,
    required this.requestId,
    super.continueStatusCheck,
    required this.infoMessage,
  });

  @override
  List<Object> get props => [
        infoMessage,
      ];
}

class QrRequestStatusSuccess extends QrRequestStatusState {
  final bool showPinWidget;
  const QrRequestStatusSuccess({
    super.requestId,
    super.continueStatusCheck,
    required this.showPinWidget,
  });

  @override
  List<Object> get props => [];
}

class QrRequestStatusFail extends QrRequestStatusState {
  final String errorMessage;
  final int? errorCode;

  const QrRequestStatusFail({
    super.continueStatusCheck,
    required this.errorMessage,
    this.errorCode,
  });

  @override
  List<Object> get props => [errorMessage];
}

class SuccessStatusCheckDuplicateLoading extends QrRequestStatusState {
  const SuccessStatusCheckDuplicateLoading();

  @override
  List<Object> get props => [];
}

class SuccessStatusCheckDuplicateAccuired extends QrRequestStatusState {
  final int requestId;
  final String dateOfPayment;
  final String receiptNumber;
  final Receipt? receipt;
  const SuccessStatusCheckDuplicateAccuired({
    required this.requestId,
    required this.dateOfPayment,
    required this.receiptNumber,
    required this.receipt,
  });

  @override
  List<Object> get props => [];
}

class QrRequestStatusError extends QrRequestStatusState {
  final Object? error;

  const QrRequestStatusError({
    super.continueStatusCheck,
    this.error,
  });

  @override
  List<Object?> get props => [
        error,
      ];
}

class QrRequestStatusErrorKomplat extends QrRequestStatusState {
  final String errorMessage;
  final int errorCode;

  const QrRequestStatusErrorKomplat({
    super.continueStatusCheck,
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object> get props => [errorMessage, errorCode];
}
