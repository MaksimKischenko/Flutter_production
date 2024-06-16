part of 'claims_bloc.dart';

abstract class ClaimsEvent extends Equatable {
  const ClaimsEvent();

  @override
  List<Object> get props => [];
}

class ClaimsLoad extends ClaimsEvent {
  final ClaimsFilterData filter;

  const ClaimsLoad({
    required this.filter
  });

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'ClaimsLoad { filter: $filter }';
}

class ClaimsLoadMore extends ClaimsEvent {
  final ClaimsFilterData filter;
  final int lastClaimId;

  const ClaimsLoadMore({
    required this.filter,
    required this.lastClaimId
  });

  @override
  List<Object> get props => [filter, lastClaimId];

  @override
  String toString() => 'ClaimsLoadMore { filter: $filter, lastClaimId: $lastClaimId }';
}

class ClaimsDeleteClaim extends ClaimsEvent {
  final int id;

  const ClaimsDeleteClaim(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ClaimsDeleteClaim { id: $id }';
}

class ClaimsNewClaim extends ClaimsEvent {
  final NewClaimData data;

  const ClaimsNewClaim(this.data);

  @override
  List<Object> get props => [data];
}