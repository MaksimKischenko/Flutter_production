import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';


part 'job_part_param_update_event.dart';
part 'job_part_param_update_state.dart';

class JobPartParamUpdateBloc extends Bloc<JobPartParamUpdateEvent, JobPartParamUpdateState> {
  DataManager dataManager;

  final int id;
  JobPartParam? jobPartParam;
  bool _patchIsAvaliableJobPartParam = true;

  JobPartParamUpdateBloc({
    required this.id,
    required this.jobPartParam,
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobPartParamUpdateInitLoading());

  @override
  Stream<JobPartParamUpdateState> mapEventToState(
    JobPartParamUpdateEvent event,
  ) async* {
    if (event is JobPartParamUpdateInit) {
      yield* _mapJobPartParamUpdateInitToState(event);
    } else if (event is JobPartParamUpdateRun) {
      yield* _mapJobPartParamUpdateRunToState(event);
    }
  }

  Stream<JobPartParamUpdateState> _mapJobPartParamUpdateInitToState(
    JobPartParamUpdateInit event
  ) async* {
    
    _patchIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.jobPartParam);

    yield JobPartParamUpdateInitLoading();

    try {
      if (jobPartParam == null) {
        final jobsPartParamResponse = await dataManager.getJobPartParamRequest(
          id: id
        );
        if (jobsPartParamResponse.isEmpty) throw Exception('Job not found');

        jobPartParam = jobsPartParamResponse.first;
      }
      
      yield JobPartParamUpdateInitial(
        jobPartParam: jobPartParam,
      );
    
    } on Exception catch  (error, _){
      yield JobPartParamUpdateInitError(
        error: error
      );
    }
  }

  Stream<JobPartParamUpdateState> _mapJobPartParamUpdateRunToState(
    JobPartParamUpdateRun event
  ) async* {
    yield JobPartParamUpdateLoading();

    try {
      final response = _patchIsAvaliableJobPartParam? await dataManager.jobPartParamUpdateRequest(
        id: id,
        request: event.jobPartParam
      ) : null;

      yield _patchIsAvaliableJobPartParam? JobPartParamUpdateSuccess(
        jobPartParam: response
      ) : const JobPartParamUpdateError(
        error: AppConfig.patchIsNotAvaliableJobPartParam
      );
    
    } on Exception catch  (error, _){
      yield JobPartParamUpdateError(
        error: error
      );
    }
  }
}
