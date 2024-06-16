part of 'jobs_bloc.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object?> get props => [];
}


class JobsInit extends JobsEvent {
  final String? name;
  final int loadCount;

  const JobsInit({
    this.name,
    this.loadCount = AppConfig.jobsGetLoadCount,
  });
  
  @override
  List<Object?> get props => [name, loadCount];
}


class JobsLoad extends JobsEvent {
  final UnassignedTasksSort? sort;
  final bool? sortAscending;
  final int? loadCount;

  const JobsLoad({
    this.sort,
    this.sortAscending,
    this.loadCount = AppConfig.jobsGetLoadCount,
  });

  @override
  List<Object?> get props => [sort, sortAscending, loadCount];

}

class JobsLoadMore extends JobsEvent {
  final int offset;

  const JobsLoadMore(this.offset);

  @override
  List<Object> get props => [offset];

}

class JobsNewJob extends JobsEvent {
  final Job job;

  const JobsNewJob(this.job);

  @override
  List<Object> get props => [job];
}

class JobsUpdateJob extends JobsEvent {
  final Job? job;
  final UnassignedTasksSort? sort;
  final bool? sortAscending;
  final int? loadCount;

  const JobsUpdateJob({
    this.job,
    this.sort,
    this.sortAscending,
    this.loadCount = AppConfig.jobsGetLoadCount,
  });

  @override
  List<Object?> get props => [job, sort, sortAscending, loadCount];

}

class JobsDeleteJob extends JobsEvent {
  final int jobId;

  const JobsDeleteJob(this.jobId);

  @override
  List<Object> get props => [jobId];
}

class JobsRunJob extends JobsEvent {
  final int jobId;

  const JobsRunJob(this.jobId);

  @override
  List<Object> get props => [jobId];
}
