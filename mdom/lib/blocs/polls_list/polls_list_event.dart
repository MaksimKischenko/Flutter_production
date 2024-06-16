part of 'polls_list_bloc.dart';

abstract class PollsListEvent extends Equatable {
  const PollsListEvent();

  @override
  List<Object> get props => [];
}

class PollsListInit extends PollsListEvent {
  final PollsListFiltersData filters;

  const PollsListInit({
    required this.filters
  });

  @override
  List<Object> get props => [filters];
}

class PollsListLoadMore extends PollsListEvent {
  final int lastPollId;

  const PollsListLoadMore({
    required this.lastPollId
  });

  @override
  List<Object> get props => [lastPollId];
}

class PollsListNotifyPoll extends PollsListEvent {
  final int id;
  final String message;

  const PollsListNotifyPoll({
    required this.id,
    required this.message,
  });

  @override
  List<Object> get props => [id, message];
}

class PollsListCancelPoll extends PollsListEvent {
  final int id;

  const PollsListCancelPoll({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class PollsListDeletePoll extends PollsListEvent {
  final int id;

  const PollsListDeletePoll({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class PollsListEditPoll extends PollsListEvent {
  final Poll poll;

  const PollsListEditPoll({
    required this.poll,
  });

  @override
  List<Object> get props => [poll];
}