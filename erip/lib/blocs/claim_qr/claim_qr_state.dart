part of 'claim_qr_bloc.dart';

abstract class ClaimQrState extends Equatable {
  const ClaimQrState();
  
  @override
  List<Object?> get props => [];
}

class ClaimQrInitial extends ClaimQrState {}

class ClaimQrLoading extends ClaimQrState {}

class ClaimQrError extends ClaimQrState {
  final Object? error;

  const ClaimQrError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ClaimQrErrorKomplat extends ClaimQrState {
  final String? errorMessage;
  final int errorCode;

  const ClaimQrErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class ClaimQrSuccessChecked extends ClaimQrState {
  final Claim claim;

  const ClaimQrSuccessChecked(this.claim);

  @override
  List<Object> get props => [claim];
}