import 'package:helppay_core/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response.g.dart';

@JsonSerializable()
class MdomRefreshTokenResponseWrapper {
  @JsonKey(name: 'UserRequest')
  final MdomRefreshTokenResponse response;

  MdomRefreshTokenResponseWrapper(this.response);

  factory MdomRefreshTokenResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$MdomRefreshTokenResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomRefreshTokenResponseWrapperToJson(this);
}

@JsonSerializable()
class MdomRefreshTokenResponse {
  // @JsonKey(name: 'RequestType')
  // final String? requestType;

  @JsonKey(name: 'Version')
  final int? version;

  @JsonKey(name: 'KeyRequest')
  final int? keyRequest;

  @JsonKey(name: 'ErrorCode')
  final MdomErrorCode? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Token')
  final MdomToken token;

  const MdomRefreshTokenResponse({
    this.version,
    this.keyRequest,
    this.errorText,
    this.errorCode,
    required this.token,
  });

  factory MdomRefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$MdomRefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomRefreshTokenResponseToJson(this);
}
