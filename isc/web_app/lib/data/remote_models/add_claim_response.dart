import 'package:json_annotation/json_annotation.dart';

part 'add_claim_response.g.dart';

@JsonSerializable()
class PsTpOAddClaimResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOAddClaimResponse psTpO;

  PsTpOAddClaimResponseWrapper(this.psTpO);

  factory PsTpOAddClaimResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOAddClaimResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAddClaimResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpOAddClaimResponse {

  @JsonKey(name: 'AddClaimResponse')
  final AddClaimResponse response;

  PsTpOAddClaimResponse(this.response);

  factory PsTpOAddClaimResponse.fromJson(Map<String, dynamic> json) => _$PsTpOAddClaimResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAddClaimResponseToJson(this);
}

@JsonSerializable()
class AddClaimResponse {

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;
 
  @JsonKey(name: 'InvoiceDate')
  final String invoiceDate;

  @JsonKey(name: 'ClaimId')
  final int claimId;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  AddClaimResponse({
    required this.invoiceDate,
    required this.claimId,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText
  });

  factory AddClaimResponse.fromJson(Map<String, dynamic> json) => _$AddClaimResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddClaimResponseToJson(this);
  
}
