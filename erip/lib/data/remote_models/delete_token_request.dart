import 'package:json_annotation/json_annotation.dart';

part 'delete_token_request.g.dart';

@JsonSerializable()
class PsTpODeleteTokenRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpODeleteTokenRequest psTpO;

  PsTpODeleteTokenRequestWrapper(this.psTpO);

  factory PsTpODeleteTokenRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpODeleteTokenRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteTokenRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpODeleteTokenRequest {

  @JsonKey(name: 'DeleteTokenRequest')
  final DeleteTokenRequest request;

  PsTpODeleteTokenRequest(this.request);

  factory PsTpODeleteTokenRequest.fromJson(Map<String, dynamic> json) => _$PsTpODeleteTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteTokenRequestToJson(this);
  
}

@JsonSerializable()
class DeleteTokenRequest {

  @JsonKey(name: 'Token')
  final String token;

  DeleteTokenRequest(this.token);

  factory DeleteTokenRequest.fromJson(Map<String, dynamic> json) => _$DeleteTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteTokenRequestToJson(this);
  
}