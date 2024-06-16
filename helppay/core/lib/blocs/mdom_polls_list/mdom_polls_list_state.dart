part of 'mdom_polls_list_bloc.dart';

abstract class MdomPollsListState extends Equatable {
  final int participantsCount;
  final List<Poll> polls;
  final int notificationsUnreadCount;
  const MdomPollsListState({
    this.participantsCount = 0,
    this.polls = const [],
    this.notificationsUnreadCount = 0,
  });

  @override
  List<Object?> get props => [];
}

class MdomPollsListLoading extends MdomPollsListState {}

class MdomPollsListLoaded extends MdomPollsListState {
  const MdomPollsListLoaded({
    required super.participantsCount,
    required super.polls,
    required super.notificationsUnreadCount,
  });

  @override
  List<Object> get props => [
        participantsCount,
        polls,
        notificationsUnreadCount,
      ];
}

class MdomPollsListLoadedMore extends MdomPollsListState {
  final List<Poll> polls;

  const MdomPollsListLoadedMore({
    required this.polls,
  });

  @override
  List<Object> get props => [polls];
}

class MdomPollsListError extends MdomPollsListState {
  final ActionType actionType;
  final Object? error;

  const MdomPollsListError({
    required this.actionType,
    required this.error,
  });

  @override
  List<Object?> get props => [actionType, error];
}

class MdomPollsListErrorKomplat extends MdomPollsListState {
  final ActionType actionType;
  final String? errorMessage;
  final int errorCode;

  const MdomPollsListErrorKomplat({
    required this.actionType,
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [actionType, errorMessage, errorCode];
}
