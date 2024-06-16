// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      id: json['user_id'] as int,
      name: json['user_name'] as String,
      kindId: json['user_kind_id'] as int,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'user_id': instance.id,
      'user_name': instance.name,
      'user_kind_id': instance.kindId,
      'enabled': instance.enabled,
    };
