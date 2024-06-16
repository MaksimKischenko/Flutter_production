part of 'add_poll_bloc.dart';

abstract class AddPollState extends Equatable {
  const AddPollState();
  
  @override
  List<Object?> get props => [];
}

class AddPollInitial extends AddPollState {}

class AddPollLoading extends AddPollState {}

class AddPollError extends AddPollState {
  final Object error;

  const AddPollError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class AddPollErrorKomplat extends AddPollState {
  final String? errorMessage;
  final int errorCode;

  const AddPollErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class AddPollSuccessAdd extends AddPollState {
  final int id;

  const AddPollSuccessAdd({
    required this.id,
  });

  @override
  List<Object?> get props => [
    id,
  ];
}

class AddPollSuccessEdit extends AddPollState {
  final Poll poll;

  const AddPollSuccessEdit({
    required this.poll,
  });

  @override
  List<Object?> get props => [
    poll,
  ];
}