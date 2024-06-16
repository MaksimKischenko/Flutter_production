part of 'job_part_run_bloc.dart';

abstract class JobPartRunState extends Equatable {
  const JobPartRunState();
  
  @override
  List<Object?> get props => [];
}

class JobPartRunInitialLoading extends JobPartRunState {}

class JobPartRunInitialError extends JobPartRunState {
  final Object? error;

  const JobPartRunInitialError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobPartRunInitial extends JobPartRunState {
  final int? jobId;
  final int? jobPartid;
  final List<JobPartRunParam> jobsPartRunParam;

  const JobPartRunInitial({
    required this.jobsPartRunParam,
    this.jobId,
    this.jobPartid,
  });

  @override
  List<Object?> get props => [jobsPartRunParam, jobPartid, jobId];
}

class JobPartRunLoading extends JobPartRunState {}

class JobPartRunError extends JobPartRunState {
  final Object? error;

  const JobPartRunError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobPartRunSuccess extends JobPartRunState {
  final int id;
  final String message;

  const JobPartRunSuccess(
    this.id,
    this.message
  );

  @override
  List<Object?> get props => [id, message];
}
