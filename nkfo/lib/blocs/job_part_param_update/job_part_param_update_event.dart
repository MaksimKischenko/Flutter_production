part of 'job_part_param_update_bloc.dart';

abstract class JobPartParamUpdateEvent extends Equatable {
  const JobPartParamUpdateEvent();

  @override
  List<Object?> get props => [];
}

class JobPartParamUpdateInit extends JobPartParamUpdateEvent {}

class JobPartParamUpdateRun extends JobPartParamUpdateEvent {
  final JobPartParamUpdateRequest jobPartParam;

  const JobPartParamUpdateRun(this.jobPartParam);

  @override
  List<Object?> get props => [jobPartParam];
}