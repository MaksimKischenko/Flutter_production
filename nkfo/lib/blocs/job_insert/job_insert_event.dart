part of 'job_insert_bloc.dart';

abstract class JobInsertEvent extends Equatable {
  const JobInsertEvent();

  @override
  List<Object?> get props => [];
}

class JobInsertInit extends JobInsertEvent {}


class JobInsertRun extends JobInsertEvent {
  final JobInsertRequest job;

  const JobInsertRun(this.job);

  @override
  List<Object?> get props => [job];
}
