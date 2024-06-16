part of 'job_part_update_bloc.dart';

abstract class JobPartUpdateEvent extends Equatable {
  const JobPartUpdateEvent();

  @override
  List<Object?> get props => [];
}

class JobPartUpdateInit extends JobPartUpdateEvent {}

class JobPartUpdateRun extends JobPartUpdateEvent {
  final JobPartUpdateRequest jobPart;

  const JobPartUpdateRun(this.jobPart);

  @override
  List<Object?> get props => [jobPart];
}