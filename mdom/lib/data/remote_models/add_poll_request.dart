import 'package:bpc/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_poll_request.g.dart';

@JsonSerializable()
class MdomTpIntAddPollRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntAddPollRequest psTpInt;

  MdomTpIntAddPollRequestWrapper(this.psTpInt);

  factory MdomTpIntAddPollRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntAddPollRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntAddPollRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntAddPollRequest {

  @JsonKey(name: 'AddPollRequest')
  final AddPollRequest request;

  MdomTpIntAddPollRequest(this.request);

  factory MdomTpIntAddPollRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntAddPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntAddPollRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class AddPollRequest {

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

  @JsonKey(name: 'Topic')
  final String topic;

  @JsonKey(name: 'StartDate')
  final String startDate;

  @JsonKey(name: 'StopDate')
  final String stopDate;

  @JsonKey(name: 'URL')
  final String? url;

  @JsonKey(name: 'Anonymous')
  final int anonymous;

  @JsonKey(name: 'Publish')
  final int? publish;

  @JsonKey(name: 'Question')
  final List<PollQuestionEdit>? questions;

  AddPollRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.topic,
    required this.startDate,
    required this.stopDate,
    this.url,
    required this.anonymous,
    this.publish,
    this.questions,
  });

  factory AddPollRequest.fromJson(Map<String, dynamic> json) => _$AddPollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddPollRequestToJson(this);
  
}

@JsonSerializable()
class PollQuestionEdit {

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Idx')
  final int idx;

  @JsonKey(name: '@Description')
  final String? description;

  const PollQuestionEdit({
    required this.evalue,
    required this.idx,
    this.description,
  });

  factory PollQuestionEdit.fromJson(Map<String, dynamic> json) => _$PollQuestionEditFromJson(json);

  Map<String, dynamic> toJson() => _$PollQuestionEditToJson(this);
  
}