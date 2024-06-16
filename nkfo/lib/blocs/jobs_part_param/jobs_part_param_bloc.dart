
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'jobs_part_param_event.dart';
part 'jobs_part_param_state.dart';

class JobsPartParamBloc extends Bloc<JobsPartParamEvent, JobsPartParamState> {
  DataManager dataManager;

  List<JobPartParam> jobsPartParam = [];
  List<JobPartParam> _updatedPeriodJobsPartParam = [];
  String? jobName;
  String? jobPartName;
  int? jobPartId;
  final bool _isLoadMoreAvaiable = true;
  TasksPartParamSort _sort = AppConfig.jobsPartParamDefaultSort;
  bool _sortAscending = AppConfig.jobsPartParamDefaultSortAscending;
  bool _getIsAvaliableJobPartParam = true;
  bool _postIsAvaliableJobPartParam = true;
  bool _patchIsAvaliableJobPartParam = true;
  bool _deleteIsAvaliableJobPartParam = true;
  

  JobsPartParamBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobsPartParamNoInfo());

  @override
  Stream<JobsPartParamState> mapEventToState( 
    JobsPartParamEvent event,
  ) async* {
    if (event is JobsPartParamLoad) {
      yield* _mapJobsPartParamLoadToState(event);
    } else if (event is JobsPartParamNewJobPartParam) {
      yield* _mapJobsPartParamNewJobPartParamToState(event);
    } else if (event is JobsPartParamUpdateJobPartParam) {
      yield* _mapJobsPartParamUpdateToState(event);
    } else if (event is JobsPartParamDeleteJobPartParam) {
      yield* _mapJobsPartParamDeleteToState(event);
    } else if (event is JobsPartParamCleanInfo) {
      yield* _mapJobsPartParamCleanInfoToState(event);
    }
  }

  Stream<JobsPartParamState> _mapJobsPartParamLoadToState(
    JobsPartParamLoad event
  ) async* {

     _getIsAvaliableJobPartParam =  dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.jobPartParam);
     _postIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPartParam);
     _patchIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.jobPartParam);
     _deleteIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.deleteM, EntityName.jobPartParam);

    yield JobsPartParamLoading();

    try {
      final jobsPartParamResponse = _getIsAvaliableJobPartParam? await dataManager.getJobPartParamRequest(
        count: event.loadCount,
        sort: event.sort ?? AppConfig.jobsPartParamDefaultSort,
        sortAscending: event.sortAscending ?? AppConfig.jobsPartParamDefaultSortAscending,
        jobPartId: event.jobPartId
      ) : <JobPartParam>[];

      jobsPartParam = jobsPartParamResponse;

      if (event.sort != null) _sort = event.sort!;
      if (event.sortAscending != null) _sortAscending = event.sortAscending!;

      yield JobsPartParamLoaded(
        sort: _sort,
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable,
        jobName: event.jobName,
        jobPartName: event.jobPartName,
        jobPartid: event.jobPartId,
        jobsPartParam: jobsPartParam,
        postIsAvaliableJobPartParam: _postIsAvaliableJobPartParam,
        patchIsAvaliableJobPartParam: _patchIsAvaliableJobPartParam,
        deleteIsAvaliableJobPartParam: _deleteIsAvaliableJobPartParam
      );

      jobPartId = event.jobPartId;
      jobName = event.jobName;
      jobPartName = event.jobPartName;

    
    } on Exception catch  (error, _){
      yield JobsPartParamError(
        error: error
      );
    }
  }
  Stream<JobsPartParamState> _mapJobsPartParamNewJobPartParamToState(
    JobsPartParamNewJobPartParam event
  ) async* {
    yield JobsPartParamLoading();

    jobsPartParam.insert(0, event.jobPartParam);

    try {
      final response = await dataManager.getJobPartParamRequest(
        jobPartId: jobPartId
      );

    _updatedPeriodJobsPartParam = response;
  
    
    } on Exception catch  (error, _){
      yield JobsPartParamError(
        error: error
      );
    }

    yield JobsPartParamLoaded(
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      jobsPartParam: _updatedPeriodJobsPartParam,
      jobName: jobName,
      jobPartName: jobPartName,
      jobPartid: jobPartId,
      postIsAvaliableJobPartParam: _postIsAvaliableJobPartParam,
      patchIsAvaliableJobPartParam: _patchIsAvaliableJobPartParam,
      deleteIsAvaliableJobPartParam: _deleteIsAvaliableJobPartParam      
    );
  }

  Stream<JobsPartParamState> _mapJobsPartParamUpdateToState(
    JobsPartParamUpdateJobPartParam event
  ) async* {
    yield JobsPartParamLoading();

    final index = jobsPartParam.indexWhere((e) => e.jobPartParamId == event.jobPartParam.jobPartParamId);
    if (index> -1) {
      jobsPartParam[index] = event.jobPartParam;
    }

    try {
      final response = await dataManager.getJobPartParamRequest(
        jobPartId: jobPartId
      );

    _updatedPeriodJobsPartParam = response;
  
    
    } on Exception catch  (error, _){
      yield JobsPartParamError(
        error: error
      );
    }

    yield JobsPartParamLoaded(
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      jobsPartParam: _updatedPeriodJobsPartParam,
      jobPartid: jobPartId,
      jobName: jobName,
      jobPartName: jobPartName,
      postIsAvaliableJobPartParam: _postIsAvaliableJobPartParam,
      patchIsAvaliableJobPartParam: _patchIsAvaliableJobPartParam,
      deleteIsAvaliableJobPartParam: _deleteIsAvaliableJobPartParam      
    );
  }

  Stream<JobsPartParamState> _mapJobsPartParamDeleteToState(
    JobsPartParamDeleteJobPartParam event
  ) async* {
    yield JobsPartParamLoading();

    try {
      final response = await dataManager.jobPartParamDeleteRequest(
        id: event.jobPartParamId);
        
      jobsPartParam.removeWhere((e) => e.jobPartParamId == event.jobPartParamId);

      yield JobsPartParamDeleteJobPartParamSuccess(response);
    
    } on Exception catch  (error, _){
      yield JobsPartParamError(
        error: error
      );
    }
    yield JobsPartParamLoaded(
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      jobPartid: jobPartId,
      jobName: jobName,
      jobPartName: jobPartName,
      jobsPartParam: jobsPartParam,
      postIsAvaliableJobPartParam: _postIsAvaliableJobPartParam,
      patchIsAvaliableJobPartParam: _patchIsAvaliableJobPartParam,
      deleteIsAvaliableJobPartParam: _deleteIsAvaliableJobPartParam      
    );
  }

  Stream<JobsPartParamState> _mapJobsPartParamCleanInfoToState(
    JobsPartParamCleanInfo event
  ) async* {
    yield JobsPartParamNoInfo();
  }
}
