// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';

part 'mdom_poll_question_info_event.dart';
part 'mdom_poll_question_info_state.dart';

class MdomPollQuestionInfoBloc extends Bloc<MdomPollQuestionInfoEvent, MdomPollQuestionInfoState> {
  final DataManager dataManager;
  final int pollId;
  final int questionId;

  MdomPollQuestionInfoBloc({
    required this.dataManager,
    required this.pollId,
    required this.questionId,
  }) : super(MdomPollQuestionInfoLoading()) {
    on<MdomPollQuestionInfoEvent>(_onEvent);
  }

  void _onEvent(
    MdomPollQuestionInfoEvent event,
    Emitter<MdomPollQuestionInfoState> emit,
  ) {
    if (event is MdomPollQuestionInfoInit) return  _onMdomPollQuestionInfoInit(event, emit);
  }

  void _onMdomPollQuestionInfoInit(
    MdomPollQuestionInfoInit event,
    Emitter<MdomPollQuestionInfoState> emit,
  ) async {
    emit(MdomPollQuestionInfoLoading());

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

        emit(MdomPollQuestionInfoLoaded(
          positiveAnswers: positiveAnswers,
          negativeAnswers: negativeAnswers,
          abstainAnswers: abstainAnswers,
        ));
      } else {
        emit(MdomPollQuestionInfoErrorKomplat(
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomPollQuestionInfoError(
        error: error
      ));
    }
  }
}
