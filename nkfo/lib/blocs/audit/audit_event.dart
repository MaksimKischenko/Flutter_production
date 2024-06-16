part of 'audit_bloc.dart';

abstract class AuditEvent extends Equatable {
  const AuditEvent();

  @override
  List<Object?> get props => [];
}

class AuditInit extends AuditEvent{}

class AuditLoad extends AuditEvent {
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final AuditApplication? application;
  final AuditAction? action;
  final int? supplierId;
  final String? description;
  final AuditSort? sort;
  final bool? sortAscending;
  final int loadCount;

  const AuditLoad({
    this.dateFrom,
    this.dateTo,
    this.application,
    this.action,
    this.supplierId,
    this.description,
    this.sort,
    this.sortAscending,
    this.loadCount = AppConfig.auditGetLoadCount,
  });

  @override
  List<Object?> get props => [dateFrom, dateTo, application, action, supplierId, description, sort, sortAscending, loadCount];
}

class AuditLoadMore extends AuditEvent {
  final int offset;

  const AuditLoadMore(this.offset);

  @override
  List<Object?> get props => [offset];
  
}

class AuditExportRun extends AuditEvent {}
