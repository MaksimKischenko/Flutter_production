import 'package:json_annotation/json_annotation.dart';

part 'job_run_request.g.dart';

@JsonSerializable()
class JobRunRequest {

  @JsonKey(name: 'p_job_id')
  final int id;
  
  JobRunRequest({
    required this.id,
  });

  factory JobRunRequest.fromJson(Map<String, dynamic> json) => _$JobRunRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JobRunRequestToJson(this);
  
}
