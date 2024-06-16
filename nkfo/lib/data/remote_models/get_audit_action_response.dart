import 'package:json_annotation/json_annotation.dart';

part 'get_audit_action_response.g.dart';

@JsonSerializable()
class AuditAction {

  @JsonKey(name: 'action_id')
  final int id;

  @JsonKey(name: 'action_code')
  final String name;

  AuditAction({
    required this.id,
    required this.name,
  });

  factory AuditAction.fromJson(Map<String, dynamic> json) => _$AuditActionFromJson(json);

  Map<String, dynamic> toJson() => _$AuditActionToJson(this);
  
}
