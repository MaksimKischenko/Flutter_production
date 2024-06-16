part of 'poll_members_bloc.dart';

abstract class PollMembersEvent extends Equatable {
  const PollMembersEvent();

  @override
  List<Object> get props => [];
}

class PollMembersInit extends PollMembersEvent {}