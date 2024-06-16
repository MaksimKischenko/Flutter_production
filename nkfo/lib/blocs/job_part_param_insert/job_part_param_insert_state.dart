part of 'job_part_param_insert_bloc.dart';

abstract class JobPartParamInsertState extends Equatable {
  const JobPartParamInsertState();
  
  @override
  List<Object?> get props => [];
}


class JobPartParamInsertInit extends JobPartParamInsertState {}

class JobPartParamInsertLoading extends JobPartParamInsertState {}

class JobPartParamInsertError extends JobPartParamInsertState {
  final Object? error;

  const JobPartParamInsertError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobPartParamInsertSuccess extends JobPartParamInsertState {

  final JobPartParam? jobPartParam;

  const JobPartParamInsertSuccess({
    required this.jobPartParam
  });

  @override
  List<Object?> get props => [jobPartParam];
}