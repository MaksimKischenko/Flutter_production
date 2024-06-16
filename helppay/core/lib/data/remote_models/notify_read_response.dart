import 'package:json_annotation/json_annotation.dart';


part 'notify_read_response.g.dart';

@JsonSerializable()
class MdomTpIntNotifyReadResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntNotifyReadResponse psTpInt;

  MdomTpIntNotifyReadResponseWrapper(this.psTpInt);

  factory MdomTpIntNotifyReadResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotifyReadResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotifyReadResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntNotifyReadResponse {

  @JsonKey(name: 'NotificationReadResponse')

  final NotificationReadResponse response;

  MdomTpIntNotifyReadResponse(this.response);

  factory MdomTpIntNotifyReadResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntNotifyReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotifyReadResponseToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class NotificationReadResponse {

  // general part
  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int keyRequest;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  NotificationReadResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
  });

  factory NotificationReadResponse.fromJson(Map<String, dynamic> json) => _$NotificationReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationReadResponseToJson(this);
  
}

