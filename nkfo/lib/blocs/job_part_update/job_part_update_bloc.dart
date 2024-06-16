import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'job_part_update_event.dart';
part 'job_part_update_state.dart';

class JobPartUpdateBloc extends Bloc<JobPartUpdateEvent, JobPartUpdateState> {
  DataManager dataManager;

  final int id;
  JobPart? jobPart;
  bool _patchIsAvaliableJobPart = true;

  JobPartUpdateBloc({
    required this.id,
    required this.jobPart,
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobPartUpdateInitLoading());

  @override
  Stream<JobPartUpdateState> mapEventToState(
    JobPartUpdateEvent event,
  ) async* {
    if (event is JobPartUpdateInit) {
      yield* _mapJobPartUpdateInitToState(event);
    } else if (event is JobPartUpdateRun) {
      yield* _mapJobPartUpdateRunToState(event);
    }
  }

  Stream<JobPartUpdateState> _mapJobPartUpdateInitToState(
    JobPartUpdateInit event
  ) async* {

    _patchIsAvaliableJobPart =  dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.jobPart);
    yield JobPartUpdateInitLoading();

    try {
      if (jobPart == null) {
        final jobsPartResponse = await dataManager.getJobPartRequest(
          id: id
        );
        if (jobsPartResponse.isEmpty) throw Exception('Job not found');

        jobPart = jobsPartResponse.first;
      }

      final typesResponse = await dataManager.getActionTypeRequest();
      final periodTypesResponse = await dataManager.getPeriodTypeRequest();
      final messageTypesResponse = await dataManager.getMessageTypeRequest();
      
      yield JobPartUpdateInitial(
        jobPart: jobPart,
        types: typesResponse,
        periodTypes: periodTypesResponse,
        messageTypes: messageTypesResponse
      );
    
    } on Exception catch  (error, _){
      yield JobPartUpdateInitError(
        error: error
      );
    }
  }

  Stream<JobPartUpdateState> _mapJobPartUpdateRunToState(
    JobPartUpdateRun event
  ) async* {
    yield JobPartUpdateLoading();

    try {
      final response = _patchIsAvaliableJobPart? await dataManager.jobPartUpdateRequest(
        id: id,
        request: event.jobPart
      ) : null;

      yield _patchIsAvaliableJobPart? JobPartUpdateSuccess(
        jobPart: response
      ) : const JobPartUpdateError(
        error: AppConfig.patchIsNotAvaliableJobPart
      ) ;
    
    } on Exception catch  (error, _){
      yield JobPartUpdateError(
        error: error
      );
    }
  }
}
