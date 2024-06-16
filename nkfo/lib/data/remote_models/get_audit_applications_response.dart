import 'package:json_annotation/json_annotation.dart';

part 'get_audit_applications_response.g.dart';

@JsonSerializable()
class AuditApplication {
  
  @JsonKey(name: 'type_id')
  final int? typeId;

  @JsonKey(name: 'application_name')
  final String? name;

  AuditApplication({
    required this.name,
    this.typeId,
  });

  factory AuditApplication.fromJson(Map<String, dynamic> json) => _$AuditApplicationFromJson(json);

  Map<String, dynamic> toJson() => _$AuditApplicationToJson(this);
  
}
