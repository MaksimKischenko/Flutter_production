part of 'qr_request_bloc.dart';

@immutable
abstract class QrRequestEvent extends Equatable {
  const QrRequestEvent();

  @override
  List<Object?> get props => [];
}

class GetSecretKeyRequestRun extends QrRequestEvent {}

class GetQrRequestRun extends QrRequestEvent {
  final double? paymentSum;
  const GetQrRequestRun({this.paymentSum});

  @override
  List<Object?> get props => [];
}

// class RegisterQrPayment extends QrRequestEvent {
//   final int requestId;
//   const RegisterQrPayment({
//     required this.requestId,
//   });
//   @override
//   List<Object?> get props => [];
// }

class EmitInitialState extends QrRequestEvent {
  const EmitInitialState();

  @override
  List<Object?> get props => [];
}

class ConfirmQrPaymentRequestRun extends QrRequestEvent {
  final int? code;
  final int requestId;

  const ConfirmQrPaymentRequestRun({
    required this.requestId,
    required this.code,
  });

  @override
  List<Object?> get props => [code, requestId];
}

class CancelQrPaymentRequestRun extends QrRequestEvent {
  final String code;
  final int requestId;
  const CancelQrPaymentRequestRun({
    required this.requestId,
    required this.code,
  });

  @override
  List<Object?> get props => [code, requestId];
}

class ConfirmQrChangeUiAfterStatusSuccess extends QrRequestEvent {
  final int requestId;

  const ConfirmQrChangeUiAfterStatusSuccess({
    required this.requestId,
  });

  @override
  List<Object?> get props => [requestId];
}
