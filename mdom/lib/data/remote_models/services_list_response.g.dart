// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOServicesListResponseWrapper _$PsTpOServicesListResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOServicesListResponseWrapper(
      PsTpOServicesListResponse.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOServicesListResponseWrapperToJson(
        PsTpOServicesListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOServicesListResponse _$PsTpOServicesListResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOServicesListResponse(
      ServicesListResponse.fromJson(
          json['ServicesListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOServicesListResponseToJson(
        PsTpOServicesListResponse instance) =>
    <String, dynamic>{
      'ServicesListResponse': instance.response,
    };

ServicesListResponse _$ServicesListResponseFromJson(
        Map<String, dynamic> json) =>
    ServicesListResponse(
      services: (json['Service'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$ServicesListResponseToJson(
        ServicesListResponse instance) =>
    <String, dynamic>{
      'Service': instance.services,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      code: json['ServiceCode'] as int,
      codeRasvikom: json['ServiceCodeRasvikom'] as int,
      name: json['ServiceName'] as String,
      itemUnit: json['ItemUnit'] as String?,
      needDevice: json['NeedDevice'] as int?,
      needGenerateAccNum: json['NeedGenerateAccNum'] as int?,
      claimSumMax: (json['ClaimSumMax'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'ServiceCode': instance.code,
      'ServiceCodeRasvikom': instance.codeRasvikom,
      'ServiceName': instance.name,
      'ItemUnit': instance.itemUnit,
      'NeedDevice': instance.needDevice,
      'NeedGenerateAccNum': instance.needGenerateAccNum,
      'ClaimSumMax': instance.claimSumMax,
    };
