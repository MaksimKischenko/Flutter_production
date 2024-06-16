import 'package:json_annotation/json_annotation.dart';

part 'notification_poll_response.g.dart';

@JsonSerializable()
class MdomTpIntNotificationPollResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntNotificationPollResponse psTpInt;

  MdomTpIntNotificationPollResponseWrapper(this.psTpInt);

  factory MdomTpIntNotificationPollResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotificationPollResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotificationPollResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntNotificationPollResponse {

  @JsonKey(name: 'NotificationPollResponse')
  final NotificationPollResponse response;

  MdomTpIntNotificationPollResponse(this.response);

  factory MdomTpIntNotificationPollResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotificationPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotificationPollResponseToJson(this);
  
}

@JsonSerializable()
class NotificationPollResponse {

  // general part

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int keyRequest;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  // general part END

  const NotificationPollResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
  });

  factory NotificationPollResponse.fromJson(Map<String, dynamic> json) => _$NotificationPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPollResponseToJson(this);

}