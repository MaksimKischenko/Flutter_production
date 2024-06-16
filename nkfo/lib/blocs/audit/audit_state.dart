part of 'audit_bloc.dart';

abstract class AuditState extends Equatable {
  const AuditState();
  
  @override
  List<Object?> get props => [];
}

class AuditInitLoading extends AuditState {}

class AuditInitError extends AuditState {
  final Object? error;

  const AuditInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class AuditLoading extends AuditState {}

class AuditLoaded extends AuditState {
  final List<Audit> audit;
  final AuditSort sort;
  final bool sortAscending;
  final bool isLoadMoreAvaiable;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final List<AuditApplication> applications;
  final AuditApplication? selectedApplication;
  final List<AuditAction> actions;
  final AuditAction? selectedAction;
  final List<Supplier> suppliers;
  final int? supplierId;
  final String? description;
  final bool getIsAvaliableSupplier;
  final bool getIsAvaliableAudit;
  final bool getIsAvaliableAuditApplication;
  final bool getIsAvaliableAuditAction;
  final bool archiveIsAvaliableAudit;

  const AuditLoaded({
    required this.audit,
    required this.sort,
    required this.sortAscending,
    required this.isLoadMoreAvaiable,
    required this.dateFrom,
    required this.dateTo,
    required this.applications,
    required this.selectedApplication,
    required this.actions,
    required this.selectedAction,
    required this.suppliers,
    required this.supplierId,
    required this.description,
    this.getIsAvaliableSupplier = true,
    this.getIsAvaliableAudit = true,
    this.getIsAvaliableAuditAction = true,
    this.getIsAvaliableAuditApplication = true,
    this.archiveIsAvaliableAudit = true
  });

  @override
  List<Object?> get props => [audit, sort, sortAscending, isLoadMoreAvaiable, 
  dateFrom, dateTo, applications, selectedApplication, actions, selectedAction, 
  suppliers, supplierId, description, getIsAvaliableSupplier, getIsAvaliableAuditAction, 
  getIsAvaliableAuditApplication, getIsAvaliableAudit, archiveIsAvaliableAudit];
}

class AuditError extends AuditState {
  final Object? error;

  const AuditError({this.error});

  @override
  List<Object?> get props => [error];
}

class AuditExportSuccess extends AuditState {
  final String fileName;
  final int rowCount;

  const AuditExportSuccess({
    required this.fileName,
    required this.rowCount,
  });

  @override
  List<Object?> get props => [fileName, rowCount];
}

class AuditGetNotAllow extends AuditState {
  final String? message;

  const AuditGetNotAllow({this.message});

  @override
  List<Object?> get props => [message];
}
