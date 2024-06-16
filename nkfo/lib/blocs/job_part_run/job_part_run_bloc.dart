import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';


part 'job_part_run_event.dart';
part 'job_part_run_state.dart';

class JobPartRunBloc extends Bloc<JobPartRunEvent, JobPartRunState> {
  DataManager dataManager;
  
  
  JobPart jobPart;
  List<JobPartRunParam> jobsPartRunParam = [];

  JobPartRunBloc({
    required this.jobPart
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(JobPartRunInitialLoading());

  @override
  Stream<JobPartRunState> mapEventToState( 
    JobPartRunEvent event,
  ) async* {
    if (event is JobPartInitRunJobPart) {
      yield* _mapJobPartInitRunJobPartToState(event);
    } else if (event is JobPartRunJobPart) {
      yield* _mapJobPartRunJobPartToState(event);
    }
  }


  Stream<JobPartRunState> _mapJobPartInitRunJobPartToState(
    JobPartInitRunJobPart event
  ) async* {
    yield JobPartRunInitialLoading();

    try {
      final jobsPartParamResponse = await dataManager.getJobPartRunParamRequest(
        jobPartId: jobPart.jobPartId
      );
      jobsPartRunParam = jobsPartParamResponse;
       
     yield JobPartRunInitial(
       jobId: jobPart.jobId,
       jobPartid: jobPart.jobPartId,
       jobsPartRunParam: jobsPartRunParam
     );

    
    } on Exception catch  (error, _){
      yield JobPartRunInitialError(
        error: error
      );
    }
  }

  Stream<JobPartRunState> _mapJobPartRunJobPartToState(
    JobPartRunJobPart event
  ) async* {
    yield JobPartRunLoading();
    try {
      final response = await dataManager.jobPartRunRequest(
        jobId: jobPart.jobId, 
        jobPartId: jobPart.jobPartId, 
        params: jobsPartRunParam
      );
       
     yield JobPartRunSuccess(
       jobPart.jobPartId,
       response
     );

    
    } on Exception catch  (error, _){
      yield JobPartRunInitialError(
        error: error
      );
    }
  }
}
