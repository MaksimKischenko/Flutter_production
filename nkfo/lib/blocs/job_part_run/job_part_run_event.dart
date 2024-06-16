part of 'job_part_run_bloc.dart';

abstract class JobPartRunEvent extends Equatable {
  const JobPartRunEvent();

  @override
  List<Object?> get props => [];
}

class JobPartInitRunJobPart extends JobPartRunEvent {
}

class JobPartRunJobPart extends JobPartRunEvent {

  final int? jobId;
  final int? jobPartId;
  final List<JobPartRunParam>? params;

  const JobPartRunJobPart({
    required this.jobId,
    required this.jobPartId,
    required this.params,
  });

  @override
  List<Object?> get props => [jobId, jobPartId, params];
}
