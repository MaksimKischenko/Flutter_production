import 'package:json_annotation/json_annotation.dart';

part 'vote_poll_response.g.dart';

@JsonSerializable()
class MdomTpIntVotePollResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntVotePollResponse psTpInt;

  MdomTpIntVotePollResponseWrapper(this.psTpInt);

  factory MdomTpIntVotePollResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntVotePollResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntVotePollResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntVotePollResponse {

  @JsonKey(name: 'VotePollResponse')
  final VotePollResponse response;

  MdomTpIntVotePollResponse(this.response);

  factory MdomTpIntVotePollResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntVotePollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntVotePollResponseToJson(this);
  
}

@JsonSerializable()
class VotePollResponse {

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

  const VotePollResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
  });

  factory VotePollResponse.fromJson(Map<String, dynamic> json) => _$VotePollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VotePollResponseToJson(this);

}