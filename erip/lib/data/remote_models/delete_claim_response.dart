import 'package:json_annotation/json_annotation.dart';

part 'delete_claim_response.g.dart';

@JsonSerializable()
class PsTpODeleteClaimResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpODeleteClaimResponse psTpO;

  PsTpODeleteClaimResponseWrapper(this.psTpO);

  factory PsTpODeleteClaimResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpODeleteClaimResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteClaimResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpODeleteClaimResponse {

  @JsonKey(name: 'DeleteClaimResponse')
  final DeleteClaimResponse response;

  PsTpODeleteClaimResponse(this.response);

  factory PsTpODeleteClaimResponse.fromJson(Map<String, dynamic> json) => _$PsTpODeleteClaimResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteClaimResponseToJson(this);
}

@JsonSerializable()
class DeleteClaimResponse {

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  DeleteClaimResponse({
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory DeleteClaimResponse.fromJson(Map<String, dynamic> json) => _$DeleteClaimResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteClaimResponseToJson(this);
  
}
