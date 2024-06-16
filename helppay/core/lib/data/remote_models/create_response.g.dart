// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomCreateResponseWrapper _$MdomCreateResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomCreateResponseWrapper(
      MdomCreateResponse.fromJson(json['UserResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomCreateResponseWrapperToJson(
        MdomCreateResponseWrapper instance) =>
    <String, dynamic>{
      'UserResponse': instance.userResponse,
    };

MdomCreateResponse _$MdomCreateResponseFromJson(Map<String, dynamic> json) =>
    MdomCreateResponse(
      requestType: json['RequestType'] as String,
      errorCode:
          MdomErrorCode.fromJson(json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] == null
          ? null
          : MdomToken.fromJson(json['Token'] as Map<String, dynamic>),
      params: json['Params'] == null
          ? null
          : MdomResponseParams.fromJson(json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomCreateResponseToJson(MdomCreateResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
      'Params': instance.params,
      'Lookups': instance.lookups,
    };
