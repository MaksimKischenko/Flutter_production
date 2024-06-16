// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomLoginResponseWrapper _$MdomLoginResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomLoginResponseWrapper(
      MdomLoginResponse.fromJson(json['UserResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomLoginResponseWrapperToJson(
        MdomLoginResponseWrapper instance) =>
    <String, dynamic>{
      'UserResponse': instance.userResponse,
    };

MdomLoginResponse _$MdomLoginResponseFromJson(Map<String, dynamic> json) =>
    MdomLoginResponse(
      requestType: json['RequestType'] as String,
      errorCode:
          MdomErrorCode.fromJson(json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] == null
          ? null
          : MdomToken.fromJson(json['Token'] as Map<String, dynamic>),
      params: json['Params'] == null
          ? null
          : MdomResponseParams.fromJson(json['Params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomLoginResponseToJson(MdomLoginResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
      'Params': instance.params,
    };
