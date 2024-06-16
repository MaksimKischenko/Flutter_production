// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomResetPasswordResponseWrapper _$MdomResetPasswordResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomResetPasswordResponseWrapper(
      MdomResetPasswordResponse.fromJson(
          json['UserResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomResetPasswordResponseWrapperToJson(
        MdomResetPasswordResponseWrapper instance) =>
    <String, dynamic>{
      'UserResponse': instance.userResponse,
    };

MdomResetPasswordResponse _$MdomResetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    MdomResetPasswordResponse(
      errorCode: MdomResetPasswordErrorCode.fromJson(
          json['ErrorCode'] as Map<String, dynamic>),
      requestType: json['RequestType'] as String? ?? 'ResetPassword',
      token: json['Token'] as String?,
    );

Map<String, dynamic> _$MdomResetPasswordResponseToJson(
        MdomResetPasswordResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
    };

MdomResetPasswordErrorCode _$MdomResetPasswordErrorCodeFromJson(
        Map<String, dynamic> json) =>
    MdomResetPasswordErrorCode(
      evalue: json['evalue'] as int,
      errorText: json['@ErrorText'] as String?,
    );

Map<String, dynamic> _$MdomResetPasswordErrorCodeToJson(
        MdomResetPasswordErrorCode instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@ErrorText': instance.errorText,
    };
