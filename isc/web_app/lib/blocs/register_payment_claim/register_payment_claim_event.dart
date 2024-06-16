// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_payment_claim_bloc.dart';

@immutable
abstract class RegisterPaymentClaimEvent extends Equatable {
  const RegisterPaymentClaimEvent();

  @override
  List<Object?> get props => [];
}


class RegisterPaymentClaimRun extends RegisterPaymentClaimEvent {
  final int claimId;
  final String memNumber;
  final DateTime memDate; 
  final double paySum; 
  final String account;

  const RegisterPaymentClaimRun({
    required this.claimId,
    required this.memNumber,
    required this.memDate,
    required this.paySum,
    required this.account,
  });

  @override
  List<Object?> get props => [claimId, memNumber, memDate, paySum, account];
}

