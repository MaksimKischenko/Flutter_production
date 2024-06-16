// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOInformationRequestWrapper _$PsTpOInformationRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOInformationRequestWrapper(
      PsTpOInformationRequest.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOInformationRequestWrapperToJson(
        PsTpOInformationRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOInformationRequest _$PsTpOInformationRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOInformationRequest(
      InformationRequest.fromJson(
          json['InformationRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOInformationRequestToJson(
        PsTpOInformationRequest instance) =>
    <String, dynamic>{
      'InformationRequest': instance.request,
    };

InformationRequest _$InformationRequestFromJson(Map<String, dynamic> json) =>
    InformationRequest(
      token: json['Token'] as String,
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
    );

Map<String, dynamic> _$InformationRequestToJson(InformationRequest instance) =>
    <String, dynamic>{
      'Token': instance.token,
      'Version': instance.version,
      'KeyRequest': instance.key,
    };
