part of 'audit_archive_bloc.dart';

abstract class AuditArchiveState extends Equatable {
  const AuditArchiveState();
  
  @override
  List<Object?> get props => [];
}

class AuditArchiveInitLoading extends AuditArchiveState {}

class AuditArchiveInitError extends AuditArchiveState {
  final Object? error;

  const AuditArchiveInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class AuditArchiveLoading extends AuditArchiveState {}

class AuditArchiveLoaded extends AuditArchiveState {

  final List<AuditApplication> applications;

  const AuditArchiveLoaded({
    required this.applications,
  });

  @override
  List<Object?> get props => [applications];
}

class AuditArchiveError extends AuditArchiveState {
  final Object? error;

  const AuditArchiveError({this.error});

  @override
  List<Object?> get props => [error];
}

class AuditArchiveSuccess extends AuditArchiveState {

  final String response;

  const AuditArchiveSuccess({
    required this.response,
  });

}
 
  