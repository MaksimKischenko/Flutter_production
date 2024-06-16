part of 'job_part_update_bloc.dart';

abstract class JobPartUpdateState extends Equatable {
  const JobPartUpdateState();
  
  @override
  List<Object?> get props => [];
}

class JobPartUpdateInitial extends JobPartUpdateState {
  final JobPart? jobPart;
  final List<ActionType> types;
  final List<PeriodType> periodTypes;
  final List<MessageType> messageTypes;

  const JobPartUpdateInitial({
    required this.jobPart,
    required this.types,
    required this.periodTypes,
    required this.messageTypes,
  });

  @override
  List<Object?> get props => [jobPart, types, periodTypes, messageTypes];
}

class JobPartUpdateInitLoading extends JobPartUpdateState {}

class JobPartUpdateInitError extends JobPartUpdateState {
  final Object? error;

  const JobPartUpdateInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class JobPartUpdateLoading extends JobPartUpdateState {}

class JobPartUpdateError extends JobPartUpdateState {
  final Object? error;

  const JobPartUpdateError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobPartUpdateSuccess extends JobPartUpdateState {
  final JobPart? jobPart;

  const JobPartUpdateSuccess({
    required this.jobPart
  });

  @override
  List<Object?> get props => [jobPart];
}