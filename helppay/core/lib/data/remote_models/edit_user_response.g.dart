// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomEditUserResponseWrapper _$MdomEditUserResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserResponseWrapper(
      MdomEditUserResponse.fromJson(
          json['UserResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomEditUserResponseWrapperToJson(
        MdomEditUserResponseWrapper instance) =>
    <String, dynamic>{
      'UserResponse': instance.userResponse,
    };

MdomEditUserResponse _$MdomEditUserResponseFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserResponse(
      requestType: json['RequestType'] as String,
      errorCode:
          MdomErrorCode.fromJson(json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] == null
          ? null
          : MdomToken.fromJson(json['Token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomEditUserResponseToJson(
        MdomEditUserResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
    };
