// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_polls_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntIndividualPollsListResponseWrapper
    _$MdomTpIntIndividualPollsListResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntIndividualPollsListResponseWrapper(
          MdomTpIntIndividualPollsListResponse.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntIndividualPollsListResponseWrapperToJson(
        MdomTpIntIndividualPollsListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntIndividualPollsListResponse
    _$MdomTpIntIndividualPollsListResponseFromJson(Map<String, dynamic> json) =>
        MdomTpIntIndividualPollsListResponse(
          IndividualPollsListResponse.fromJson(
              json['IndividualPollsListResponse'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntIndividualPollsListResponseToJson(
        MdomTpIntIndividualPollsListResponse instance) =>
    <String, dynamic>{
      'IndividualPollsListResponse': instance.response,
    };

IndividualPollsListResponse _$IndividualPollsListResponseFromJson(
        Map<String, dynamic> json) =>
    IndividualPollsListResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      participantsCount: json['ParticipantsCount'] as int?,
      polls: (json['Poll'] as List<dynamic>?)
          ?.map((e) => Poll.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndividualPollsListResponseToJson(
        IndividualPollsListResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'ParticipantsCount': instance.participantsCount,
      'Poll': instance.polls,
    };

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      id: json['PollId'] as int,
      topic: json['Topic'] as String,
      status: $enumDecode(_$PollStatusEnumMap, json['Status']),
      startDate: json['StartDate'] as String,
      stopDate: json['StopDate'] as String,
      answerEditDisabled: json['BanChangeAnswer'] as int,
      currentResultHiden: json['HideCurrentResult'] as int?,
      url: json['URL'] as String?,
      anonymous: json['Anonymous'] as int,
      notificationDate: json['NotificationDate'] as String?,
      account: json['Account'] as String,
      voted: json['Voted'] as int?,
      votedCount: json['VotedCount'] as int?,
      questions: (json['Question'] as List<dynamic>?)
          ?.map((e) => PollListQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'PollId': instance.id,
      'Topic': instance.topic,
      'Status': _$PollStatusEnumMap[instance.status]!,
      'StartDate': instance.startDate,
      'StopDate': instance.stopDate,
      'URL': instance.url,
      'Anonymous': instance.anonymous,
      'BanChangeAnswer': instance.answerEditDisabled,
      'HideCurrentResult': instance.currentResultHiden,
      'NotificationDate': instance.notificationDate,
      'Account': instance.account,
      'Voted': instance.voted,
      'VotedCount': instance.votedCount,
      'Question': instance.questions,
    };

const _$PollStatusEnumMap = {
  PollStatus.all: 0,
  PollStatus.publication: -3,
  PollStatus.inProgress: 1,
  PollStatus.completed: 2,
};

PollListQuestion _$PollListQuestionFromJson(Map<String, dynamic> json) =>
    PollListQuestion(
      value: json['evalue'] as String,
      idx: json['@Idx'] as int,
      description: json['@Description'] as String?,
      positiveCount: json['@PositiveCount'] as int?,
      negativeCount: json['@NegativeCount'] as int?,
      abstainedCount: json['@AbstainedCount'] as int?,
      currentVote:
          $enumDecodeNullable(_$PollAnswerEnumMap, json['@CurrentVote']),
    );

Map<String, dynamic> _$PollListQuestionToJson(PollListQuestion instance) =>
    <String, dynamic>{
      'evalue': instance.value,
      '@Idx': instance.idx,
      '@Description': instance.description,
      '@PositiveCount': instance.positiveCount,
      '@NegativeCount': instance.negativeCount,
      '@AbstainedCount': instance.abstainedCount,
      '@CurrentVote': _$PollAnswerEnumMap[instance.currentVote],
    };

const _$PollAnswerEnumMap = {
  PollAnswer.yes: 'Yes',
  PollAnswer.no: 'No',
  PollAnswer.abstain: 'Abstain',
};
