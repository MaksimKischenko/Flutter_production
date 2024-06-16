import 'package:json_annotation/json_annotation.dart';

part 'audit_archive_request.g.dart';

@JsonSerializable()
class AuditArchiveRequest {

  @JsonKey(name: 'p_arm')
  final String actions;

  @JsonKey(name: 'p_day')
  final DateTime? dateFrom;

  AuditArchiveRequest({
    required this.actions,
    required this.dateFrom,
  });
  

  factory AuditArchiveRequest.fromJson(Map<String, dynamic> json) => _$AuditArchiveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuditArchiveRequestToJson(this);
  
}
