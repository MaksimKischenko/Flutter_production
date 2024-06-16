// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'algorithm_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOAlgorithmListRequestWrapper _$PsTpOAlgorithmListRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOAlgorithmListRequestWrapper(
      PsTpOAlgorithmListRequest.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAlgorithmListRequestWrapperToJson(
        PsTpOAlgorithmListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOAlgorithmListRequest _$PsTpOAlgorithmListRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOAlgorithmListRequest(
      AlgorithmListRequest.fromJson(
          json['AlgorithmListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAlgorithmListRequestToJson(
        PsTpOAlgorithmListRequest instance) =>
    <String, dynamic>{
      'AlgorithmListRequest': instance.request,
    };

AlgorithmListRequest _$AlgorithmListRequestFromJson(
        Map<String, dynamic> json) =>
    AlgorithmListRequest(
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      token: json['Token'] as String,
      terminalId: json['TerminalId'] as String,
      serviceCode: json['ServiceCode'] as int,
    );

Map<String, dynamic> _$AlgorithmListRequestToJson(
        AlgorithmListRequest instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.key,
      'Token': instance.token,
      'TerminalId': instance.terminalId,
      'ServiceCode': instance.serviceCode,
    };
