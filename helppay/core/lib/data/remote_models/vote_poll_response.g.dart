// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_poll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntVotePollResponseWrapper _$MdomTpIntVotePollResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntVotePollResponseWrapper(
      MdomTpIntVotePollResponse.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntVotePollResponseWrapperToJson(
        MdomTpIntVotePollResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntVotePollResponse _$MdomTpIntVotePollResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntVotePollResponse(
      VotePollResponse.fromJson(
          json['VotePollResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntVotePollResponseToJson(
        MdomTpIntVotePollResponse instance) =>
    <String, dynamic>{
      'VotePollResponse': instance.response,
    };

VotePollResponse _$VotePollResponseFromJson(Map<String, dynamic> json) =>
    VotePollResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$VotePollResponseToJson(VotePollResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
