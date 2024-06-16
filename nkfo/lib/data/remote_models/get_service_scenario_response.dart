import 'package:json_annotation/json_annotation.dart';

part 'get_service_scenario_response.g.dart';

@JsonSerializable()
class ServiceScenario {

  @JsonKey(name: 'scenario_id')
  final int id;

  @JsonKey(name: 'scenario_name')
  final String name;

  ServiceScenario({
    required this.id,
    required this.name,
  });

  factory ServiceScenario.fromJson(Map<String, dynamic> json) => _$ServiceScenarioFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceScenarioToJson(this);
  
}
