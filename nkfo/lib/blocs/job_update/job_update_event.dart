part of 'job_update_bloc.dart';

abstract class JobUpdateEvent extends Equatable {
  const JobUpdateEvent();

  @override
  List<Object?> get props => [];
}

class JobUpdateInit extends JobUpdateEvent {}

class JobUpdateRun extends JobUpdateEvent {
  final JobUpdateRequest job;

  const JobUpdateRun(this.job);

  @override
  List<Object?> get props => [job];
}