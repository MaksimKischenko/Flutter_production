// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomAccountRegistrationResponseWrapper
    _$MdomAccountRegistrationResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomAccountRegistrationResponseWrapper(
          MdomAccountRegistrationResponse.fromJson(
              json['TPInfoResponse'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomAccountRegistrationResponseWrapperToJson(
        MdomAccountRegistrationResponseWrapper instance) =>
    <String, dynamic>{
      'TPInfoResponse': instance.response,
    };

MdomAccountRegistrationResponse _$MdomAccountRegistrationResponseFromJson(
        Map<String, dynamic> json) =>
    MdomAccountRegistrationResponse(
      requestType: json['RequestType'] as String?,
      errorCode: json['ErrorCode'] == null
          ? null
          : MdomTpInfoErrorCode.fromJson(
              json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] as String,
      account: json['Account'] == null
          ? null
          : PropertyAccountAccount.fromJson(
              json['Account'] as Map<String, dynamic>),
      params: json['Params'] == null
          ? null
          : MdomTpInfoResponseParams.fromJson(
              json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomTpInfoLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomAccountRegistrationResponseToJson(
        MdomAccountRegistrationResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
      'Account': instance.account,
      'Params': instance.params,
      'Lookups': instance.lookups,
    };
