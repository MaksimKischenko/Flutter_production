import 'package:bpc/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_poll_request.g.dart';

@JsonSerializable()
class MdomTpIntNotificationPollRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntNotificationPollRequest psTpInt;

  MdomTpIntNotificationPollRequestWrapper(this.psTpInt);

  factory MdomTpIntNotificationPollRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotificationPollRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotificationPollRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntNotificationPollRequest {

  @JsonKey(name: 'NotificationPollRequest')
  final NotificationPollRequest request;

  MdomTpIntNotificationPollRequest(this.request);

  factory MdomTpIntNotificationPollRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotificationPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotificationPollRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class NotificationPollRequest {

  // general part

  @JsonKey(name: 'TerminalId')
  final MdomTpIntTerminalId terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'KeyRequest')
  final int keyRequest;

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'Token')
  final String token;

  // general part END

  @JsonKey(name: 'PollId')
  final int pollId;

  @JsonKey(name: 'Message')
  final String message;

  NotificationPollRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.pollId,
    required this.message,
  });

  factory NotificationPollRequest.fromJson(Map<String, dynamic> json) => _$NotificationPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPollRequestToJson(this);
  
}
