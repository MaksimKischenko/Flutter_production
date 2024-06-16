// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_data_source_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSource _$DataSourceFromJson(Map<String, dynamic> json) => DataSource(
      id: json['id'] as int,
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      caption: json['caption'] as String?,
      userId: json['user_id'] as int?,
      login: json['login'] as String?,
      dataScale: json['data_scale'] as int?,
      enabled: json['enabled'] as bool?,
      blocked: json['blocked'] as bool?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$DataSourceToJson(DataSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_date': instance.createDate?.toIso8601String(),
      'caption': instance.caption,
      'user_id': instance.userId,
      'login': instance.login,
      'data_scale': instance.dataScale,
      'enabled': instance.enabled,
      'blocked': instance.blocked,
      'password': instance.password,
    };
