part of 'mdom_polls_list_bloc.dart';

abstract class MdomPollsListEvent extends Equatable {
  const MdomPollsListEvent();

  @override
  List<Object> get props => [];
}

class MdomPollsListInit extends MdomPollsListEvent {
  final int supplierId;
  final PollsListFiltersData filters;

  const MdomPollsListInit({
    required this.filters,
    required this.supplierId,
  });

  @override
  List<Object> get props => [filters];
}

class MdomPollsListGetNotificationCount extends MdomPollsListEvent {
  final int supplierId;
  final int participantsCount;
  final List<Poll> polls;

  const MdomPollsListGetNotificationCount({
    required this.supplierId,
    required this.participantsCount,
    required this.polls,
  });

  @override
  List<Object> get props => [supplierId];
}

class MdomPollsListLoadMore extends MdomPollsListEvent {
  final int supplierId;

  final int lastPollId;
  final int? count;

  const MdomPollsListLoadMore({
    required this.lastPollId,
    this.count,
    required this.supplierId,
  });

  @override
  List<Object> get props => [lastPollId];
}
