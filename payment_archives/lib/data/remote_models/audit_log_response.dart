import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audit_log_response.g.dart';

@JsonSerializable()
class AuditLog extends Equatable {

  @JsonKey(name: 'log_id')
  final int? logId;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'op_datetime')
  final DateTime? opDateTime;

  @JsonKey(name: 'entity_id')
  final int? entityId;

  @JsonKey(name: 'action_id')
  final int? actionId;

  @JsonKey(name: 'op_descr')
  final String? opDescr;

  @JsonKey(name: 'computer_ip_address')
  final String? ipAddress;

  @JsonKey(name: 'computer_name')
  final String? computerName;


  @JsonKey(name: 'user_name')
  final String? userName;

  @JsonKey(name: 'full_user_name')
  final String? fullUserName;

  @JsonKey(name: 'process')
  final String? process;

  @JsonKey(name: 'application_type_id')
  final int? applicationTypeId;

  @JsonKey(name: 'program')
  final String? program;

  @JsonKey(name: 'request_id')
  final int? requestId;

  @JsonKey(name: 'action_result')
  final int? actionResult;

  @JsonKey(name: 'object_id')
  final String? objectId;

  const AuditLog({
    this.logId,
    this.userId,
    this.opDateTime,
    this.entityId,
    this.actionId,
    this.opDescr,
    this.userName,
    this.fullUserName,
    this.ipAddress,
    this.computerName,
    this.process,
    this.applicationTypeId,
    this.program,
    this.requestId,
    this.actionResult,
    this.objectId,
  });


  factory AuditLog.empty() => const AuditLog();

  factory AuditLog.fromJson(Map<String, dynamic> json) => _$AuditLogFromJson(json);

  Map<String, dynamic> toJson() => _$AuditLogToJson(this);


  AuditLog copyWith({
    int? logId,
    int? userId,
    DateTime? opDateTime,
    int? entityId,
    int? actionId,
    String? opDescr,
    String? ipAddress,
    String? computerName,
    String? userName,
    String? fullUserName,
    String? process,
    int? applicationTypeId,
    String? program,
    int? requestId,
    int? actionResult,
    String? objectId,
  }) => AuditLog(
      logId: logId ?? this.logId,
      userId: userId ?? this.userId,
      opDateTime: opDateTime ?? this.opDateTime,
      entityId: entityId ?? this.entityId,
      actionId: actionId ?? this.actionId,
      opDescr: opDescr ?? this.opDescr,
      ipAddress: ipAddress ?? this.ipAddress,
      computerName: computerName ?? this.computerName,
      userName: userName ?? this.userName,
      fullUserName: fullUserName ?? this.fullUserName,
      process: process ?? this.process,
      applicationTypeId: applicationTypeId ?? this.applicationTypeId,
      program: program ?? this.program,
      requestId: requestId ?? this.requestId,
      actionResult: actionResult ?? this.actionResult,
      objectId: objectId ?? this.objectId,
    );
    
  @override
  List<Object?> get props => [logId, opDateTime, entityId, actionId, opDescr, userName,
    fullUserName, ipAddress, computerName, process, applicationTypeId, program, requestId,
    actionResult, objectId
  ];
}
