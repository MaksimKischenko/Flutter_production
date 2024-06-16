import 'package:json_annotation/json_annotation.dart';


part 'job_part_run_param.g.dart';

@JsonSerializable()
class JobPartRunParam {
  
  
  @JsonKey(name: 'param_name')
  final String? name;

  @JsonKey(name: 'param_value')
  String? paramValue;

  @JsonKey(name: 'param_type_id')
  final int? paramType;
  
  @JsonKey(name: 'access_type')
  final int? accessType;
  

   JobPartRunParam({
    this.name,
    this.paramValue,
    this.paramType,
    this.accessType
  });


  factory JobPartRunParam.fromJson(Map<String, dynamic> json) => _$JobPartRunParamFromJson(json);

  Map<String, dynamic> toJson() => _$JobPartRunParamToJson(this);

}
