// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRole _$UserRoleFromJson(Map<String, dynamic> json) => UserRole(
      id: json['role_id'] as int?,
      name: json['role_name'] as String?,
    );

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic>{
      'role_id': instance.id,
      'role_name': instance.name,
    };
