// ignore_for_file: always_put_required_named_parameters_first

import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class PsTpOTokenResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOTokenResponse psTpO;

  PsTpOTokenResponseWrapper(this.psTpO);

  factory PsTpOTokenResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOTokenResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOTokenResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpOTokenResponse {

  @JsonKey(name: 'TokenResponse')
  final TokenResponse response;

  PsTpOTokenResponse(this.response);

  factory PsTpOTokenResponse.fromJson(Map<String, dynamic> json) => _$PsTpOTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOTokenResponseToJson(this);
}

@JsonSerializable()
class TokenResponse {

  @JsonKey(name: 'Token')
  final TokenResponseToken? token;

  @JsonKey(name: 'ClientType')
  final String? clientType;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  TokenResponse({
    required this.token,
    this.clientType,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
  
}

@JsonSerializable()
class TokenResponseToken {

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@TerminalId')
  final String terminalId;

  TokenResponseToken({
    required this.evalue,
    required this.terminalId,
  });

  factory TokenResponseToken.fromJson(Map<String, dynamic> json) => _$TokenResponseTokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseTokenToJson(this);
  
}
