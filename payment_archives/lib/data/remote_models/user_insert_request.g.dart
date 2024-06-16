// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInsertRequest _$UserInsertRequestFromJson(Map<String, dynamic> json) =>
    UserInsertRequest(
      createDate: json['date_add'] == null
          ? null
          : DateTime.parse(json['date_add'] as String),
      name: json['name'] as String?,
      login: json['login'] as String?,
      typeId: json['type_id'] as int?,
      password: json['password'] as String?,
      blocked: json['blocked'] as bool? ?? false,
    );

Map<String, dynamic> _$UserInsertRequestToJson(UserInsertRequest instance) =>
    <String, dynamic>{
      'date_add': instance.createDate?.toIso8601String(),
      'name': instance.name,
      'login': instance.login,
      'type_id': instance.typeId,
      'password': instance.password,
      'blocked': instance.blocked,
    };
