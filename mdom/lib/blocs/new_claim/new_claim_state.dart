part of 'new_claim_bloc.dart';

abstract class NewClaimState extends Equatable {
  const NewClaimState();
  
  @override
  List<Object?> get props => [];
}

class NewClaimLoading extends NewClaimState {}

class NewClaimInitial extends NewClaimState {}

class NewClaimError extends NewClaimState {
  final Object error;

  const NewClaimError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class NewClaimErrorKomplat extends NewClaimState {
  final String? errorMessage;
  final int errorCode;

  const NewClaimErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class NewClaimSuccessCreate extends NewClaimState {
  final Service service;
  final Claim? claim;
  final String qrUrl;

  const NewClaimSuccessCreate({
    required this.service,
    required this.claim,
    required this.qrUrl,
  });

  @override
  List<Object?> get props => [
    service,
    claim,
    qrUrl,
  ];
}