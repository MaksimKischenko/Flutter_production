// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'get_secret_key_response.g.dart';

@JsonSerializable()
class PsHelppayGetSecretKeyResponseWrapper {

  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayGetSecretKeyResponse psErip;

  PsHelppayGetSecretKeyResponseWrapper(this.psErip);

  factory PsHelppayGetSecretKeyResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsHelppayGetSecretKeyResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetSecretKeyResponseWrapperToJson(this);
  
}

@JsonSerializable()
class PsHelppayGetSecretKeyResponse {

  @JsonKey(name: 'GetSecretKeyResponse')
  final GetSecretKeyResponse response;

  PsHelppayGetSecretKeyResponse(this.response);

  factory PsHelppayGetSecretKeyResponse.fromJson(Map<String, dynamic> json) => _$PsHelppayGetSecretKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetSecretKeyResponseToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class GetSecretKeyResponse {

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'SecretKey')
  final SecretKey secretKey;

  GetSecretKeyResponse({
    required this.errorCode,
    required this.secretKey,
    this.errorText,
  });


  factory GetSecretKeyResponse.fromJson(Map<String, dynamic> json) => _$GetSecretKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSecretKeyResponseToJson(this);
  
}

@JsonSerializable()
class SecretKey {

  @JsonKey(name: 'Value')
  final String? evalue;

  @JsonKey(name: 'Validity')
  final int validity;

  SecretKey({
    this.evalue,
    required this.validity,
  });

  factory SecretKey.fromJson(Map<String, dynamic> json) => _$SecretKeyFromJson(json);

  Map<String, dynamic> toJson() => _$SecretKeyToJson(this);
}
