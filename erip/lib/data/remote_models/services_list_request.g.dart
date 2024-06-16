// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOServicesListRequestWrapper _$PsTpOServicesListRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOServicesListRequestWrapper(
      PsTpOServicesListRequest.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOServicesListRequestWrapperToJson(
        PsTpOServicesListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOServicesListRequest _$PsTpOServicesListRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOServicesListRequest(
      ServicesListRequest.fromJson(
          json['ServicesListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOServicesListRequestToJson(
        PsTpOServicesListRequest instance) =>
    <String, dynamic>{
      'ServicesListRequest': instance.request,
    };

ServicesListRequest _$ServicesListRequestFromJson(Map<String, dynamic> json) =>
    ServicesListRequest(
      version: json['Version'] as int,
      token: json['Token'] as String,
      key: json['KeyRequest'] as int,
    );

Map<String, dynamic> _$ServicesListRequestToJson(
        ServicesListRequest instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'Token': instance.token,
      'KeyRequest': instance.key,
    };
