// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_poll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntNotificationPollResponseWrapper
    _$MdomTpIntNotificationPollResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntNotificationPollResponseWrapper(
          MdomTpIntNotificationPollResponse.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntNotificationPollResponseWrapperToJson(
        MdomTpIntNotificationPollResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntNotificationPollResponse _$MdomTpIntNotificationPollResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotificationPollResponse(
      NotificationPollResponse.fromJson(
          json['NotificationPollResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotificationPollResponseToJson(
        MdomTpIntNotificationPollResponse instance) =>
    <String, dynamic>{
      'NotificationPollResponse': instance.response,
    };

NotificationPollResponse _$NotificationPollResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationPollResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$NotificationPollResponseToJson(
        NotificationPollResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
