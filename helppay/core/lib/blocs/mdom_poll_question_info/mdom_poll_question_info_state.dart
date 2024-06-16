part of 'mdom_poll_question_info_bloc.dart';

abstract class MdomPollQuestionInfoState extends Equatable {
  const MdomPollQuestionInfoState();
  
  @override
  List<Object?> get props => [];
}

class MdomPollQuestionInfoLoading extends MdomPollQuestionInfoState {}

class MdomPollQuestionInfoLoaded extends MdomPollQuestionInfoState {
  final List<QuestionAnswersListQuestionAnswer> positiveAnswers;
  final List<QuestionAnswersListQuestionAnswer> negativeAnswers;
  final List<QuestionAnswersListQuestionAnswer> abstainAnswers;

  const MdomPollQuestionInfoLoaded({
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

class MdomPollQuestionInfoError extends MdomPollQuestionInfoState {
  final Object? error;

  const MdomPollQuestionInfoError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

class MdomPollQuestionInfoErrorKomplat extends MdomPollQuestionInfoState {
  final String? errorMessage;
  final int errorCode;

  const MdomPollQuestionInfoErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}