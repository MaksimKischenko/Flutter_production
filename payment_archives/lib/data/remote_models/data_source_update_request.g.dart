// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSourceUpdateRequest _$DataSourceUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    DataSourceUpdateRequest(
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      caption: json['caption'] as String?,
      login: json['login'] as String?,
      password: json['password'] as String?,
      dataScale: json['data_scale'] as int?,
      enabled: json['enabled'] as bool?,
      blocked: json['blocked'] as bool?,
    );

Map<String, dynamic> _$DataSourceUpdateRequestToJson(
    DataSourceUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('create_date', instance.createDate?.toIso8601String());
  writeNotNull('caption', instance.caption);
  writeNotNull('login', instance.login);
  writeNotNull('password', instance.password);
  writeNotNull('data_scale', instance.dataScale);
  writeNotNull('enabled', instance.enabled);
  writeNotNull('blocked', instance.blocked);
  return val;
}
