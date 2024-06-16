// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answers_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntQuestionAnswersListResponseWrapper
    _$MdomTpIntQuestionAnswersListResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntQuestionAnswersListResponseWrapper(
          MdomTpIntQuestionAnswersListResponse.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntQuestionAnswersListResponseWrapperToJson(
        MdomTpIntQuestionAnswersListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntQuestionAnswersListResponse
    _$MdomTpIntQuestionAnswersListResponseFromJson(Map<String, dynamic> json) =>
        MdomTpIntQuestionAnswersListResponse(
          QuestionAnswersListResponse.fromJson(
              json['QuestionAnswersListResponse'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntQuestionAnswersListResponseToJson(
        MdomTpIntQuestionAnswersListResponse instance) =>
    <String, dynamic>{
      'QuestionAnswersListResponse': instance.response,
    };

QuestionAnswersListResponse _$QuestionAnswersListResponseFromJson(
        Map<String, dynamic> json) =>
    QuestionAnswersListResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      questions: (json['Question'] as List<dynamic>?)
          ?.map((e) =>
              QuestionAnswersListQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionAnswersListResponseToJson(
        QuestionAnswersListResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'Question': instance.questions,
    };

QuestionAnswersListQuestion _$QuestionAnswersListQuestionFromJson(
        Map<String, dynamic> json) =>
    QuestionAnswersListQuestion(
      idx: json['@Idx'] as int,
      description: json['@Description'] as String?,
      text: json['@Text'] as String,
      answers: (json['Answer'] as List<dynamic>?)
          ?.map((e) => QuestionAnswersListQuestionAnswer.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionAnswersListQuestionToJson(
        QuestionAnswersListQuestion instance) =>
    <String, dynamic>{
      '@Idx': instance.idx,
      '@Description': instance.description,
      '@Text': instance.text,
      'Answer': instance.answers,
    };

QuestionAnswersListQuestionAnswer _$QuestionAnswersListQuestionAnswerFromJson(
        Map<String, dynamic> json) =>
    QuestionAnswersListQuestionAnswer(
      evalue: $enumDecodeNullable(_$PollAnswerEnumMap, json['evalue']),
      clientAccount: QuestionAnswersListQuestionAnswer._clientAccountFakeString(
          json['@ClientAccount']),
      fio: json['@FIO'] as String?,
    );

Map<String, dynamic> _$QuestionAnswersListQuestionAnswerToJson(
        QuestionAnswersListQuestionAnswer instance) =>
    <String, dynamic>{
      'evalue': _$PollAnswerEnumMap[instance.evalue],
      '@ClientAccount': instance.clientAccount,
      '@FIO': instance.fio,
    };

const _$PollAnswerEnumMap = {
  PollAnswer.yes: 'Yes',
  PollAnswer.no: 'No',
  PollAnswer.abstain: 'Abstain',
};
