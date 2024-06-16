part of 'jobs_part_param_bloc.dart';

abstract class JobsPartParamEvent extends Equatable {
  const JobsPartParamEvent();

  @override
  List<Object?> get props => [];
}

class JobsPartParamLoad extends JobsPartParamEvent {

final int jobPartId;
final String jobName;
final String jobPartName;
final TasksPartParamSort? sort;
final bool? sortAscending;
final int? loadCount;

const JobsPartParamLoad({
  required this.jobPartId,
  required this.jobName,
  required this.jobPartName,
  this.sort,
  this.sortAscending, 
  this.loadCount = AppConfig.jobsPartParamGetLoadCount
});

@override
  List<Object?> get props => [jobPartId, jobName, jobPartName, sort, sortAscending, loadCount];
}

class JobsPartParamNewJobPartParam extends JobsPartParamEvent {
  final JobPartParam jobPartParam;

  const JobsPartParamNewJobPartParam(this.jobPartParam);

  @override
  List<Object> get props => [jobPartParam];
}


class JobsPartParamUpdateJobPartParam extends JobsPartParamEvent {
  final JobPartParam jobPartParam;

  const JobsPartParamUpdateJobPartParam(this.jobPartParam);

  @override
  List<Object> get props => [jobPartParam];
}

class JobsPartParamDeleteJobPartParam extends JobsPartParamEvent {
  final int jobPartParamId;


  const JobsPartParamDeleteJobPartParam(this.jobPartParamId);

  @override
  List<Object?> get props => [jobPartParamId];
}

class JobsPartParamCleanInfo extends JobsPartParamEvent {}
