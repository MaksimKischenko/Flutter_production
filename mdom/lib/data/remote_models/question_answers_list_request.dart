import 'package:bpc/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_answers_list_request.g.dart';

@JsonSerializable()
class MdomTpIntQuestionAnswersListRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntQuestionAnswersListRequest psTpInt;

  MdomTpIntQuestionAnswersListRequestWrapper(this.psTpInt);

  factory MdomTpIntQuestionAnswersListRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntQuestionAnswersListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntQuestionAnswersListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntQuestionAnswersListRequest {

  @JsonKey(name: 'QuestionAnswersListRequest')
  final QuestionAnswersListRequest request;

  MdomTpIntQuestionAnswersListRequest(this.request);

  factory MdomTpIntQuestionAnswersListRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntQuestionAnswersListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntQuestionAnswersListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class QuestionAnswersListRequest {

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

  @JsonKey(name: 'QuestionId')
  final int? questionId;

  QuestionAnswersListRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.pollId,
    this.questionId,
  });

  factory QuestionAnswersListRequest.fromJson(Map<String, dynamic> json) => _$QuestionAnswersListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionAnswersListRequestToJson(this);
  
}
