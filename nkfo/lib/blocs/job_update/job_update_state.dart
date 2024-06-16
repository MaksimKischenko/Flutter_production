part of 'job_update_bloc.dart';

abstract class JobUpdateState extends Equatable {
  const JobUpdateState();
  
  @override
  List<Object?> get props => [];
}

class JobUpdateInitial extends JobUpdateState {
  final Job? job;
  final List<OutServer> outServers;

  const JobUpdateInitial({
    required this.job,
    required this.outServers
  });

  @override
  List<Object?> get props => [job, outServers];
}

class JobUpdateInitLoading extends JobUpdateState {}

class JobUpdateInitError extends JobUpdateState {
  final Object? error;

  const JobUpdateInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class JobUpdateLoading extends JobUpdateState {}

class JobUpdateError extends JobUpdateState {
  final Object? error;

  const JobUpdateError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobUpdateSuccess extends JobUpdateState {
  final Job? job;

  const JobUpdateSuccess({
    required this.job
  });

  @override
  List<Object?> get props => [job];
}