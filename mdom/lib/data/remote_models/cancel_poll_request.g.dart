// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_poll_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntCancelPollRequestWrapper _$MdomTpIntCancelPollRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntCancelPollRequestWrapper(
      MdomTpIntCancelPollRequest.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntCancelPollRequestWrapperToJson(
        MdomTpIntCancelPollRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntCancelPollRequest _$MdomTpIntCancelPollRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntCancelPollRequest(
      CancelPollRequest.fromJson(
          json['CancelPollRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntCancelPollRequestToJson(
        MdomTpIntCancelPollRequest instance) =>
    <String, dynamic>{
      'CancelPollRequest': instance.request,
    };

CancelPollRequest _$CancelPollRequestFromJson(Map<String, dynamic> json) =>
    CancelPollRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      pollId: json['PollId'] as int,
    );

Map<String, dynamic> _$CancelPollRequestToJson(CancelPollRequest instance) {
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
