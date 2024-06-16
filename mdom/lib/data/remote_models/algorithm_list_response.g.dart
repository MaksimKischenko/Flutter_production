// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'algorithm_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOAlgorithmListResponseWrapper _$PsTpOAlgorithmListResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOAlgorithmListResponseWrapper(
      PsTpOAlgorithmListResponse.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAlgorithmListResponseWrapperToJson(
        PsTpOAlgorithmListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOAlgorithmListResponse _$PsTpOAlgorithmListResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOAlgorithmListResponse(
      AlgorithmListResponse.fromJson(
          json['AlgorithmListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAlgorithmListResponseToJson(
        PsTpOAlgorithmListResponse instance) =>
    <String, dynamic>{
      'AlgorithmListResponse': instance.response,
    };

AlgorithmListResponse _$AlgorithmListResponseFromJson(
        Map<String, dynamic> json) =>
    AlgorithmListResponse(
      algorithms: (json['Algorithm'] as List<dynamic>?)
          ?.map((e) => ServiceAlgorithm.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$AlgorithmListResponseToJson(
        AlgorithmListResponse instance) =>
    <String, dynamic>{
      'Algorithm': instance.algorithms,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

ServiceAlgorithm _$ServiceAlgorithmFromJson(Map<String, dynamic> json) =>
    ServiceAlgorithm(
      id: json['@Id'] as int,
      name: json['@Name'] as String,
    );

Map<String, dynamic> _$ServiceAlgorithmToJson(ServiceAlgorithm instance) =>
    <String, dynamic>{
      '@Id': instance.id,
      '@Name': instance.name,
    };
