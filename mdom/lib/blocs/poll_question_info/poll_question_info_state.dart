part of 'poll_question_info_bloc.dart';

abstract class PollQuestionInfoState extends Equatable {
  const PollQuestionInfoState();
  
  @override
  List<Object?> get props => [];
}

class PollQuestionInfoLoading extends PollQuestionInfoState {}

class PollQuestionInfoLoaded extends PollQuestionInfoState {
  final List<QuestionAnswersListQuestionAnswer> positiveAnswers;
  final List<QuestionAnswersListQuestionAnswer> negativeAnswers;
  final List<QuestionAnswersListQuestionAnswer> abstainAnswers;

  const PollQuestionInfoLoaded({
    required this.positiveAnswers,
    required this.negativeAnswers,
    required this.abstainAnswers
  });

  @override
  List<Object> get props => [
    positiveAnswers,
    negativeAnswers,
    abstainAnswers
  ];
}

class PollQuestionInfoError extends PollQuestionInfoState {
  final Object? error;

  const PollQuestionInfoError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

class PollQuestionInfoErrorKomplat extends PollQuestionInfoState {
  final String? errorMessage;
  final int errorCode;

  const PollQuestionInfoErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}