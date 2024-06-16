part of 'claim_qr_bloc.dart';

abstract class ClaimQrEvent extends Equatable {
  const ClaimQrEvent();

  @override
  List<Object> get props => [];
}

class ClaimQrCheck extends ClaimQrEvent {
  final String qrData;
  final DateTime from;

  const ClaimQrCheck({
    required this.qrData,
    required this.from
  });

  @override
  List<Object> get props => [qrData, from];

  @override
  String toString() => 'ClaimQrCheck { qrData = $qrData }';
}