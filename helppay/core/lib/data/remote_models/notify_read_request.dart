import 'package:helppay_core/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notify_read_request.g.dart';

@JsonSerializable()
class MdomTpIntNotifyReadRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntNotifyReadRequest psTpInt;

  MdomTpIntNotifyReadRequestWrapper(this.psTpInt);

  factory MdomTpIntNotifyReadRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotifyReadRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotifyReadRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntNotifyReadRequest {

  @JsonKey(name: 'NotificationReadRequest')
  final NotificationReadRequest request;

  MdomTpIntNotifyReadRequest(this.request);

  factory MdomTpIntNotifyReadRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotifyReadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotifyReadRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class NotificationReadRequest {

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

  @JsonKey(name: 'Id')
  final int? lastNotificationIndicator;


  NotificationReadRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.lastNotificationIndicator,
  });

  factory NotificationReadRequest.fromJson(Map<String, dynamic> json) => _$NotificationReadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationReadRequestToJson(this);
  
}

