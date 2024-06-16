part of 'qr_cam_bloc.dart';

abstract class QrCamEvent extends Equatable {
  const QrCamEvent();

  @override
  List<Object> get props => [];
}

class QrCamPermissionCheck extends QrCamEvent {}

class RegisterQrPayment extends QrCamEvent {
  final int requestId;
  const RegisterQrPayment({required this.requestId});

  @override
  List<Object> get props => [];
}
