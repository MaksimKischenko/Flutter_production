// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_poll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntAddPollResponseWrapper _$MdomTpIntAddPollResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntAddPollResponseWrapper(
      MdomTpIntAddPollResponse.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntAddPollResponseWrapperToJson(
        MdomTpIntAddPollResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntAddPollResponse _$MdomTpIntAddPollResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntAddPollResponse(
      AddPollResponse.fromJson(json['AddPollResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntAddPollResponseToJson(
        MdomTpIntAddPollResponse instance) =>
    <String, dynamic>{
      'AddPollResponse': instance.response,
    };

AddPollResponse _$AddPollResponseFromJson(Map<String, dynamic> json) =>
    AddPollResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      id: json['PollId'] as int?,
    );

Map<String, dynamic> _$AddPollResponseToJson(AddPollResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'PollId': instance.id,
    };
