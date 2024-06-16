part of 'claim_info_bloc.dart';

abstract class ClaimInfoState extends Equatable {
  const ClaimInfoState();
  
  @override
  List<Object> get props => [];
}

class ClaimInfoLoading extends ClaimInfoState {}

class ClaimInfoInitial extends ClaimInfoState {
  final List<Device> devices;
  final Map<String, dynamic> info;
  final String qrData;
  final String serviceName;

  const ClaimInfoInitial({
    required this.devices,
    required this.info,
    required this.qrData,
    required this.serviceName
  });

  @override
  List<Object> get props => [devices, info, qrData, serviceName];

}