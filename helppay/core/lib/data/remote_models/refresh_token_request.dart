import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable()
class MdomRefreshTokenRequestWrapper {
  @JsonKey(name: 'UserRequest')
  final MdomRefreshTokenRequest request;

  MdomRefreshTokenRequestWrapper(this.request);

  factory MdomRefreshTokenRequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$MdomRefreshTokenRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomRefreshTokenRequestWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MdomRefreshTokenRequest {
  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Lang')
  final String? lang;

  MdomRefreshTokenRequest({
    required this.terminalId,
    required this.version,
    required this.token,
    this.lang,
    this.requestType = 'RefreshToken', //TODO change as needed
  });

  factory MdomRefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$MdomRefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomRefreshTokenRequestToJson(this);
}
