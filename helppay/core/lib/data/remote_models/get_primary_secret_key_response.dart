// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'get_primary_secret_key_response.g.dart';


@JsonSerializable()
class PsHelppayGetPrimarySecretKeyResponseWrapper {

  @JsonKey(name: 'PS_HELPPAY')
  final GetPrimarySecretKeyResponse response;

  PsHelppayGetPrimarySecretKeyResponseWrapper(this.response);

  factory PsHelppayGetPrimarySecretKeyResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsHelppayGetPrimarySecretKeyResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetPrimarySecretKeyResponseWrapperToJson(this);
  
}


@JsonSerializable(includeIfNull: false)
class GetPrimarySecretKeyResponse {

  @JsonKey(name: 'Key')
  final String secretKey;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorMessage')
  final String? errorText;


  GetPrimarySecretKeyResponse({
    required this.errorCode,
    required this.secretKey,
    this.errorText,
  });


  factory GetPrimarySecretKeyResponse.fromJson(Map<String, dynamic> json) => _$GetPrimarySecretKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrimarySecretKeyResponseToJson(this);
  
}

