// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';

part 'poll_question_info_event.dart';
part 'poll_question_info_state.dart';

class PollQuestionInfoBloc extends Bloc<PollQuestionInfoEvent, PollQuestionInfoState> {
  final DataManager dataManager;
  final int pollId;
  final int questionId;

  PollQuestionInfoBloc({
    required this.dataManager,
    required this.pollId,
    required this.questionId,
  }) : super(PollQuestionInfoLoading()) {
    on<PollQuestionInfoEvent>(_onEvent);
  }

  void _onEvent(
    PollQuestionInfoEvent event,
    Emitter<PollQuestionInfoState> emit,
  ) {
    if (event is PollQuestionInfoInit) return  _onPollQuestionInfoInit(event, emit);
  }

  void _onPollQuestionInfoInit(
    PollQuestionInfoInit event,
    Emitter<PollQuestionInfoState> emit,
  ) async {
    emit(PollQuestionInfoLoading());

    try {
      final response = await dataManager.questionAnswersListRequest(
        pollId: pollId,
        questionId: questionId
      );
      if (response.errorCode == 0) {   
        final positiveAnswers = <QuestionAnswersListQuestionAnswer>[];
        final negativeAnswers = <QuestionAnswersListQuestionAnswer>[];
        final abstainAnswers = <QuestionAnswersListQuestionAnswer>[];

        if (response.questions?.isNotEmpty ?? false) {
          final question = response.questions!.first;
          if (question.answers?.isNotEmpty ?? false) {
            for (final answer in question.answers!) {
              switch (answer.evalue) {
                case PollAnswer.yes:
                  positiveAnswers.add(answer);
                  break;
                case PollAnswer.no:
                  negativeAnswers.add(answer);
                  break;
                case PollAnswer.abstain:
                  abstainAnswers.add(answer);
                  break;
                default:
                  break;
              }
            }
          }
        }

        emit(PollQuestionInfoLoaded(
          positiveAnswers: positiveAnswers,
          negativeAnswers: negativeAnswers,
          abstainAnswers: abstainAnswers,
        ));
      } else {
        emit(PollQuestionInfoErrorKomplat(
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(PollQuestionInfoError(
        error: error
      ));
    }
  }
}
