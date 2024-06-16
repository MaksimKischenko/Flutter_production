import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vote_poll_request.g.dart';

@JsonSerializable()
class MdomTpIntVotePollRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntVotePollRequest psTpInt;

  MdomTpIntVotePollRequestWrapper(this.psTpInt);

  factory MdomTpIntVotePollRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntVotePollRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntVotePollRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntVotePollRequest {

  @JsonKey(name: 'VotePollRequest')
  final VotePollRequest request;

  MdomTpIntVotePollRequest(this.request);

  factory MdomTpIntVotePollRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntVotePollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntVotePollRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class VotePollRequest {

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

  @JsonKey(name: 'Account')
  final String account;

  @JsonKey(name: 'Question')
  final List<VotePollQuestion> questions;

  VotePollRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.pollId,
    required this.account,
    required this.questions,
  });

  factory VotePollRequest.fromJson(Map<String, dynamic> json) => _$VotePollRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VotePollRequestToJson(this);
  
}

@JsonSerializable()
class VotePollQuestion {

  @JsonKey(name: '@Idx')
  final int idx;

  @JsonKey(name: '@Vote')
  final PollAnswer vote;

  VotePollQuestion({
    required this.idx,
    required this.vote
  });

  factory VotePollQuestion.fromJson(Map<String, dynamic> json) => _$VotePollQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$VotePollQuestionToJson(this);
  
}