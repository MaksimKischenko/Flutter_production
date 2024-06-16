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

class ClaimsSort extends ClaimsEvent {
  final bool ascending;
  final int sortIndex;

  const ClaimsSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];
}


class ClaimsLoadMore extends ClaimsEvent {
  final int lastClaimId;

  const ClaimsLoadMore({
    required this.lastClaimId
  });

  @override
  List<Object> get props => [lastClaimId];
}
