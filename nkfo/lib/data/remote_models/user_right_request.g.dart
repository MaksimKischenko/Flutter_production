// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_right_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRightRequest _$UserRightRequestFromJson(Map<String, dynamic> json) =>
    UserRightRequest(
      entityName: json['p_entity_name'] as String? ?? '',
      entityType: json['p_entity_type'] as String? ?? '',
      dev: json['dev'] as bool? ?? false,
    );

Map<String, dynamic> _$UserRightRequestToJson(UserRightRequest instance) =>
    <String, dynamic>{
      'p_entity_name': instance.entityName,
      'p_entity_type': instance.entityType,
      'dev': instance.dev,
    };
