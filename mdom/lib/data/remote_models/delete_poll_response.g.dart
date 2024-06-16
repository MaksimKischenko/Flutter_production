// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_poll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntDeletePollResponseWrapper _$MdomTpIntDeletePollResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntDeletePollResponseWrapper(
      MdomTpIntDeletePollResponse.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntDeletePollResponseWrapperToJson(
        MdomTpIntDeletePollResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntDeletePollResponse _$MdomTpIntDeletePollResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntDeletePollResponse(
      DeletePollResponse.fromJson(
          json['DeletePollResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntDeletePollResponseToJson(
        MdomTpIntDeletePollResponse instance) =>
    <String, dynamic>{
      'DeletePollResponse': instance.response,
    };

DeletePollResponse _$DeletePollResponseFromJson(Map<String, dynamic> json) =>
    DeletePollResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$DeletePollResponseToJson(DeletePollResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
