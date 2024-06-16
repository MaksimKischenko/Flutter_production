part of 'audit_archive_bloc.dart';

abstract class AuditArchiveEvent extends Equatable {
  const AuditArchiveEvent();

  @override
  List<Object?> get props => [];
}

class AuditArchiveInit extends AuditArchiveEvent{}

class AuditArchiveRun extends AuditArchiveEvent {

  final String application;
  final DateTime? dateFrom;

  const AuditArchiveRun({
    required this.application,
    required this.dateFrom,
  });

  @override
  List<Object?> get props => [application, dateFrom];

}
