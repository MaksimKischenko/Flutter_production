import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'job_insert_event.dart';
part 'job_insert_state.dart';

class JobInsertBloc extends Bloc<JobInsertEvent, JobInsertState> {

 DataManager dataManager;
 bool _postIsAvaliableJob = true;

  JobInsertBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobInsertInitLoading());

  @override
  Stream<JobInsertState> mapEventToState(
    JobInsertEvent event,
  ) async* {
    if(event is JobInsertInit) {
      yield* _mapJobInsertInitToState(event);
    } else if (event is JobInsertRun) {
      yield* _mapJobInsertRunToState(event);
    }
  }

    Stream<JobInsertState> _mapJobInsertInitToState(
    JobInsertInit event
  ) async* {

    _postIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.job);

    yield JobInsertInitLoading();

    try {
      final outServerResponse = await dataManager.getOutServerRequest(
        //select: 'out_server_id,server_name'
      );

      yield JobInsertInitial(
        outServers: outServerResponse
      );
    
    } on Exception catch  (error, _){
      yield JobInsertInitError(
        error: error
      );
    }
  }

  Stream<JobInsertState> _mapJobInsertRunToState(
    JobInsertRun event
  ) async* {
    yield JobInsertLoading();

    try {
      final response = _postIsAvaliableJob? await dataManager.jobInsertRequest(event.job.copyWith()) : null;
      
      yield _postIsAvaliableJob? JobInsertSuccess(
        job: response
      ) : const JobInsertError(
        error: AppConfig.postIsNotAvaliableJob
      );
    
    } on Exception catch  (error, _){
      yield JobInsertError(
        error: error
      );
    }
  }
}
