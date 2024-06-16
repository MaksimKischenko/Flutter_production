part of 'claims_bloc.dart';

abstract class ClaimsState extends Equatable {
  const ClaimsState();
  
  @override
  List<Object?> get props => [];
}

class ClaimsLoading extends ClaimsState {}

class ClaimsInitial extends ClaimsState {
  final ClaimsFilterData filter;

  const ClaimsInitial({
    required this.filter,
  });
}

class ClaimsError extends ClaimsState {
  final ActionType? actionType;
  final Object error;

  const ClaimsError({
    required this.actionType,
    required this.error
  });

  @override
  List<Object?> get props => [actionType, error];
}

class ClaimsErrorKomplat extends ClaimsState {
  final ActionType? actionType;
  final String? errorMessage;
  final int errorCode;

  const ClaimsErrorKomplat({
    required this.actionType,
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [actionType, errorMessage, errorCode];
}

class ClaimsSuccessLoad extends ClaimsState {
  final List<Claim> list;

  const ClaimsSuccessLoad({
    required this.list
  });

  @override
  List<Object> get props => [list];
}

class ClaimsSuccessLoadMore extends ClaimsState {
  final List<Claim> list;
  final bool isLoadMoreAvailable;

  const ClaimsSuccessLoadMore({
    required this.list,
    this.isLoadMoreAvailable = true
  });

  @override
  List<Object> get props => [list, isLoadMoreAvailable];
}

class ClaimsSuccessDelete extends ClaimsState {
  final int id;

  const ClaimsSuccessDelete(this.id);

  @override
  List<Object> get props => [id];
}

class ClaimsSuccessIncome extends ClaimsState {
  final Claim claim;

  const ClaimsSuccessIncome(this.claim);

  @override
  List<Object?> get props => [claim];
}