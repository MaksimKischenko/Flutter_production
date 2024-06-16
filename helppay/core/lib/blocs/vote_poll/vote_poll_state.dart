part of 'vote_poll_bloc.dart';

abstract class VotePollState extends Equatable {
  const VotePollState();
  
  @override
  List<Object?> get props => [];
}

class VotePollLoading extends VotePollState {}

class VotePollLoaded extends VotePollState {
  /// only for info, for questions get 'questions' field
  final Poll poll;
  // final PollStatus status;
  final bool editMode;
  final List<PollListQuestion> questions;

  const VotePollLoaded({
    required this.poll,
    required this.editMode,
    required this.questions,
  });

  @override
  List<Object> get props => [poll, editMode, questions];
}

class VotePollError extends VotePollState {
  final Object? error;

  const VotePollError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

class VotePollErrorKomplat extends VotePollState {
  final String? errorMessage;
  final int errorCode;

  const VotePollErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class VotePollSuccessVote extends VotePollState {
  final bool edit;
  final Poll poll;

  const VotePollSuccessVote({
    required this.edit,
    required this.poll,
  });

  @override
  List<Object?> get props => [edit, poll];
}
