part of 'job_part_insert_bloc.dart';

abstract class JobPartInsertState extends Equatable {
  const JobPartInsertState();
  
  @override
  List<Object?> get props => [];
}

class JobPartInsertInitial extends JobPartInsertState {
  final int jobId;
  final List<ActionType> types;
  final List<PeriodType> periodTypes;
  final List<MessageType> messageTypes;

  const JobPartInsertInitial({
    required this.jobId,
    required this.types,
    required this.periodTypes,
    required this.messageTypes,
  });

  @override
  List<Object?> get props => [jobId,types, periodTypes, messageTypes];
}

class JobPartInsertInitLoading extends JobPartInsertState {}

class JobPartInsertLoading extends JobPartInsertState {}

class JobPartInsertInitError extends JobPartInsertState {
  final Object? error;

  const JobPartInsertInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class JobPartInsertError extends JobPartInsertState {
  final Object? error;

  const JobPartInsertError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobPartInsertSuccess extends JobPartInsertState {
  final JobPart? jobPart;

  const JobPartInsertSuccess({
    required this.jobPart
  });

  @override
  List<Object?> get props => [jobPart];
}