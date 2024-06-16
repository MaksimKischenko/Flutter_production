part of 'job_part_param_insert_bloc.dart';

abstract class JobPartParamInsertEvent extends Equatable {
  const JobPartParamInsertEvent();

  @override
  List<Object?> get props => [];
}


class JobPartParamInsertRun extends JobPartParamInsertEvent {
  
  final JobPartParamInsertRequest jobPartParam;

  const JobPartParamInsertRun(this.jobPartParam);

  @override
  List<Object?> get props => [jobPartParam];
}