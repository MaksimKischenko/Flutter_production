import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'job_part_insert_event.dart';
part 'job_part_insert_state.dart';

 class JobPartInsertBloc extends Bloc<JobPartInsertEvent, JobPartInsertState> {

   DataManager dataManager;

   final int jobId;
   bool _postIsAvaliableJobPart = true;

  JobPartInsertBloc({
    required this.jobId
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobPartInsertInitLoading());

  @override
  Stream<JobPartInsertState> mapEventToState(
    JobPartInsertEvent event
    ) async* {
      if(event is JobPartInsertInit) {
        yield* _mapJobPartInsertInitToState(event);
      } else if(event is JobPartInsertRun) {
        yield* _mapJobPartInsertRunToState(event);
      }
  }

   Stream<JobPartInsertState> _mapJobPartInsertInitToState(
    JobPartInsertInit event
  ) async* {

    _postIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPart);
    
    yield JobPartInsertInitLoading();

    try {
      final typesResponse = await dataManager.getActionTypeRequest();
      final periodTypesResponse = await dataManager.getPeriodTypeRequest();
      final messageTypesResponse = await dataManager.getMessageTypeRequest();

      yield JobPartInsertInitial(
        jobId: jobId,
        types: typesResponse,
        periodTypes: periodTypesResponse,
        messageTypes: messageTypesResponse
      );
    
    } on Exception catch  (error, _){
      yield JobPartInsertInitError(
        error: error
      );
    }
  }

   Stream<JobPartInsertState> _mapJobPartInsertRunToState(
    JobPartInsertRun event
  ) async* {
    yield JobPartInsertLoading();

    try {
      final response = _postIsAvaliableJobPart? await dataManager.jobPartInsertRequest(
        request: event.jobPart.copyWith(
          jobId: jobId
      )) : null;

      yield _postIsAvaliableJobPart? JobPartInsertSuccess(
        jobPart: response
      ) : const JobPartInsertError(
        error: AppConfig.postIsNotAvaliableJobPart
      ) ;
    
    } on Exception catch  (error, _){
      yield JobPartInsertError(
        error: error
      );
    }
  }
 }

