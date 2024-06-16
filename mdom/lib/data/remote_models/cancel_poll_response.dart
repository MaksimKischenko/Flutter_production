import 'package:json_annotation/json_annotation.dart';

part 'cancel_poll_response.g.dart';

@JsonSerializable()
class MdomTpIntCancelPollResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntCancelPollResponse psTpInt;

  MdomTpIntCancelPollResponseWrapper(this.psTpInt);

  factory MdomTpIntCancelPollResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntCancelPollResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntCancelPollResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntCancelPollResponse {

  @JsonKey(name: 'CancelPollResponse')
  final CancelPollResponse response;

  MdomTpIntCancelPollResponse(this.response);

  factory MdomTpIntCancelPollResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntCancelPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntCancelPollResponseToJson(this);
  
}

@JsonSerializable()
class CancelPollResponse {

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

  const CancelPollResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
  });

  factory CancelPollResponse.fromJson(Map<String, dynamic> json) => _$CancelPollResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CancelPollResponseToJson(this);

}