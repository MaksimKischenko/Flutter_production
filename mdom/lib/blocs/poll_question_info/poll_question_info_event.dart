part of 'poll_question_info_bloc.dart';

abstract class PollQuestionInfoEvent extends Equatable {
  const PollQuestionInfoEvent();

  @override
  List<Object> get props => [];
}

class PollQuestionInfoInit extends PollQuestionInfoEvent {}