part of 'job_part_param_update_bloc.dart';

abstract class JobPartParamUpdateState extends Equatable {
  const JobPartParamUpdateState();
  
  @override
  List<Object?> get props => [];
}

class JobPartParamUpdateInitial extends JobPartParamUpdateState {
  final JobPartParam? jobPartParam;

  const JobPartParamUpdateInitial({
    required this.jobPartParam,
  });

  @override
  List<Object?> get props => [jobPartParam];
}

class JobPartParamUpdateInitLoading extends JobPartParamUpdateState {}

class JobPartParamUpdateInitError extends JobPartParamUpdateState {
  final Object? error;

  const JobPartParamUpdateInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class JobPartParamUpdateLoading extends JobPartParamUpdateState {}

class JobPartParamUpdateError extends JobPartParamUpdateState {
  final Object? error;

  const JobPartParamUpdateError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobPartParamUpdateSuccess extends JobPartParamUpdateState {
  final JobPartParam? jobPartParam;

  const JobPartParamUpdateSuccess({
    required this.jobPartParam
  });

  @override
  List<Object?> get props => [jobPartParam];
}