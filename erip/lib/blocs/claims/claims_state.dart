part of 'claims_bloc.dart';

abstract class ClaimsState extends Equatable {
  const ClaimsState();
  
  @override
  List<Object?> get props => [];
}

class ClaimsLoading extends ClaimsState {}

class ClaimsInitial extends ClaimsState {}

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

  const ClaimsSuccessLoadMore({
    required this.list
  });

  @override
  List<Object> get props => [list];
}

class ClaimsSuccessDelete extends ClaimsState {
  final int id;

  const ClaimsSuccessDelete(this.id);

  @override
  List<Object> get props => [id];
}

class ClaimsSuccessCreate extends ClaimsState {
  final String qrUrl;

  const ClaimsSuccessCreate(this.qrUrl);

  @override
  List<Object> get props => [qrUrl];
}