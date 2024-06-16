import 'package:bpc/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_poll_request.g.dart';

@JsonSerializable()
class MdomTpIntCancelPollRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntCancelPollRequest psTpInt;

  MdomTpIntCancelPollRequestWrapper(this.psTpInt);

  factory MdomTpIntCancelPollRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntCancelPollRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntCancelPollRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntCancelPollRequest {

  @JsonKey(name: 'CancelPollRequest')
  final CancelPollRequest request;

  MdomTpIntCancelPollRequest(this.request);

  factory MdomTpIntCancelPollRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntCancelPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntCancelPollRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class CancelPollRequest {

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

  CancelPollRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.pollId,
  });

  factory CancelPollRequest.fromJson(Map<String, dynamic> json) => _$CancelPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelPollRequestToJson(this);
  
}
