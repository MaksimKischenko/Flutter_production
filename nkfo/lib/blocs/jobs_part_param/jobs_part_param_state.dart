part of 'jobs_part_param_bloc.dart';

abstract class JobsPartParamState extends Equatable {
  const JobsPartParamState();
  
  @override
  List<Object?> get props => [];
}


class JobsPartParamNoInfo extends JobsPartParamState {
   final DataManager dataManager;
   JobsPartParamNoInfo() : dataManager = InjectionComponent.getDependency<DataManager>();
   bool get jobIsAvialable => dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.job);
   String get message => jobIsAvialable? 'Параметры запроса еще не загружены' : AppConfig.getIsNotAvaliableJobPartParam;
}


class JobsPartParamLoading extends JobsPartParamState {}

class JobsPartParamLoaded extends JobsPartParamState {
  final String? jobName;
  final String? jobPartName;
  final int? jobPartid;
  final List<JobPartParam> jobsPartParam;
  final bool isLoadMoreAvaiable;
  final TasksPartParamSort sort;
  final bool sortAscending;
  final bool postIsAvaliableJobPartParam;
  final bool patchIsAvaliableJobPartParam; 
  final bool deleteIsAvaliableJobPartParam; 

  const JobsPartParamLoaded({
    required this.jobsPartParam,
    required this.sort,
    required this.sortAscending,
    required this.isLoadMoreAvaiable,
    this.jobPartid,
    this.jobName,
    this.jobPartName,
    this.postIsAvaliableJobPartParam = true,
    this.patchIsAvaliableJobPartParam = true,
    this.deleteIsAvaliableJobPartParam = true
  });

  @override
  List<Object?> get props => [jobName, jobPartName, jobPartid, jobsPartParam,isLoadMoreAvaiable, sort, sortAscending,
    postIsAvaliableJobPartParam, patchIsAvaliableJobPartParam, deleteIsAvaliableJobPartParam
  ];
}

class JobsPartParamError extends JobsPartParamState {
  final Object? error;

  const JobsPartParamError({this.error});

  @override
  List<Object?> get props => [error];
}

class JobsPartParamDeleteJobPartParamSuccess extends JobsPartParamState {
  final JobPartParam jobPartParam;

  const JobsPartParamDeleteJobPartParamSuccess(this.jobPartParam);

  @override
  List<Object?> get props => [jobPartParam];
}

