import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'job_part_param_insert_event.dart';
part 'job_part_param_insert_state.dart';

 class JobPartParamInsertBloc extends Bloc<JobPartParamInsertEvent, JobPartParamInsertState> {

   DataManager dataManager;

   final int jobPartId;
   bool _postIsAvaliableJobPartParam = true;

  JobPartParamInsertBloc({
    required this.jobPartId
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobPartParamInsertInit());

  @override
  Stream<JobPartParamInsertState> mapEventToState(
    JobPartParamInsertEvent event
    ) async* {
     if(event is JobPartParamInsertRun) {
        yield* _mapJobPartParamInsertRunToState(event);
      }
  }


   Stream<JobPartParamInsertState> _mapJobPartParamInsertRunToState(
    JobPartParamInsertRun event
  ) async* {

    _postIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPartParam);
    yield JobPartParamInsertLoading();

    try {
      final response = _postIsAvaliableJobPartParam? await dataManager.jobPartParamInsertRequest(event.jobPartParam.copyWith(
        jobPartId: jobPartId
      )) : null;
      yield _postIsAvaliableJobPartParam? JobPartParamInsertSuccess(
        jobPartParam: response
      ) : const JobPartParamInsertError(
        error: AppConfig.postIsNotAvaliableJobPartParam
      );
    
    } on Exception catch  (error, _){
      yield JobPartParamInsertError(
        error: error
      );
    }
  }
 }

