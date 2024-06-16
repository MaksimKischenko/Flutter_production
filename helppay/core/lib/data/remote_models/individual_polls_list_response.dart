import 'package:equatable/equatable.dart';
import 'package:helppay_core/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'individual_polls_list_response.g.dart';

@JsonSerializable()
class MdomTpIntIndividualPollsListResponseWrapper {
  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntIndividualPollsListResponse psTpInt;

  MdomTpIntIndividualPollsListResponseWrapper(this.psTpInt);

  factory MdomTpIntIndividualPollsListResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$MdomTpIntIndividualPollsListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomTpIntIndividualPollsListResponseWrapperToJson(this);
}

@JsonSerializable()
class MdomTpIntIndividualPollsListResponse {
  @JsonKey(name: 'IndividualPollsListResponse')
  final IndividualPollsListResponse response;

  MdomTpIntIndividualPollsListResponse(this.response);

  factory MdomTpIntIndividualPollsListResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MdomTpIntIndividualPollsListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomTpIntIndividualPollsListResponseToJson(this);
}

@JsonSerializable()
class IndividualPollsListResponse {
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

  @JsonKey(name: 'ParticipantsCount')
  final int? participantsCount;

  @JsonKey(name: 'Poll')
  final List<Poll>? polls;

  const IndividualPollsListResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
    required this.participantsCount,
    required this.polls,
  });

  factory IndividualPollsListResponse.fromJson(Map<String, dynamic> json) =>
      _$IndividualPollsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IndividualPollsListResponseToJson(this);
}

@JsonSerializable()
class Poll extends Equatable {
  @JsonKey(name: 'PollId')
  final int id;

  @JsonKey(name: 'Topic')
  final String topic;

  @JsonKey(name: 'Status')
  final PollStatus status;

  @JsonKey(name: 'StartDate')
  final String startDate;

  @JsonKey(name: 'StopDate')
  final String stopDate;

  @JsonKey(name: 'URL')
  final String? url;

  @JsonKey(name: 'Anonymous')
  final int anonymous;

  @JsonKey(name: 'BanChangeAnswer')
  final int answerEditDisabled;

  @JsonKey(name: 'HideCurrentResult')
  final int? currentResultHiden;

  @JsonKey(name: 'NotificationDate')
  final String? notificationDate;

  @JsonKey(name: 'Account')
  final String account;

  @JsonKey(name: 'Voted')
  final int? voted;

  @JsonKey(name: 'VotedCount')
  final int? votedCount;

  @JsonKey(name: 'Question')
  final List<PollListQuestion>? questions;

  const Poll({
    required this.id,
    required this.topic,
    required this.status,
    required this.startDate,
    required this.stopDate,
    required this.answerEditDisabled,
    this.currentResultHiden,
    this.url,
    required this.anonymous,
    this.notificationDate,
    required this.account,
    this.voted,
    required this.votedCount,
    required this.questions,
  });

  factory Poll.empty() => const Poll(
        id: 0,
        topic: '',
        status: PollStatus.all,
        startDate: '',
        stopDate: '',
        account: '',
        anonymous: 0,
        votedCount: 0,
        questions: [],
        answerEditDisabled: 0,
      );

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  Map<String, dynamic> toJson() => _$PollToJson(this);

  Poll copyWith({
    int? id,
    String? topic,
    PollStatus? status,
    int? currentResultHiden,
    int? answerEditDisabled,
    String? startDate,
    String? stopDate,
    String? url,
    int? anonymous,
    String? notificationDate,
    String? account,
    int? voted,
    int? votedCount,
    List<PollListQuestion>? questions,
  }) =>
      Poll(
        id: id ?? this.id,
        topic: topic ?? this.topic,
        status: status ?? this.status,
        startDate: startDate ?? this.startDate,
        stopDate: stopDate ?? this.stopDate,
        url: url ?? this.url,
        currentResultHiden: currentResultHiden ?? this.currentResultHiden,
        answerEditDisabled: answerEditDisabled ?? this.answerEditDisabled,
        anonymous: anonymous ?? this.anonymous,
        notificationDate: notificationDate ?? this.notificationDate,
        account: account ?? this.account,
        voted: voted ?? this.voted,
        votedCount: votedCount ?? this.votedCount,
        questions: questions ?? this.questions,
      );

  @override
  List<Object?> get props => [
        id,
        topic,
        status,
        startDate,
        stopDate,
        url,
        anonymous,
        notificationDate,
        account,
        voted,
        votedCount,
        questions,
      ];
}

@JsonSerializable()
class PollListQuestion extends Equatable {
  @JsonKey(name: 'evalue')
  final String value;

  @JsonKey(name: '@Idx')
  final int idx;

  @JsonKey(name: '@Description')
  final String? description;

  @JsonKey(name: '@PositiveCount')
  final int? positiveCount;

  @JsonKey(name: '@NegativeCount')
  final int? negativeCount;

  @JsonKey(name: '@AbstainedCount')
  final int? abstainedCount;

  @JsonKey(name: '@CurrentVote')
  final PollAnswer? currentVote;

  const PollListQuestion({
    required this.value,
    required this.idx,
    this.description,
    this.positiveCount,
    this.negativeCount,
    this.abstainedCount,
    this.currentVote,
  });

  factory PollListQuestion.fromJson(Map<String, dynamic> json) =>
      _$PollListQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$PollListQuestionToJson(this);

  PollListQuestion copyWith({
    String? value,
    int? idx,
    String? description,
    int? positiveCount,
    int? negativeCount,
    int? abstainedCount,
    PollAnswer? currentVote,
  }) =>
      PollListQuestion(
        value: value ?? this.value,
        idx: idx ?? this.idx,
        description: description ?? this.description,
        positiveCount: positiveCount ?? this.positiveCount,
        negativeCount: negativeCount ?? this.negativeCount,
        abstainedCount: abstainedCount ?? this.abstainedCount,
        currentVote: currentVote ?? this.currentVote,
      );

  @override
  List<Object?> get props => [
        value,
        idx,
        description,
        positiveCount,
        negativeCount,
        abstainedCount,
        currentVote,
      ];
}
