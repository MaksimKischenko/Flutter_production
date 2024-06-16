// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomDeleteUserResponseWrapper _$MdomDeleteUserResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomDeleteUserResponseWrapper(
      MdomDeleteUserResponse.fromJson(
          json['UserResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomDeleteUserResponseWrapperToJson(
        MdomDeleteUserResponseWrapper instance) =>
    <String, dynamic>{
      'UserResponse': instance.userResponse,
    };

MdomDeleteUserResponse _$MdomDeleteUserResponseFromJson(
        Map<String, dynamic> json) =>
    MdomDeleteUserResponse(
      requestType: json['RequestType'] as String,
      errorCode:
          MdomErrorCode.fromJson(json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] == null
          ? null
          : MdomToken.fromJson(json['Token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomDeleteUserResponseToJson(
        MdomDeleteUserResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
    };
