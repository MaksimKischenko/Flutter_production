import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/config.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'jobs_part_event.dart';
part 'jobs_part_state.dart';

class JobsPartBloc extends Bloc<JobsPartEvent, JobsPartState> {
  DataManager dataManager;
  
  String? _jobName;
  int? jobId;
  bool _isLoadMoreAvaiable = true;
  TasksPartSort _sort = AppConfig.jobsPartDefaultSort;
  bool _sortAscending = AppConfig.jobsPartDefaultSortAscending;
  List<JobPart> _jobsPart = [];
  List<JobPartParam> jobsPartParam = [];
  bool _isJobPartRunIsAvailable = true;
  bool _getIsAvaliableJobPartParam = true;
  bool _getIsAvaliableJobPart = true;
  bool _postIsAvaliableJobPart = true;
  bool _patchIsAvaliableJobPart = true;
  bool _deleteIsAvaliableJobPart = true;
  

  JobsPartBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobsPartNoInfo());

  @override
  Stream<JobsPartState> mapEventToState( 
    JobsPartEvent event,
  ) async* {
    if (event is JobsPartLoad) {
      yield* _mapJobsPartLoadToState(event);
    } else if (event is JobsPartUpdateJob) {
      yield* _mapJobsPartUpdateJobToState(event);
    } else if (event is JobsPartDeleteJob) {
      yield* _mapJobsPartDeleteJobToState(event);
    } else if(event is JobsPartLoadMore) {
      yield* _mapJobsPartLoadMoreJobToState(event);
    } else if(event is JobsPartNewJobPart) {
      yield* _mapJobsPartNewJobPartToState(event);
    } else if (event is JobsPartCleanInfo) {
      yield* _mapJobsPartCleanInfoToState(event);
    }
  }

    Stream<JobsPartState> _mapJobsPartLoadToState(
    JobsPartLoad event
  ) async* {

    _isJobPartRunIsAvailable =  dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPartRun);
    _getIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.jobPartParam);
    _postIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPart);
    _patchIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.jobPart);
    _deleteIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.deleteM, EntityName.jobPart);
    _getIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.jobPart);

    yield JobsPartLoading();

    try {
      final jobsPartResponse = _getIsAvaliableJobPart? await dataManager.getJobPartRequest(
        count: event.loadCount,
        sort: event.sort ?? AppConfig.jobsPartDefaultSort,
        sortAscending: event.sortAscending ?? AppConfig.jobsPartDefaultSortAscending,
        jobId: event.jobId
      ) : <JobPart>[];

      if (event.sort != null) _sort = event.sort!;
      if (event.sortAscending != null) _sortAscending = event.sortAscending!; 
      _isLoadMoreAvaiable = !(jobsPartResponse.length < AppConfig.jobsPartParamGetLoadCount);

      _jobsPart = jobsPartResponse;
      _jobName = event.jobName;
      jobId = event.jobId;

      yield JobsPartLoaded(
        sort: _sort,
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable,
        jobName: event.jobName,
        jobId: event.jobId,
        jobsPart: _jobsPart,
        isJobPartRunIsAvailable: _isJobPartRunIsAvailable,
        getIsAvaliableJobPartParam: _getIsAvaliableJobPartParam,
        postIsAvaliableJobPart: _postIsAvaliableJobPart,
        patchIsAvaliableJobPart: _patchIsAvaliableJobPart,
        deleteIsAvaliableJobPart: _deleteIsAvaliableJobPart
      );
    
    } on Exception catch  (error, _){
      yield JobsPartError(
        error: error
      );
    }
  }

  Stream<JobsPartState> _mapJobsPartUpdateJobToState(
    JobsPartUpdateJob event
  ) async* {
    yield JobsPartLoading();

    final index = _jobsPart.indexWhere((e) => e.jobPartId==event.jobPart.jobPartId);
    if(index> -1) {
      _jobsPart[index] = event.jobPart;
    }

    yield JobsPartLoaded(
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      jobName: _jobName,
      jobId: event.jobPart.jobId,
      jobsPart: _jobsPart,
      isJobPartRunIsAvailable: _isJobPartRunIsAvailable,
      getIsAvaliableJobPartParam: _getIsAvaliableJobPartParam,
      postIsAvaliableJobPart: _postIsAvaliableJobPart,
      patchIsAvaliableJobPart: _patchIsAvaliableJobPart,
      deleteIsAvaliableJobPart: _deleteIsAvaliableJobPart      
    );
  }

  Stream<JobsPartState> _mapJobsPartDeleteJobToState(
    JobsPartDeleteJob event
  ) async* {
    yield JobsPartLoading();

    try {
      final response = await dataManager.jobPartDeleteRequest(id: event.jobPartId);

      _jobsPart.removeWhere((e) => e.jobPartId == event.jobPartId);

      yield JobsPartDeleteJobPartSuccess(
        response
      );

    
    } on Exception catch  (error, _){
      yield JobsPartError(
        error: error
      );
    }
    yield JobsPartLoaded(
      sort: _sort, 
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable, 
      jobName: _jobName,
      jobId: event.jobId,
      jobsPart: _jobsPart, 
      isJobPartRunIsAvailable: _isJobPartRunIsAvailable,
      getIsAvaliableJobPartParam: _getIsAvaliableJobPartParam,
      postIsAvaliableJobPart: _postIsAvaliableJobPart,
      patchIsAvaliableJobPart: _patchIsAvaliableJobPart,
      deleteIsAvaliableJobPart: _deleteIsAvaliableJobPart      
    );
  }

  Stream<JobsPartState> _mapJobsPartNewJobPartToState(
    JobsPartNewJobPart event
  ) async* {
    yield JobsPartLoading();

    _jobsPart.insert(0, event.jobPart);

    yield JobsPartLoaded(
      sort: _sort, 
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable, 
      jobName: _jobName,
      jobId: event.jobPart.jobId,
      jobsPart: _jobsPart,
      isJobPartRunIsAvailable: _isJobPartRunIsAvailable,
      getIsAvaliableJobPartParam: _getIsAvaliableJobPartParam,
      postIsAvaliableJobPart: _postIsAvaliableJobPart,
      patchIsAvaliableJobPart: _patchIsAvaliableJobPart,
      deleteIsAvaliableJobPart: _deleteIsAvaliableJobPart      
    );
  }

  Stream<JobsPartState> _mapJobsPartLoadMoreJobToState(
    JobsPartLoadMore event
  ) async* {
    yield JobsPartLoading();

    try {
      final response = await dataManager.getJobPartRequest(
        count: AppConfig.jobsPartGetLoadCount,
      );
      
      _jobsPart.addAll(response);
      _isLoadMoreAvaiable = !(response.length < AppConfig.jobsPartGetLoadCount);
      
      yield JobsPartLoaded(
        sort: _sort, 
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable, 
        jobsPart: _jobsPart,
        isJobPartRunIsAvailable: _isJobPartRunIsAvailable,
        getIsAvaliableJobPartParam: _getIsAvaliableJobPartParam,
        postIsAvaliableJobPart: _postIsAvaliableJobPart,
        patchIsAvaliableJobPart: _patchIsAvaliableJobPart,
        deleteIsAvaliableJobPart: _deleteIsAvaliableJobPart        
      );
    
    } on Exception catch  (error, _){
      yield JobsPartError(
        error: error
      );
    }
  }

  Stream<JobsPartState> _mapJobsPartCleanInfoToState(
    JobsPartCleanInfo event
  ) async* {
    yield JobsPartNoInfo();
  }
}
