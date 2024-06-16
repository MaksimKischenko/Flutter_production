part of 'claim_info_bloc.dart';

abstract class ClaimInfoState extends Equatable {
  const ClaimInfoState();
  
  @override
  List<Object> get props => [];
}

class ClaimInfoLoading extends ClaimInfoState {}

class ClaimInfoInitial extends ClaimInfoState {
  final Map<String, dynamic> info;
  //final String qrData;

  const ClaimInfoInitial({
    required this.info,
    //required this.qrData,
  });

  @override
  List<Object> get props => [info];

}