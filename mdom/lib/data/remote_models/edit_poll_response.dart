import 'package:json_annotation/json_annotation.dart';

part 'edit_poll_response.g.dart';

@JsonSerializable()
class MdomTpIntEditPollResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntEditPollResponse psTpInt;

  MdomTpIntEditPollResponseWrapper(this.psTpInt);

  factory MdomTpIntEditPollResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntEditPollResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEditPollResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntEditPollResponse {

  @JsonKey(name: 'EditPollResponse')
  final EditPollResponse response;

  MdomTpIntEditPollResponse(this.response);

  factory MdomTpIntEditPollResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntEditPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEditPollResponseToJson(this);
  
}

@JsonSerializable()
class EditPollResponse {

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

  const EditPollResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
  });

  factory EditPollResponse.fromJson(Map<String, dynamic> json) => _$EditPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditPollResponseToJson(this);

}