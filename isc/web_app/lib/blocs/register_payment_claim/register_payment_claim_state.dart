// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_payment_claim_bloc.dart';

@immutable
abstract class RegisterPaymentClaimState extends Equatable {
  const RegisterPaymentClaimState();
  
  @override
  List<Object?> get props => [];
}

class RegisterPaymentClaimInitial extends RegisterPaymentClaimState {}
class RegisterPaymentClaimLoading extends RegisterPaymentClaimState {}

class RegisterPaymentClaimErrorKomplat extends RegisterPaymentClaimState {
  final String? errorMessage;
  final int errorCode;

  const RegisterPaymentClaimErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class RegisterPaymentClaimError extends RegisterPaymentClaimState {
  final Object error;
  const RegisterPaymentClaimError({

    required this.error
  });

  @override
  List<Object?> get props => [error];
}


class RegisterPaymentClaimSuccess extends RegisterPaymentClaimState {
  final int paymentId;  

  const RegisterPaymentClaimSuccess({
    required this.paymentId,
  });

  @override
  List<Object?> get props => [paymentId]; 
}

