part of 'claims_bloc.dart';

abstract class ClaimsEvent extends Equatable {
  const ClaimsEvent();

  @override
  List<Object?> get props => [];
}

class ClaimsLoad extends ClaimsEvent {
  final ClaimsFilterData? filter;

  const ClaimsLoad({
    required this.filter
  });

  @override
  List<Object?> get props => [filter];
}

class ClaimsLoadMore extends ClaimsEvent {
  final int lastClaimId;

  const ClaimsLoadMore({
    required this.lastClaimId
  });

  @override
  List<Object> get props => [lastClaimId];
}

class ClaimsDeleteClaim extends ClaimsEvent {
  final int id;

  const ClaimsDeleteClaim(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ClaimsDeleteClaim {id: $id}';
}

/// new claim from NewClaimBloc
class ClaimsNewClaimIncome extends ClaimsEvent {
  final Service service;
  final Claim claim;

  const ClaimsNewClaimIncome({
    required this.service,
    required this.claim,
  });

  @override
  List<Object> get props => [
    service,
    claim,
  ];
}