part of 'poll_members_bloc.dart';

abstract class PollMembersState extends Equatable {
  const PollMembersState();
  
  @override
  List<Object?> get props => [];
}

class PollMembersLoading extends PollMembersState {}

class PollMembersError extends PollMembersState {
  final Object error;

  const PollMembersError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class PollMembersErrorKomplat extends PollMembersState {
  final String? errorMessage;
  final int errorCode;

  const PollMembersErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class PollMembersLoaded extends PollMembersState {
  final List<Member> members;

  const PollMembersLoaded({
    required this.members
  });

  @override
  List<Object?> get props => [
    members,
  ];
}