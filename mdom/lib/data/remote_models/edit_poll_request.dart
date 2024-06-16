import 'package:bpc/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_poll_request.g.dart';

@JsonSerializable()
class MdomTpIntEditPollRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntEditPollRequest psTpInt;

  MdomTpIntEditPollRequestWrapper(this.psTpInt);

  factory MdomTpIntEditPollRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntEditPollRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEditPollRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntEditPollRequest {

  @JsonKey(name: 'EditPollRequest')
  final EditPollRequest request;

  MdomTpIntEditPollRequest(this.request);

  factory MdomTpIntEditPollRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntEditPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEditPollRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class EditPollRequest {

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

  @JsonKey(name: 'Topic')
  final String? topic;

  @JsonKey(name: 'StartDate')
  final String? startDate;

  @JsonKey(name: 'StopDate')
  final String? stopDate;

  @JsonKey(name: 'URL')
  final String? url;

  @JsonKey(name: 'Anonymous')
  final int? anonymous;

  @JsonKey(name: 'Publish')
  final int? publish;

  @JsonKey(name: 'Question')
  final List<PollQuestionEdit>? questions;

  EditPollRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.pollId,
    required this.topic,
    this.startDate,
    this.stopDate,
    this.url,
    required this.anonymous,
    this.publish,
    this.questions,
  });

  factory EditPollRequest.fromJson(Map<String, dynamic> json) => _$EditPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditPollRequestToJson(this);
  
}
