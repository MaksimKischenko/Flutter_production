// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_poll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntCancelPollResponseWrapper _$MdomTpIntCancelPollResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntCancelPollResponseWrapper(
      MdomTpIntCancelPollResponse.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntCancelPollResponseWrapperToJson(
        MdomTpIntCancelPollResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntCancelPollResponse _$MdomTpIntCancelPollResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntCancelPollResponse(
      CancelPollResponse.fromJson(
          json['CancelPollResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntCancelPollResponseToJson(
        MdomTpIntCancelPollResponse instance) =>
    <String, dynamic>{
      'CancelPollResponse': instance.response,
    };

CancelPollResponse _$CancelPollResponseFromJson(Map<String, dynamic> json) =>
    CancelPollResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$CancelPollResponseToJson(CancelPollResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
