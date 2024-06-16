part of 'qr_cam_bloc.dart';

abstract class QrCamState extends Equatable {
  const QrCamState();
  
  @override
  List<Object> get props => [];
}

class QrCamLoading extends QrCamState {}

class QrCamPemissionDenied extends QrCamState {}

class QrCamPemissionPermamentlyDenied extends QrCamState {}

class QrCamPemissionGranted extends QrCamState {
  final bool currentFlash;

  const QrCamPemissionGranted({this.currentFlash = false});

  @override
  List<Object> get props => [currentFlash];

  @override
  String toString() => 'QrCamPemissionGranted {currentFlash = $currentFlash}';
}