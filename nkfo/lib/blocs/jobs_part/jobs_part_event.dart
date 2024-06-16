part of 'jobs_part_bloc.dart';

abstract class JobsPartEvent extends Equatable {
  const JobsPartEvent();

  @override
  List<Object?> get props => [];
}

class JobsPartLoad extends JobsPartEvent {
  final int jobId;
  final String jobName;
  final TasksPartSort? sort;
  final bool? sortAscending;
  final int? loadCount;

  const JobsPartLoad({
    required this.jobId,
    required this.jobName,
    this.sort,
    this.sortAscending, 
    this.loadCount = AppConfig.jobsPartGetLoadCount
  });

  @override
  List<Object?> get props => [jobId, jobName, sort, sortAscending, loadCount];
}

class JobsPartLoadMore extends JobsPartEvent {
  final int offset;

  const JobsPartLoadMore(this.offset);

  @override
  List<Object?> get props => [offset];
}

class JobsPartUpdateJob extends JobsPartEvent {
  final JobPart jobPart;

  const JobsPartUpdateJob(this.jobPart);

  @override
  List<Object?> get props => [jobPart];
}

class JobsPartNewJobPart extends JobsPartEvent {
  final JobPart jobPart;

  const JobsPartNewJobPart(this.jobPart);

  @override
  List<Object> get props => [jobPart];
}

class JobsPartDeleteJob extends JobsPartEvent {
  final int jobId;
  final int jobPartId;

  const JobsPartDeleteJob(
    this.jobId,
    this.jobPartId
    );

  @override
  List<Object?> get props => [jobId, jobPartId];
}

class JobsPartCleanInfo extends JobsPartEvent {}

