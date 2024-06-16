part of 'new_claim_bloc.dart';

abstract class NewClaimEvent extends Equatable {
  const NewClaimEvent();

  @override
  List<Object> get props => [];
}

class NewClaimProceed extends NewClaimEvent {
  final NewClaimData data;

  const NewClaimProceed(this.data);

  @override
  List<Object> get props => [data];
}
