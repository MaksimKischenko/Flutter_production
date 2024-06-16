// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_polls_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntEntityPollsListResponseWrapper
    _$MdomTpIntEntityPollsListResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntEntityPollsListResponseWrapper(
          MdomTpIntEntityPollsListResponse.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntEntityPollsListResponseWrapperToJson(
        MdomTpIntEntityPollsListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntEntityPollsListResponse _$MdomTpIntEntityPollsListResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntEntityPollsListResponse(
      EntityPollsListResponse.fromJson(
          json['EntityPollsListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntEntityPollsListResponseToJson(
        MdomTpIntEntityPollsListResponse instance) =>
    <String, dynamic>{
      'EntityPollsListResponse': instance.response,
    };

EntityPollsListResponse _$EntityPollsListResponseFromJson(
        Map<String, dynamic> json) =>
    EntityPollsListResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      confirmedCount: json['ConfirmedCount'] as int?,
      participantsCount: json['ParticipantsCount'] as int?,
      polls: (json['Poll'] as List<dynamic>?)
          ?.map((e) => Poll.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EntityPollsListResponseToJson(
        EntityPollsListResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'ConfirmedCount': instance.confirmedCount,
      'ParticipantsCount': instance.participantsCount,
      'Poll': instance.polls,
    };

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      id: json['PollId'] as int,
      topic: json['Topic'] as String,
      status: $enumDecode(_$PollStatusEnumMap, json['Status']),
      startDate: json['StartDate'] as String?,
      stopDate: json['StopDate'] as String?,
      url: json['URL'] as String?,
      anonymous: json['Anonymous'] as int,
      notificationDate: json['NotificationDate'] as String?,
      cancelDate: json['CancelDate'] as String?,
      confirmedCount: json['ConfirmedCount'] as int?,
      participantsCount: json['ParticipantsCount'] as int?,
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
      'NotificationDate': instance.notificationDate,
      'CancelDate': instance.cancelDate,
      'ConfirmedCount': instance.confirmedCount,
      'ParticipantsCount': instance.participantsCount,
      'VotedCount': instance.votedCount,
      'Question': instance.questions,
    };

const _$PollStatusEnumMap = {
  PollStatus.all: 0,
  PollStatus.draft: -1,
  PollStatus.canceled: -2,
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
    );

Map<String, dynamic> _$PollListQuestionToJson(PollListQuestion instance) =>
    <String, dynamic>{
      'evalue': instance.value,
      '@Idx': instance.idx,
      '@Description': instance.description,
      '@PositiveCount': instance.positiveCount,
      '@NegativeCount': instance.negativeCount,
      '@AbstainedCount': instance.abstainedCount,
    };
