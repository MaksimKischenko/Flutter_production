// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_poll_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntDeletePollRequestWrapper _$MdomTpIntDeletePollRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntDeletePollRequestWrapper(
      MdomTpIntDeletePollRequest.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntDeletePollRequestWrapperToJson(
        MdomTpIntDeletePollRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntDeletePollRequest _$MdomTpIntDeletePollRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntDeletePollRequest(
      DeletePollRequest.fromJson(
          json['DeletePollRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntDeletePollRequestToJson(
        MdomTpIntDeletePollRequest instance) =>
    <String, dynamic>{
      'DeletePollRequest': instance.request,
    };

DeletePollRequest _$DeletePollRequestFromJson(Map<String, dynamic> json) =>
    DeletePollRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      pollId: json['PollId'] as int,
    );

Map<String, dynamic> _$DeletePollRequestToJson(DeletePollRequest instance) {
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
