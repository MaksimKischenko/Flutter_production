// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_poll_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntNotificationPollRequestWrapper
    _$MdomTpIntNotificationPollRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntNotificationPollRequestWrapper(
          MdomTpIntNotificationPollRequest.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntNotificationPollRequestWrapperToJson(
        MdomTpIntNotificationPollRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntNotificationPollRequest _$MdomTpIntNotificationPollRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotificationPollRequest(
      NotificationPollRequest.fromJson(
          json['NotificationPollRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotificationPollRequestToJson(
        MdomTpIntNotificationPollRequest instance) =>
    <String, dynamic>{
      'NotificationPollRequest': instance.request,
    };

NotificationPollRequest _$NotificationPollRequestFromJson(
        Map<String, dynamic> json) =>
    NotificationPollRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      pollId: json['PollId'] as int,
      message: json['Message'] as String,
    );

Map<String, dynamic> _$NotificationPollRequestToJson(
    NotificationPollRequest instance) {
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
  val['Message'] = instance.message;
  return val;
}
