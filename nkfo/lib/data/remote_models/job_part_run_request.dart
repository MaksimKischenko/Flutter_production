
import 'package:json_annotation/json_annotation.dart';
import 'package:web_cabinet_nkfo/data/data.dart';



part 'job_part_run_request.g.dart';

@JsonSerializable()
class JobPartRunRequest  {
  
  @JsonKey(name: 'p_job_id')
  final int jobId;

  @JsonKey(name: 'p_job_part_id')
  final int jobPartId;

  @JsonKey(name: 'params')
  final List<JobPartRunParam> params;

  JobPartRunRequest({
    required this.jobId,
    required this.jobPartId,
    required this.params,
  });

  factory JobPartRunRequest.fromJson(Map<String, dynamic> json) => _$JobPartRunRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JobPartRunRequestToJson(this);

 


  
}
