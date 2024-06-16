// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_scenario_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceScenario _$ServiceScenarioFromJson(Map<String, dynamic> json) =>
    ServiceScenario(
      id: json['scenario_id'] as int,
      name: json['scenario_name'] as String,
    );

Map<String, dynamic> _$ServiceScenarioToJson(ServiceScenario instance) =>
    <String, dynamic>{
      'scenario_id': instance.id,
      'scenario_name': instance.name,
    };
