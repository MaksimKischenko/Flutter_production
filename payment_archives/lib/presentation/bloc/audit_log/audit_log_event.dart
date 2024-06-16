// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_log_bloc.dart';

abstract class AuditLogEvent extends Equatable {
  const AuditLogEvent();

  @override
  List<Object?> get props => [];
}


class AuditLogInit extends AuditLogEvent {
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? userName;

  const AuditLogInit({
    this.dateFrom,
    this.dateTo,
    this.userName,
  });

  @override
  List<Object?> get props => [dateFrom, dateTo, userName];
}

class AuditLogSort extends AuditLogEvent {

  final bool ascending;
  final int sortIndex;

  const AuditLogSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];
}


class AuditLogClearData extends AuditLogEvent {}
