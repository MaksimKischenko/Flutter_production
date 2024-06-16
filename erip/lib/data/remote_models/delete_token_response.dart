import 'package:json_annotation/json_annotation.dart';

part 'delete_token_response.g.dart';

@JsonSerializable()
class PsTpODeleteTokenResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpODeleteTokenResponse psTpO;

  PsTpODeleteTokenResponseWrapper(this.psTpO);

  factory PsTpODeleteTokenResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpODeleteTokenResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteTokenResponseWrapperToJson(this);

}

@JsonSerializable()
class PsTpODeleteTokenResponse {

  @JsonKey(name: 'DeleteTokenResponse')
  final DeleteTokenResponse response;

  PsTpODeleteTokenResponse(this.response);

  factory PsTpODeleteTokenResponse.fromJson(Map<String, dynamic> json) => _$PsTpODeleteTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteTokenResponseToJson(this);
}

@JsonSerializable()
class DeleteTokenResponse {

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  DeleteTokenResponse({
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory DeleteTokenResponse.fromJson(Map<String, dynamic> json) => _$DeleteTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteTokenResponseToJson(this);
  
}
