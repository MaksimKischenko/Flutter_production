part of 'job_insert_bloc.dart';

abstract class JobInsertState extends Equatable {
  const JobInsertState();
  
  @override
  List<Object?> get props => [];
}

class JobInsertInitial extends JobInsertState {
  final List<OutServer> outServers;
  
  const JobInsertInitial({
    required this.outServers,
  });

  @override
  List<Object?> get props => [outServers];
  
}

class JobInsertLoading extends JobInsertState {}

class JobInsertInitLoading extends JobInsertState {}

class JobInsertError extends JobInsertState {
  final Object? error;

  const JobInsertError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobInsertInitError extends JobInsertState {
  final Object? error;

  const JobInsertInitError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobInsertSuccess extends JobInsertState {
  final Job? job;

  const JobInsertSuccess({
    required this.job
  });

  @override
  List<Object?> get props => [job];
}