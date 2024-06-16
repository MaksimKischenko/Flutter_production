// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_members_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntPollMembersListRequestWrapper
    _$MdomTpIntPollMembersListRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntPollMembersListRequestWrapper(
          MdomTpIntPollMembersListRequest.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntPollMembersListRequestWrapperToJson(
        MdomTpIntPollMembersListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntPollMembersListRequest _$MdomTpIntPollMembersListRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntPollMembersListRequest(
      PollMembersListRequest.fromJson(
          json['PollMembersListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntPollMembersListRequestToJson(
        MdomTpIntPollMembersListRequest instance) =>
    <String, dynamic>{
      'PollMembersListRequest': instance.request,
    };

PollMembersListRequest _$PollMembersListRequestFromJson(
        Map<String, dynamic> json) =>
    PollMembersListRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      pollId: json['PollId'] as int,
    );

Map<String, dynamic> _$PollMembersListRequestToJson(
    PollMembersListRequest instance) {
  final val = <String, dynamic>{
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'KeyRequest': instance.keyRequest,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['Token'] = instance.token;
  val['PollId'] = instance.pollId;
  return val;
}
