// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_poll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntEditPollResponseWrapper _$MdomTpIntEditPollResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntEditPollResponseWrapper(
      MdomTpIntEditPollResponse.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntEditPollResponseWrapperToJson(
        MdomTpIntEditPollResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntEditPollResponse _$MdomTpIntEditPollResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntEditPollResponse(
      EditPollResponse.fromJson(
          json['EditPollResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntEditPollResponseToJson(
        MdomTpIntEditPollResponse instance) =>
    <String, dynamic>{
      'EditPollResponse': instance.response,
    };

EditPollResponse _$EditPollResponseFromJson(Map<String, dynamic> json) =>
    EditPollResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$EditPollResponseToJson(EditPollResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
