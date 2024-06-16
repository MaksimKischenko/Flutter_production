

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';

part 'vote_poll_event.dart';
part 'vote_poll_state.dart';

class VotePollBloc extends Bloc<VotePollEvent, VotePollState> {
  final DataManager dataManager;
  final Poll poll;

  VotePollBloc({
    required this.dataManager,
    required this.poll,
  }) : super(VotePollLoading()) {
    on<VotePollEvent>(_onEvent);
  }

  bool editMode = false;
  late List<PollListQuestion> questions;

  void _onEvent(
    VotePollEvent event,
    Emitter<VotePollState> emit,
  ) {
    if (event is VotePollInit) return _onVotePollInit(event, emit);
    if (event is VotePollAnswer) return _onVotePollAnswer(event, emit);
    if (event is VotePollProceedVote) {
      return _onVotePollProceedVote(event, emit);
    }
    if (event is VotePollEditVote) return _onVotePollEditVote(event, emit);
  }

  void _onVotePollInit(
    VotePollInit event,
    Emitter<VotePollState> emit,
  ) async {
    emit(VotePollLoading());

    questions = List.from(poll.questions ?? <dynamic>[]);

    emit(VotePollLoaded(
      poll: poll,
      editMode: editMode,
      questions: questions,
    ));
  }

  void _onVotePollAnswer(
    VotePollAnswer event,
    Emitter<VotePollState> emit,
  ) async {
    emit(
      VotePollLoading(),
    );

    final questionIndex = questions.indexWhere((e) => e.idx == event.idx);
    questions[questionIndex] = questions[questionIndex].copyWith(currentVote: event.answer);

    //KOMDEV-8913 - No need 
    // var positiveCount = 0;
    // var negativeCount = 0;
    // var abstainedCount = 0;

    // switch (event.answer) {
    //   case PollAnswer.yes:
    //     positiveCount+=1;
    //     negativeCount-=1;
    //     abstainedCount-=1;
    //     break;
    //   case PollAnswer.no:
    //     negativeCount+=1;
    //     positiveCount-=1;
    //     abstainedCount-=1;             
    //     break;
    //   case PollAnswer.abstain:
    //     abstainedCount+=1;
    //     negativeCount-=1;
    //     positiveCount-=1;     
    //     break;                
    //   default:
    // }    
    // questions[questionIndex] = questions[questionIndex].copyWith(
    //   currentVote: event.answer, 
    //   positiveCount: ((questions[questionIndex].positiveCount ?? 0) + positiveCount) < 0 ? 0: ((questions[questionIndex].positiveCount ?? 0) + positiveCount),
    //   negativeCount: ((questions[questionIndex].negativeCount ?? 0) + negativeCount) < 0 ? 0: ((questions[questionIndex].negativeCount ?? 0) + negativeCount),
    //   abstainedCount: ((questions[questionIndex].abstainedCount ?? 0) + abstainedCount) < 0? 0 :((questions[questionIndex].abstainedCount ?? 0) + abstainedCount)
    // );    

    emit(VotePollLoaded(poll: poll, editMode: editMode, questions: questions));
  }


  void _onVotePollProceedVote(
    VotePollProceedVote event,
    Emitter<VotePollState> emit,
  ) async {
    emit(VotePollLoading());

    try {
      final response = await dataManager.votePollRequest(
        pollId: poll.id,
        account: poll.account,
        questions: questions
            .map(
              (e) => VotePollQuestion(idx: e.idx, vote: e.currentVote!),
            )
            .toList(),
      );

      if (response.errorCode == 0) {
        //final votedCount = event.increaseVoteCount? (poll.votedCount ?? 0) + 1 : (poll.votedCount ?? 0);

        emit(VotePollSuccessVote(
          edit: editMode,
          //poll: poll.copyWith(voted: 1, questions: questions, votedCount: votedCount), 
          poll: poll.copyWith(voted: 1, questions: questions, votedCount: poll.votedCount),
        ));
        if (editMode) {
          editMode = false;
        }
      } else {
        emit(VotePollErrorKomplat(
            errorCode: response.errorCode, errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(
        VotePollError(error: error),
      );
    }

    emit(
      VotePollLoaded(poll: poll, editMode: editMode, questions: questions),
    );
  }

  void _onVotePollEditVote(
    VotePollEditVote event,
    Emitter<VotePollState> emit,
  ) async {
    emit(VotePollLoading());

    editMode = true;

    emit(
      VotePollLoaded(
        poll: poll,
        editMode: editMode,
        questions: questions,
      ),
    );
  }
}
