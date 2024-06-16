import 'package:json_annotation/json_annotation.dart';

part 'delete_claim_request.g.dart';

@JsonSerializable()
class PsTpODeleteClaimRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpODeleteClaimRequest psTpO;

  PsTpODeleteClaimRequestWrapper(this.psTpO);

  factory PsTpODeleteClaimRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpODeleteClaimRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteClaimRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpODeleteClaimRequest {

  @JsonKey(name: 'DeleteClaimRequest')
  final DeleteClaimRequest request;

  PsTpODeleteClaimRequest(this.request);

  factory PsTpODeleteClaimRequest.fromJson(Map<String, dynamic> json) => _$PsTpODeleteClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpODeleteClaimRequestToJson(this);
  
}

@JsonSerializable()
class DeleteClaimRequest {

  @JsonKey(name: 'ClaimId')
  final int claimId;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  DeleteClaimRequest({
    required this.claimId,
    required this.token,
    required this.version,
    required this.key,
  });

  factory DeleteClaimRequest.fromJson(Map<String, dynamic> json) => _$DeleteClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteClaimRequestToJson(this);
  
}
