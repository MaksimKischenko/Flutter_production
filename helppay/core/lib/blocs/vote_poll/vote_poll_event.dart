part of 'vote_poll_bloc.dart';

abstract class VotePollEvent extends Equatable {
  const VotePollEvent();

  @override
  List<Object> get props => [];
}

class VotePollInit extends VotePollEvent {}

class VotePollAnswer extends VotePollEvent {
  final int idx;
  final PollAnswer answer;

  const VotePollAnswer({
    required this.idx,
    required this.answer,
  });

  @override
  List<Object> get props => [
    idx,
    answer
  ];
}

class VotePollProceedVote extends VotePollEvent {
  final bool increaseVoteCount;

  const VotePollProceedVote({
    required this.increaseVoteCount,
  });

  @override
  List<Object> get props => [increaseVoteCount];  
}

class VotePollEditVote extends VotePollEvent {}