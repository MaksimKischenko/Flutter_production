// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_poll_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntVotePollRequestWrapper _$MdomTpIntVotePollRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntVotePollRequestWrapper(
      MdomTpIntVotePollRequest.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntVotePollRequestWrapperToJson(
        MdomTpIntVotePollRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntVotePollRequest _$MdomTpIntVotePollRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntVotePollRequest(
      VotePollRequest.fromJson(json['VotePollRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntVotePollRequestToJson(
        MdomTpIntVotePollRequest instance) =>
    <String, dynamic>{
      'VotePollRequest': instance.request,
    };

VotePollRequest _$VotePollRequestFromJson(Map<String, dynamic> json) =>
    VotePollRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      pollId: json['PollId'] as int,
      account: json['Account'] as String,
      questions: (json['Question'] as List<dynamic>)
          .map((e) => VotePollQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VotePollRequestToJson(VotePollRequest instance) {
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
  val['Account'] = instance.account;
  val['Question'] = instance.questions;
  return val;
}

VotePollQuestion _$VotePollQuestionFromJson(Map<String, dynamic> json) =>
    VotePollQuestion(
      idx: json['@Idx'] as int,
      vote: $enumDecode(_$PollAnswerEnumMap, json['@Vote']),
    );

Map<String, dynamic> _$VotePollQuestionToJson(VotePollQuestion instance) =>
    <String, dynamic>{
      '@Idx': instance.idx,
      '@Vote': _$PollAnswerEnumMap[instance.vote]!,
    };

const _$PollAnswerEnumMap = {
  PollAnswer.yes: 'Yes',
  PollAnswer.no: 'No',
  PollAnswer.abstain: 'Abstain',
};
