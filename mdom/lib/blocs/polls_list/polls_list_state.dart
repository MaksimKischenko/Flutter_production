part of 'polls_list_bloc.dart';

abstract class PollsListState extends Equatable {
  const PollsListState();
  
  @override
  List<Object?> get props => [];
}

class PollsListLoading extends PollsListState {}

class PollsListLoaded extends PollsListState {
  final int confirmedCount;
  final int participantsCount;
  final List<Poll> polls;

  const PollsListLoaded({
    required this.confirmedCount,
    required this.participantsCount,
    required this.polls,
  });

  @override
  List<Object> get props => [
    confirmedCount,
    participantsCount,
    polls,
  ];
}

class PollsListLoadedMore extends PollsListState {
  final List<Poll> polls;

  const PollsListLoadedMore({
    required this.polls,
  });

  @override
  List<Object> get props => [polls];
}

class PollsListError extends PollsListState {
  final ActionType? actionType;
  final Object? error;

  const PollsListError({
    this.actionType,
    required this.error,
  });

  @override
  List<Object?> get props => [actionType, error];
}

class PollsListErrorKomplat extends PollsListState {
  final ActionType? actionType;
  final String? errorMessage;
  final int errorCode;

  const PollsListErrorKomplat({
    this.actionType,
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [actionType, errorMessage, errorCode];
}

class PollListNotifyPollSuccess extends PollsListState {
  final int id;

  const PollListNotifyPollSuccess({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class PollsListCancelPollSuccess extends PollsListState {
  final int id;

  const PollsListCancelPollSuccess({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class PollsListDeletePollSuccess extends PollsListState {
  final int id;

  const PollsListDeletePollSuccess({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class PollsListEditPollSuccess extends PollsListState {
  final Poll poll;

  const PollsListEditPollSuccess({
    required this.poll,
  });

  @override
  List<Object> get props => [poll];
}