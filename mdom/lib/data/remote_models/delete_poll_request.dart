import 'package:bpc/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_poll_request.g.dart';

@JsonSerializable()
class MdomTpIntDeletePollRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntDeletePollRequest psTpInt;

  MdomTpIntDeletePollRequestWrapper(this.psTpInt);

  factory MdomTpIntDeletePollRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntDeletePollRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntDeletePollRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntDeletePollRequest {

  @JsonKey(name: 'DeletePollRequest')
  final DeletePollRequest request;

  MdomTpIntDeletePollRequest(this.request);

  factory MdomTpIntDeletePollRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntDeletePollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntDeletePollRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class DeletePollRequest {

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

  DeletePollRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.pollId,
  });

  factory DeletePollRequest.fromJson(Map<String, dynamic> json) => _$DeletePollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePollRequestToJson(this);
  
}
