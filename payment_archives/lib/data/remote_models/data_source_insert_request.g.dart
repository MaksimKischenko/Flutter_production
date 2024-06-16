// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSourceInsertRequest _$DataSourceInsertRequestFromJson(
        Map<String, dynamic> json) =>
    DataSourceInsertRequest(
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      caption: json['caption'] as String?,
      userId: json['user_id'] as int?,
      login: json['login'] as String?,
      password: json['password'] as String?,
      dataScale: json['data_scale'] as int?,
      enabled: json['enabled'] as bool? ?? true,
      blocked: json['blocked'] as bool? ?? false,
    );

Map<String, dynamic> _$DataSourceInsertRequestToJson(
        DataSourceInsertRequest instance) =>
    <String, dynamic>{
      'create_date': instance.createDate?.toIso8601String(),
      'caption': instance.caption,
      'user_id': instance.userId,
      'login': instance.login,
      'password': instance.password,
      'data_scale': instance.dataScale,
      'enabled': instance.enabled,
      'blocked': instance.blocked,
    };
