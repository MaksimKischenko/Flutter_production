import 'package:bpc/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_answers_list_response.g.dart';

@JsonSerializable()
class MdomTpIntQuestionAnswersListResponseWrapper {
  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntQuestionAnswersListResponse psTpInt;

  MdomTpIntQuestionAnswersListResponseWrapper(this.psTpInt);

  factory MdomTpIntQuestionAnswersListResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$MdomTpIntQuestionAnswersListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomTpIntQuestionAnswersListResponseWrapperToJson(this);
}

@JsonSerializable()
class MdomTpIntQuestionAnswersListResponse {
  @JsonKey(name: 'QuestionAnswersListResponse')
  final QuestionAnswersListResponse response;

  MdomTpIntQuestionAnswersListResponse(this.response);

  factory MdomTpIntQuestionAnswersListResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MdomTpIntQuestionAnswersListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomTpIntQuestionAnswersListResponseToJson(this);
}

@JsonSerializable()
class QuestionAnswersListResponse {
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

  @JsonKey(name: 'Question')
  final List<QuestionAnswersListQuestion>? questions;

  const QuestionAnswersListResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
    required this.questions,
  });

  factory QuestionAnswersListResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswersListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionAnswersListResponseToJson(this);
}

@JsonSerializable()
class QuestionAnswersListQuestion {
  @JsonKey(name: '@Idx')
  final int idx;

  @JsonKey(name: '@Description')
  final String? description;

  @JsonKey(name: '@Text')
  final String text;

  @JsonKey(name: 'Answer')
  final List<QuestionAnswersListQuestionAnswer>? answers;

  const QuestionAnswersListQuestion({
    required this.idx,
    this.description,
    required this.text,
    this.answers,
  });

  factory QuestionAnswersListQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswersListQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionAnswersListQuestionToJson(this);
}

@JsonSerializable()
class QuestionAnswersListQuestionAnswer {
  @JsonKey(name: 'evalue')
  final PollAnswer? evalue;

  @JsonKey(name: '@ClientAccount', fromJson: _clientAccountFakeString)
  final String? clientAccount;

  @JsonKey(name: '@FIO')
  final String? fio;

  const QuestionAnswersListQuestionAnswer({
    this.evalue,
    required this.clientAccount,
    required this.fio,
  });

  factory QuestionAnswersListQuestionAnswer.fromJson(
          Map<String, dynamic> json) =>
      _$QuestionAnswersListQuestionAnswerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$QuestionAnswersListQuestionAnswerToJson(this);

  // TODO: remove fake cast
  static String _clientAccountFakeString(Object? value) => value.toString();
}
