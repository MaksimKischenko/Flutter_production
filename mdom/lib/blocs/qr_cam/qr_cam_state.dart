part of 'qr_cam_bloc.dart';

abstract class QrCamState extends Equatable {
  const QrCamState();
  
  @override
  List<Object> get props => [];
}

class QrCamLoading extends QrCamState {}

class QrCamPermissionDenied extends QrCamState {}

class QrCamPermissionPermamentlyDenied extends QrCamState {}

class QrCamPermissionGranted extends QrCamState {}