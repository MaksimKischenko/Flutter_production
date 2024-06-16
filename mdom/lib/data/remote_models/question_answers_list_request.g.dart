// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answers_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntQuestionAnswersListRequestWrapper
    _$MdomTpIntQuestionAnswersListRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntQuestionAnswersListRequestWrapper(
          MdomTpIntQuestionAnswersListRequest.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntQuestionAnswersListRequestWrapperToJson(
        MdomTpIntQuestionAnswersListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntQuestionAnswersListRequest
    _$MdomTpIntQuestionAnswersListRequestFromJson(Map<String, dynamic> json) =>
        MdomTpIntQuestionAnswersListRequest(
          QuestionAnswersListRequest.fromJson(
              json['QuestionAnswersListRequest'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntQuestionAnswersListRequestToJson(
        MdomTpIntQuestionAnswersListRequest instance) =>
    <String, dynamic>{
      'QuestionAnswersListRequest': instance.request,
    };

QuestionAnswersListRequest _$QuestionAnswersListRequestFromJson(
        Map<String, dynamic> json) =>
    QuestionAnswersListRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      pollId: json['PollId'] as int,
      questionId: json['QuestionId'] as int?,
    );

Map<String, dynamic> _$QuestionAnswersListRequestToJson(
    QuestionAnswersListRequest instance) {
  final val = <String, dynamic>{
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'KeyRequest': instance.keyRequest,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['Token'] = instance.token;
  val['PollId'] = instance.pollId;
  writeNotNull('QuestionId', instance.questionId);
  return val;
}
