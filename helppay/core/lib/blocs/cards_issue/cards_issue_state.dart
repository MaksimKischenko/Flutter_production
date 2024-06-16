// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cards_issue_bloc.dart';

abstract class CardsIssueState extends Equatable {
  const CardsIssueState();

  @override
  List<Object?> get props => [];
}

class CardsIssueInitial extends CardsIssueState {}

class CardsIssueLoading extends CardsIssueState {}

class CardsIssueSuccessfulResponse extends CardsIssueState {
  final bool? needMSI;
  final List<CardPayment>? cards;

  const CardsIssueSuccessfulResponse({
     this.needMSI,
     this.cards,
  });

  @override
  List<Object?> get props => [needMSI, cards];
}

class CardsIssue123ConfirmResponse extends CardsIssueState {
  final int? cardId;
  final String? cardPan;

  const CardsIssue123ConfirmResponse({
     this.cardId,
     this.cardPan
  });

  @override
  List<Object?> get props => [cardId, cardPan];
}

class CardsIssueNetworkError extends CardsIssueState {
  final Object error;

  const CardsIssueNetworkError({required this.error});

  @override
  List<Object?> get props => [error];
}

class CardsIssueErrorKomplat extends CardsIssueState {
  final String? errorMessage;
  final int errorCode;

  const CardsIssueErrorKomplat({
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

