import 'package:json_annotation/json_annotation.dart';

part 'add_poll_response.g.dart';

@JsonSerializable()
class MdomTpIntAddPollResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntAddPollResponse psTpInt;

  MdomTpIntAddPollResponseWrapper(this.psTpInt);

  factory MdomTpIntAddPollResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntAddPollResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntAddPollResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntAddPollResponse {

  @JsonKey(name: 'AddPollResponse')
  final AddPollResponse response;

  MdomTpIntAddPollResponse(this.response);

  factory MdomTpIntAddPollResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntAddPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntAddPollResponseToJson(this);
  
}

@JsonSerializable()
class AddPollResponse {

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

  @JsonKey(name: 'PollId')
  final int? id;

  const AddPollResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
    this.id,
  });

  factory AddPollResponse.fromJson(Map<String, dynamic> json) => _$AddPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddPollResponseToJson(this);

}