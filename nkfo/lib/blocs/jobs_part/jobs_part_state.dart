part of 'jobs_part_bloc.dart';

abstract class JobsPartState extends Equatable {
  const JobsPartState();
  
  @override
  List<Object?> get props => [];
}

class JobsPartLoading extends JobsPartState {}

class JobsPartNoInfo extends JobsPartState {
   final DataManager dataManager;
   JobsPartNoInfo() : dataManager = InjectionComponent.getDependency<DataManager>();
   bool get jobIsAvialable => dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.job);
   String get message => jobIsAvialable? 'Части задания еще не загружены' : AppConfig.getIsNotAvaliableJobPart;
}

class JobsPartLoaded extends JobsPartState {
  final String? jobName;
  final int? jobId;
  final Color? colors; 
  final List<JobPart> jobsPart;
  final bool isLoadMoreAvaiable;
  final TasksPartSort sort;
  final bool sortAscending;
  final bool isJobPartRunIsAvailable;
  final bool getIsAvaliableJobPartParam;
  final bool postIsAvaliableJobPart;
  final bool patchIsAvaliableJobPart;
  final bool deleteIsAvaliableJobPart;


  const JobsPartLoaded({
    required this.jobsPart,
    required this.sort,
    required this.sortAscending,
    required this.isLoadMoreAvaiable,
    this.jobName,
    this.jobId,
    this.colors,
    this.isJobPartRunIsAvailable = true,
    this.getIsAvaliableJobPartParam = true,
    this.postIsAvaliableJobPart = true,
    this.patchIsAvaliableJobPart = true,
    this.deleteIsAvaliableJobPart = true    
  });

  @override
  List<Object?> get props => [jobName, jobId, jobsPart, isLoadMoreAvaiable, sort, sortAscending,
    isJobPartRunIsAvailable, getIsAvaliableJobPartParam, postIsAvaliableJobPart, patchIsAvaliableJobPart,
    deleteIsAvaliableJobPart
  ];
}

class JobsPartError extends JobsPartState {
  final Object? error;

  const JobsPartError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobsPartDeleteJobPartSuccess extends JobsPartState {
  final JobPart jobPart;

  const JobsPartDeleteJobPartSuccess(this.jobPart);

  @override
  List<Object?> get props => [jobPart];
}

