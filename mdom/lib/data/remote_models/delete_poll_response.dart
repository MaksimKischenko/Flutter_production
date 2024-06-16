import 'package:json_annotation/json_annotation.dart';

part 'delete_poll_response.g.dart';

@JsonSerializable()
class MdomTpIntDeletePollResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntDeletePollResponse psTpInt;

  MdomTpIntDeletePollResponseWrapper(this.psTpInt);

  factory MdomTpIntDeletePollResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntDeletePollResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntDeletePollResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntDeletePollResponse {

  @JsonKey(name: 'DeletePollResponse')
  final DeletePollResponse response;

  MdomTpIntDeletePollResponse(this.response);

  factory MdomTpIntDeletePollResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntDeletePollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntDeletePollResponseToJson(this);
  
}

@JsonSerializable()
class DeletePollResponse {

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

  const DeletePollResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
  });

  factory DeletePollResponse.fromJson(Map<String, dynamic> json) => _$DeletePollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePollResponseToJson(this);

}