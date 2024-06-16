// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_connect_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsMtCheckConnectResponseWrapper _$PsMtCheckConnectResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsMtCheckConnectResponseWrapper(
      PsMtCheckConnectResponse.fromJson(json['PS_MT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsMtCheckConnectResponseWrapperToJson(
        PsMtCheckConnectResponseWrapper instance) =>
    <String, dynamic>{
      'PS_MT': instance.psMt,
    };

PsMtCheckConnectResponse _$PsMtCheckConnectResponseFromJson(
        Map<String, dynamic> json) =>
    PsMtCheckConnectResponse(
      CheckConnectResponse.fromJson(
          json['CheckConnectResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsMtCheckConnectResponseToJson(
        PsMtCheckConnectResponse instance) =>
    <String, dynamic>{
      'CheckConnectResponse': instance.response,
    };

CheckConnectResponse _$CheckConnectResponseFromJson(
        Map<String, dynamic> json) =>
    CheckConnectResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      nextRequest: json['NextRequest'] as String?,
      date: json['DateTimeServer'] as String?,
    );

Map<String, dynamic> _$CheckConnectResponseToJson(
        CheckConnectResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'NextRequest': instance.nextRequest,
      'DateTimeServer': instance.date,
    };
