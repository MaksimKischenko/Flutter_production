import 'package:json_annotation/json_annotation.dart';

part 'get_audit_response.g.dart';

@JsonSerializable()
class Audit {

  @JsonKey(name: 'op_audit_id')
  final int id;

  @JsonKey(name: 'client_id')
  final int? clientId;

  @JsonKey(name: 'client_name')
  final String? clientName;

  @JsonKey(name: 'client_login')
  final String? clientLogin;

  @JsonKey(name: 'op_action_date')
  final DateTime? date;

  @JsonKey(name: 'op_descr')
  final String? description;

  @JsonKey(name: 'computer_ip_address')
  final String? ip;

  @JsonKey(name: 'action_arm')
  final String? application;

  @JsonKey(name: 'op_action_code')
  final String? actionName;

  @JsonKey(name: 'action_id')
  final int? actionId;

  @JsonKey(name: 'op_action_note')
  final String? actionNote;

  @JsonKey(name: 'action_arm_note')
  final int? actionArmNote;

  @JsonKey(name: 'action_result')
  final String? actionResult;

  @JsonKey(name: 'supplier_id')
  final int? supplierId;

  @JsonKey(name: 'supplier_name')
  final String? supplierName;
 
  Audit({
    required this.id,
    this.clientId,
    this.clientName,
    this.clientLogin,
    this.date,
    this.description,
    this.ip,
    this.application,
    this.actionName,
    this.actionId,
    this.actionNote,
    this.actionArmNote,
    this.actionResult,
    this.supplierId,
    this.supplierName,
  });
    

  factory Audit.fromJson(Map<String, dynamic> json) => _$AuditFromJson(json);

  Map<String, dynamic> toJson() => _$AuditToJson(this);

}
