import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity_polls_list_response.g.dart';

@JsonSerializable()
class MdomTpIntEntityPollsListResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntEntityPollsListResponse psTpInt;

  MdomTpIntEntityPollsListResponseWrapper(this.psTpInt);

  factory MdomTpIntEntityPollsListResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntEntityPollsListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEntityPollsListResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntEntityPollsListResponse {

  @JsonKey(name: 'EntityPollsListResponse')
  final EntityPollsListResponse response;

  MdomTpIntEntityPollsListResponse(this.response);

  factory MdomTpIntEntityPollsListResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntEntityPollsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEntityPollsListResponseToJson(this);
  
}

@JsonSerializable()
class EntityPollsListResponse {

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

  @JsonKey(name: 'ConfirmedCount')
  final int? confirmedCount;

  @JsonKey(name: 'ParticipantsCount')
  final int? participantsCount;

  @JsonKey(name: 'Poll')
  final List<Poll>? polls;

  const EntityPollsListResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
    this.confirmedCount,
    this.participantsCount,
    this.polls,
  });

  factory EntityPollsListResponse.fromJson(Map<String, dynamic> json) => _$EntityPollsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EntityPollsListResponseToJson(this);

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
  final String? startDate;

  @JsonKey(name: 'StopDate')
  final String? stopDate;

  @JsonKey(name: 'URL')
  final String? url;

  @JsonKey(name: 'Anonymous')
  final int anonymous;

  @JsonKey(name: 'NotificationDate')
  final String? notificationDate;

  @JsonKey(name: 'CancelDate')
  final String? cancelDate;

  @JsonKey(name: 'ConfirmedCount')
  final int? confirmedCount;

  @JsonKey(name: 'ParticipantsCount')
  final int? participantsCount;

  @JsonKey(name: 'VotedCount')
  final int? votedCount;

  @JsonKey(name: 'Question')
  final List<PollListQuestion>? questions;

  const Poll({
    required this.id,
    required this.topic,
    required this.status,
    this.startDate,
    this.stopDate,
    this.url,
    required this.anonymous,
    this.notificationDate,
    this.cancelDate,
    this.confirmedCount,
    this.participantsCount,
    required this.votedCount,
    required this.questions,
  });

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  Map<String, dynamic> toJson() => _$PollToJson(this);

  Poll copyWith({
    int? id,
    String? topic,
    PollStatus? status,
    String? startDate,
    String? stopDate,
    String? url,
    int? anonymous,
    String? notificationDate,
    String? cancelDate,
    int? confirmedCount,
    int? participantsCount,
    int? votedCount,
    List<PollListQuestion>? questions,
  }) => Poll(
    id: id ?? this.id,
    topic: topic ?? this.topic,
    status: status ?? this.status,
    startDate: startDate ?? this.startDate,
    stopDate: stopDate ?? this.stopDate,
    url: url ?? this.url,
    anonymous: anonymous ?? this.anonymous,
    notificationDate: notificationDate ?? this.notificationDate,
    cancelDate: cancelDate ?? this.cancelDate,
    confirmedCount: confirmedCount ?? this.confirmedCount,
    participantsCount: participantsCount ?? this.participantsCount,
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
    cancelDate,
    confirmedCount,
    participantsCount,
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

  const PollListQuestion({
    required this.value,
    required this.idx,
    this.description,
    this.positiveCount,
    this.negativeCount,
    this.abstainedCount,
  });

  factory PollListQuestion.fromJson(Map<String, dynamic> json) => _$PollListQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$PollListQuestionToJson(this);

  PollListQuestion copyWith({
    String? value,
    int? idx,
    String? description,
    int? positiveCount,
    int? negativeCount,
    int? abstainedCount,
  }) => PollListQuestion(
    value: value ?? this.value,
    idx: idx ?? this.idx,
    description: description ?? this.description,
    positiveCount: positiveCount ?? this.positiveCount,
    negativeCount: negativeCount ?? this.negativeCount,
    abstainedCount: abstainedCount ?? this.abstainedCount,
  );

  @override
  List<Object?> get props => [
    value,
    idx,
    description,
    positiveCount,
    negativeCount,
    abstainedCount,
  ];
}
