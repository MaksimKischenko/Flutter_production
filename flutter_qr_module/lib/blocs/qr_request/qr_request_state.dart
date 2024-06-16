// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'qr_request_bloc.dart';

@immutable
abstract class QrRequestState extends Equatable {
  final int requestId;
  final bool isPinFieldVisible;
  const QrRequestState({
    this.isPinFieldVisible = false,
    this.requestId = 0,
  });

  @override
  List<Object?> get props => [];
}

class QrRequestInitial extends QrRequestState {
  const QrRequestInitial({
    super.requestId,
    super.isPinFieldVisible,
  });
}

class QrRequestLoading extends QrRequestState {}

class QrRequestCancelSuccessState extends QrRequestState {}

class QrRequestConfirmQrChangeUiAfterStatusSuccess extends QrRequestState {
  const QrRequestConfirmQrChangeUiAfterStatusSuccess({
    super.requestId,
    super.isPinFieldVisible,
  });

  @override
  List<Object> get props => [requestId, isPinFieldVisible];
}

class GetQrRequestLoaded extends QrRequestState {
  final double? bankSumLimit;
  final String qrCode;
  final int qrCodeLifetime;
  final bool isExpired;

  const GetQrRequestLoaded({
    super.isPinFieldVisible,
    super.requestId,
    this.isExpired = false,
    this.bankSumLimit,
    required this.qrCode,
    required this.qrCodeLifetime,
  });
}

class QrRequestTriggerStatus extends QrRequestState {
  final double? bankSumLimit;

  const QrRequestTriggerStatus({
    // super.isPinFieldVisible,
    this.bankSumLimit,
    super.requestId,
  });
}

class ConfirmQrPaymentRequestSuccess extends QrRequestState {}

class QrRequestError extends QrRequestState {
  final Object? error;

  const QrRequestError({this.error});

  @override
  List<Object?> get props => [error];
}

class QrRequestErrorKomplat extends QrRequestState {
  final String errorMessage;
  final int errorCode;

  const QrRequestErrorKomplat({
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object> get props => [errorMessage, errorCode];
}
