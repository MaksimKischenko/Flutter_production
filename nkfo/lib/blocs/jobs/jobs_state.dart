part of 'jobs_bloc.dart';

abstract class JobsState extends Equatable {
  const JobsState();
  
  @override
  List<Object?> get props => [];
}

class JobsLoading extends JobsState {}

class JobsLoaded extends JobsState {
  final List<Job> jobs;
  final bool isLoadMoreAvaiable;
  final UnassignedTasksSort sort;
  final bool sortAscending;
  final bool isJobRunIsAvailable;
  final bool postIsAvaliableJob;
  final bool patchIsAvaliableJob;
  final bool deleteIsAvaliableJob;  
  final bool getIsAvaliableJobPart;
  
  const JobsLoaded({
    required this.jobs,
    required this.isLoadMoreAvaiable,
    required this.sort,
    required this.sortAscending,
    this.isJobRunIsAvailable = true,
    this.postIsAvaliableJob = true,
    this.patchIsAvaliableJob = true,
    this.deleteIsAvaliableJob = true,
    this.getIsAvaliableJobPart = true
  });

  @override
  List<Object?> get props => [jobs, isLoadMoreAvaiable, sort, sortAscending, isJobRunIsAvailable,
    postIsAvaliableJob, patchIsAvaliableJob, deleteIsAvaliableJob, getIsAvaliableJobPart
  ];
}

class JobsError extends JobsState {
  final Object? error;

  const JobsError({this.error});

  @override
  List<Object?> get props => [error];
}


class JobsDeleteJobSuccess extends JobsState {
  final Job job;

  const JobsDeleteJobSuccess(this.job);

  @override
  List<Object?> get props => [job];

}

class JobsRunSuccess extends JobsState {
  final int id;
  final String message;

  const JobsRunSuccess(
    this.id,
    this.message
  );

  @override
  List<Object?> get props => [id, message];
}

class JobsStatusUpdated extends JobsState {}

class JobGetNotAllow extends JobsState {
  final String? message;

  const JobGetNotAllow({this.message});

  @override
  List<Object?> get props => [message];
}