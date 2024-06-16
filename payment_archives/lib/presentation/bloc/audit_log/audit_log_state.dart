// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_log_bloc.dart';

abstract class AuditLogState extends Equatable {
  const AuditLogState();
  
  @override
  List<Object?> get props => [];
}


class AuditLogLoading extends AuditLogState {}


class AuditLogLoaded extends AuditLogState {
  final List<AuditLog> audits;

  const AuditLogLoaded({
    required this.audits,
  });

  @override
  List<Object?> get props => [audits];
}

class AuditLogNetworkError extends AuditLogState {

  final Object? error;

  const AuditLogNetworkError({this.error});

  @override
  List<Object?> get props => [error];
}
