import 'package:bpc/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poll_members_list_request.g.dart';

@JsonSerializable()
class MdomTpIntPollMembersListRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntPollMembersListRequest psTpInt;

  MdomTpIntPollMembersListRequestWrapper(this.psTpInt);

  factory MdomTpIntPollMembersListRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntPollMembersListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntPollMembersListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntPollMembersListRequest {

  @JsonKey(name: 'PollMembersListRequest')
  final PollMembersListRequest request;

  MdomTpIntPollMembersListRequest(this.request);

  factory MdomTpIntPollMembersListRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntPollMembersListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntPollMembersListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class PollMembersListRequest {

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

  PollMembersListRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    required this.pollId,
  });

  factory PollMembersListRequest.fromJson(Map<String, dynamic> json) => _$PollMembersListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PollMembersListRequestToJson(this);
  
}