part of 'job_part_insert_bloc.dart';

abstract class JobPartInsertEvent extends Equatable {
  const JobPartInsertEvent();

  @override
  List<Object?> get props => [];
}

class JobPartInsertInit extends JobPartInsertEvent {}

class JobPartInsertRun extends JobPartInsertEvent {
  
  final JobPartInsertRequest jobPart;

  const JobPartInsertRun(this.jobPart);

  @override
  List<Object?> get props => [jobPart];
}