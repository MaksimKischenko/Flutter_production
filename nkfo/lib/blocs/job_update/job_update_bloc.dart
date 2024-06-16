import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';


part 'job_update_event.dart';
part 'job_update_state.dart';

class JobUpdateBloc extends Bloc<JobUpdateEvent, JobUpdateState> {
  DataManager dataManager;

  final int id;
  Job? job;
  bool _patchIsAvaliableJob = true;

  JobUpdateBloc({
    required this.id,
    required this.job,
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobUpdateInitLoading());

  @override
  Stream<JobUpdateState> mapEventToState(
    JobUpdateEvent event,
  ) async* {
    if (event is JobUpdateInit) {
      yield* _mapJobUpdateInitToState(event);
    } else if (event is JobUpdateRun) {
      yield* _mapJobUpdateRunToState(event);
    }
  }

  Stream<JobUpdateState> _mapJobUpdateInitToState(
    JobUpdateInit event
  ) async* {

    _patchIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.job);

    yield JobUpdateInitLoading();

    try {
      if (job == null) {
        final jobsResponse = await dataManager.getJobsRequest(
          id: id
        );
        if (jobsResponse.isEmpty) throw Exception('Job not found');

        job = jobsResponse.first;
      }
      final outServerResponse = await dataManager.getOutServerRequest();
      
      yield JobUpdateInitial(
        job: job,
        outServers: outServerResponse
      );
    
    } on Exception catch  (error, _){
      yield JobUpdateInitError(
        error: error
      );
    }
  }

  Stream<JobUpdateState> _mapJobUpdateRunToState(
    JobUpdateRun event
  ) async* {
    yield JobUpdateLoading();

    try {
      final response = _patchIsAvaliableJob? await dataManager.jobUpdateRequest(
        id: id,
        request: event.job
      ) : null;

      yield _patchIsAvaliableJob? JobUpdateSuccess(
        job: response
      ) : const JobUpdateError(
        error: AppConfig.patchIsNotAvaliableJob
      );
    
    } on Exception catch  (error, _){
      yield JobUpdateError(
        error: error
      );
    }
  }
}
