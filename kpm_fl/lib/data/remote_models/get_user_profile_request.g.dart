// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripGetUserProfileRequestWrapper _$PsEripGetUserProfileRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripGetUserProfileRequestWrapper(
      PsEripGetUserProfileRequest.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetUserProfileRequestWrapperToJson(
        PsEripGetUserProfileRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripGetUserProfileRequest _$PsEripGetUserProfileRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripGetUserProfileRequest(
      GetUserProfileRequest.fromJson(
          json['GetUserProfileRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetUserProfileRequestToJson(
        PsEripGetUserProfileRequest instance) =>
    <String, dynamic>{
      'GetUserProfileRequest': instance.request,
    };

GetUserProfileRequest _$GetUserProfileRequestFromJson(
        Map<String, dynamic> json) =>
    GetUserProfileRequest(
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
    );

Map<String, dynamic> _$GetUserProfileRequestToJson(
        GetUserProfileRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalId,
      'Version': instance.version,
    };
