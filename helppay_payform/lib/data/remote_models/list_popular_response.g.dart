// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_popular_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPopularResponse _$ListPopularResponseFromJson(Map<String, dynamic> json) =>
    ListPopularResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      token: json['Token'] as String?,
      payRecord: (json['PayRecord'] as List<dynamic>?)
          ?.map((e) =>
              ListPopularResponsePayRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListPopularResponseToJson(
        ListPopularResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'Token': instance.token,
      'PayRecord': instance.payRecord,
    };

ListPopularResponsePayRecord _$ListPopularResponsePayRecordFromJson(
        Map<String, dynamic> json) =>
    ListPopularResponsePayRecord(
      code: json['@Code'] as int?,
      diType: json['@DIType'] as int?,
      name: json['@Name'] as String?,
      recordType: json['@RecordType'] as int?,
      picture: json['Picture'] == null
          ? null
          : ServicePicture.fromJson(json['Picture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListPopularResponsePayRecordToJson(
        ListPopularResponsePayRecord instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@DIType': instance.diType,
      '@Name': instance.name,
      '@RecordType': instance.recordType,
      'Picture': instance.picture,
    };

ServicePicture _$ServicePictureFromJson(Map<String, dynamic> json) =>
    ServicePicture(
      url: json['@URL'] as String?,
    );

Map<String, dynamic> _$ServicePictureToJson(ServicePicture instance) =>
    <String, dynamic>{
      '@URL': instance.url,
    };
