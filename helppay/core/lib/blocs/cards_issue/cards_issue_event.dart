// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cards_issue_bloc.dart';

abstract class CardsIssueEvent extends Equatable {
  const CardsIssueEvent();

  @override
  List<Object?> get props => [];
}


class CardIssueInitRun extends CardsIssueEvent {
  final String? phoneNumber;
  final bool? retryResponse;

  const CardIssueInitRun({
    this.phoneNumber,
    this.retryResponse
  });

  @override
  List<Object?> get props => [phoneNumber, retryResponse];
}


class CardIssueOTPRun extends CardsIssueEvent {
  final String otpCode;

  const CardIssueOTPRun({
    required this.otpCode,
  });

  @override
  List<Object?> get props => [otpCode];
}

class CardIssueIdentifyUserRun extends CardsIssueEvent {
  final String? personalNumber;
  final int? attemptNumber;

  const CardIssueIdentifyUserRun({
    this.personalNumber,
    this.attemptNumber
  });

  @override
  List<Object?> get props => [personalNumber, attemptNumber];
}

class CardsIssue123ConfirmRun extends CardsIssueEvent {}
