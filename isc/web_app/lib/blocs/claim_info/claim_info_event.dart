part of 'claim_info_bloc.dart';

abstract class ClaimInfoEvent extends Equatable {
  const ClaimInfoEvent();

  @override
  List<Object> get props => [];
}

class ClaimInfoInit extends ClaimInfoEvent {}