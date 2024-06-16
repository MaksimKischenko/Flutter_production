import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {

  DataManager dataManager;

  JobsBloc() : dataManager = InjectionComponent.getDependency<DataManager>(), 
  super(JobsLoading());

  List<Job> _jobs = [];
  String? _name;
  bool _isLoadMoreAvaiable = true;
  UnassignedTasksSort _sort = AppConfig.jobsDefaultSort;
  bool _sortAscending = AppConfig.jobsDefaultSortAscending;

  bool _isJobRunIsAvailable = true;
  bool _getIsAvaliableJob = true;
  bool _postIsAvaliableJob = true;
  bool _patchIsAvaliableJob = true;
  bool _deleteIsAvaliableJob = true;
  bool _getIsAvaliableJobPart = true;

  @override
  Stream<JobsState> mapEventToState(
    JobsEvent event
  ) async* {
    if (event is JobsInit) {
      yield* _mapJobsInitToState(event);
    } else if (event is JobsLoad) {
      yield* _mapJobsLoadToState(event);
    } else if (event is JobsLoadMore) {
      yield* _mapJobsLoadMoreToState(event);
    } else if (event is JobsUpdateJob) {
      yield* _mapJobsUpdateJobToState(event);
    } else if (event is JobsDeleteJob) {
      yield* _mapJobsDeleteJobToState(event);
    } else if (event is JobsRunJob) {
      yield* _mapJobsRunJobToState(event);
    } else if(event is JobsNewJob) {
      yield* _mapJobsNewJobToState(event);
    } 
  }

  Stream<JobsState> _mapJobsInitToState(
    JobsInit event
  ) async* {

    _isJobRunIsAvailable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobRun);
    _getIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.job);
    _postIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.job);
    _patchIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.job);
    _deleteIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.deleteM, EntityName.job);
    _getIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.jobPart);

    yield JobsLoading();

    try {
      
      final response = _getIsAvaliableJob? await dataManager.getJobsRequest(
        count: event.loadCount,
        name: event.name,
        sort: _sort,
        sortAscending: _sortAscending,
      ) : <Job>[];

      _name = event.name;
      _jobs = response;
      _isLoadMoreAvaiable = !(response.length < AppConfig.jobsGetLoadCount);
      
      yield _getIsAvaliableJob? JobsLoaded(
        sort: _sort,
        sortAscending: _sortAscending,
        jobs: _jobs,
        isLoadMoreAvaiable: _isLoadMoreAvaiable,
        isJobRunIsAvailable: _isJobRunIsAvailable,
        postIsAvaliableJob: _postIsAvaliableJob,
        patchIsAvaliableJob: _patchIsAvaliableJob,
        deleteIsAvaliableJob: _deleteIsAvaliableJob,
        getIsAvaliableJobPart: _getIsAvaliableJobPart
      ) : const JobGetNotAllow(
        message: AppConfig.getIsNotAvaliableJob
      );
    
    } on Exception catch  (error, _){
      yield JobsError(
        error: error
      );
    }
  }

  Stream<JobsState> _mapJobsLoadToState(
    JobsLoad event
  ) async* {
    yield JobsLoading();

    try {
      final response = await dataManager.getJobsRequest(
        count: event.loadCount,
        sort: event.sort ?? AppConfig.jobsDefaultSort,
        sortAscending: event.sortAscending ?? AppConfig.jobsDefaultSortAscending,
        name: _name,
      );

      
      if (event.sort != null) _sort = event.sort!;
      if (event.sortAscending != null) _sortAscending = event.sortAscending!;

      _jobs = response;
      _isLoadMoreAvaiable = !(response.length < AppConfig.jobsGetLoadCount);
    
    } on Exception catch  (error, _){
      yield JobsError(
        error: error
      );
    }

    yield JobsLoaded(
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      jobs: _jobs,
      isJobRunIsAvailable: _isJobRunIsAvailable,
      postIsAvaliableJob: _postIsAvaliableJob,
      patchIsAvaliableJob: _patchIsAvaliableJob,
      deleteIsAvaliableJob: _deleteIsAvaliableJob,
      getIsAvaliableJobPart: _getIsAvaliableJobPart    
    );
  }

  Stream<JobsState> _mapJobsLoadMoreToState(
    JobsLoadMore event
  ) async* {
    yield JobsLoading();

    try {
      final response = await dataManager.getJobsRequest(
        count: AppConfig.jobsGetLoadCount,
        offset: event.offset,
        name: _name,
      );

      _jobs.addAll(response);
      _isLoadMoreAvaiable = !(response.length < AppConfig.jobsGetLoadCount);
      
      yield JobsLoaded(
        sort: _sort,
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable,
        jobs: _jobs,
        isJobRunIsAvailable: _isJobRunIsAvailable,
        postIsAvaliableJob: _postIsAvaliableJob,
        patchIsAvaliableJob: _patchIsAvaliableJob,
        deleteIsAvaliableJob: _deleteIsAvaliableJob,
        getIsAvaliableJobPart: _getIsAvaliableJobPart      
      );
    
    } on Exception catch  (error, _){
      yield JobsError(
        error: error
      );
    }
  }
  
 
  Stream<JobsState> _mapJobsUpdateJobToState(
    JobsUpdateJob event
  ) async* {
    yield JobsLoading();

    final index = _jobs.indexWhere((e) => e.id==event.job?.id);
    if(index> -1) {
      _jobs[index] = event.job!;
    }

    yield JobsLoaded(
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      jobs: _jobs,
      isJobRunIsAvailable: _isJobRunIsAvailable,
      postIsAvaliableJob: _postIsAvaliableJob,
      patchIsAvaliableJob: _patchIsAvaliableJob,
      deleteIsAvaliableJob: _deleteIsAvaliableJob,
      getIsAvaliableJobPart: _getIsAvaliableJobPart    
    );
  }

  Stream<JobsState> _mapJobsDeleteJobToState(
    JobsDeleteJob event
  ) async* {
    yield JobsLoading();

    try {
      final response = await dataManager.jobDeleteRequest(id: event.jobId);

      _jobs.removeWhere((e) => e.id == event.jobId);

      yield JobsDeleteJobSuccess(
       response
      );

    
    } on Exception catch  (error, _){
      yield JobsError(
        error: error
      );
    }
     
    yield JobsLoaded(
      sort: _sort, 
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable, 
      jobs: _jobs,
      isJobRunIsAvailable: _isJobRunIsAvailable,
      postIsAvaliableJob: _postIsAvaliableJob,
      patchIsAvaliableJob: _patchIsAvaliableJob,
      deleteIsAvaliableJob: _deleteIsAvaliableJob,
      getIsAvaliableJobPart: _getIsAvaliableJobPart  
    );
  }

  Stream<JobsState> _mapJobsRunJobToState(
    JobsRunJob event
  ) async* {
    yield JobsLoading();

    try {

      final response = _isJobRunIsAvailable? await dataManager.jobRunRequest(id: event.jobId) : null;

      yield _isJobRunIsAvailable? JobsRunSuccess(
        event.jobId,
        response ?? ''
      ) : const JobsError(
        error: AppConfig.runIsNotAvaliableJob
      ) ;
    
    } on Exception catch  (error, _){
      yield JobsError(
        error: error
      );
    }
    yield JobsLoaded(
      sort: _sort, 
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable, 
      jobs: _jobs,
      isJobRunIsAvailable: _isJobRunIsAvailable,
      postIsAvaliableJob: _postIsAvaliableJob,
      patchIsAvaliableJob: _patchIsAvaliableJob,
      deleteIsAvaliableJob: _deleteIsAvaliableJob,
      getIsAvaliableJobPart: _getIsAvaliableJobPart      
    );
  }

  Stream<JobsState> _mapJobsNewJobToState(
    JobsNewJob event
  ) async* {
    yield JobsLoading();

    _jobs.insert(0, event.job);    //add(event.job);

    yield JobsLoaded(
      sort: _sort, 
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable, 
      jobs: _jobs, 
      isJobRunIsAvailable: _isJobRunIsAvailable,
      postIsAvaliableJob: _postIsAvaliableJob,
      patchIsAvaliableJob: _patchIsAvaliableJob,
      deleteIsAvaliableJob: _deleteIsAvaliableJob,
      getIsAvaliableJobPart: _getIsAvaliableJobPart  
    );
  }
}
