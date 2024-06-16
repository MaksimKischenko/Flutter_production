// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_action_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionType _$ActionTypeFromJson(Map<String, dynamic> json) => ActionType(
      id: json['action_type_id'] as int,
      name: json['name'] as String,
      typeNum: json['type'] as int,
      enabledNum: json['enabled'] as int,
    );

Map<String, dynamic> _$ActionTypeToJson(ActionType instance) =>
    <String, dynamic>{
      'action_type_id': instance.id,
      'name': instance.name,
      'type': instance.typeNum,
      'enabled': instance.enabledNum,
    };
