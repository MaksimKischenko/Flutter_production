import 'package:json_annotation/json_annotation.dart';

part 'get_period_type_response.g.dart';

@JsonSerializable()
class PeriodType {

  @JsonKey(name: 'period_type_id')
  final int id;

  @JsonKey(name: 'period_type_name')
  final String name;
  
  PeriodType({
    required this.id,
    required this.name,
  });


  factory PeriodType.fromJson(Map<String, dynamic> json) => _$PeriodTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodTypeToJson(this);
  
}
