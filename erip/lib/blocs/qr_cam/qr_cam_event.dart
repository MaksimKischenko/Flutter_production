part of 'qr_cam_bloc.dart';

abstract class QrCamEvent extends Equatable {
  const QrCamEvent();

  @override
  List<Object> get props => [];
}

class QrCamPermissionCheck extends QrCamEvent {}

class QrCamToggleFlash extends QrCamEvent {}

class QrCamDisableFlash extends QrCamEvent {}