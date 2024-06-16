import 'package:json_annotation/json_annotation.dart';

part 'token_request.g.dart';

@JsonSerializable()
class PsTpOTokenRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOTokenRequest psTpO;

  PsTpOTokenRequestWrapper(this.psTpO);

  factory PsTpOTokenRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOTokenRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOTokenRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOTokenRequest {

  @JsonKey(name: 'TokenRequest')
  final TokenRequest request;

  PsTpOTokenRequest(this.request);

  factory PsTpOTokenRequest.fromJson(Map<String, dynamic> json) => _$PsTpOTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOTokenRequestToJson(this);
  
}

@JsonSerializable()
class TokenRequest {

  @JsonKey(name: 'LoginName')
  final TokenRequestLoginName login;

  @JsonKey(name: 'Password')
  final String password;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  TokenRequest({
    required this.login,
    required this.password,
    required this.version,
    required this.key,
  });

  factory TokenRequest.fromJson(Map<String, dynamic> json) => _$TokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRequestToJson(this);
  
}

@JsonSerializable()
class TokenRequestLoginName {

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@DeviceType')
  final String deviceType;

  TokenRequestLoginName({
    required this.evalue,
    required this.deviceType,
  });

  factory TokenRequestLoginName.fromJson(Map<String, dynamic> json) => _$TokenRequestLoginNameFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRequestLoginNameToJson(this);
  
}
