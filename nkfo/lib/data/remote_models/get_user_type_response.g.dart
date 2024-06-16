// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserType _$UserTypeFromJson(Map<String, dynamic> json) => UserType(
      id: json['type_id'] as int,
      name: json['type_name'] as String,
      description: json['type_description'] as String,
    );

Map<String, dynamic> _$UserTypeToJson(UserType instance) => <String, dynamic>{
      'type_id': instance.id,
      'type_name': instance.name,
      'type_description': instance.description,
    };
