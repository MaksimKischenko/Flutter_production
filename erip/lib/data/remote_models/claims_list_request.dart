// ignore_for_file: always_put_required_named_parameters_first

import 'package:json_annotation/json_annotation.dart';

part 'claims_list_request.g.dart';

@JsonSerializable()
class PsTpOClaimsListRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOClaimsListRequest psTpO;

  PsTpOClaimsListRequestWrapper(this.psTpO);

  factory PsTpOClaimsListRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOClaimsListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOClaimsListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOClaimsListRequest {

  @JsonKey(name: 'ClaimsListRequest')
  final ClaimsListRequest request;

  PsTpOClaimsListRequest(this.request);

  factory PsTpOClaimsListRequest.fromJson(Map<String, dynamic> json) => _$PsTpOClaimsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOClaimsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class ClaimsListRequest {

  @JsonKey(name: 'ServiceCode')
  final int serviceCode;

  @JsonKey(name: 'DateFrom')
  final String dateFrom;

  @JsonKey(name: 'DateTo')
  final String dateTo;

  //optional
  @JsonKey(name: 'AccNum')
  final String? accNum;

  @JsonKey(name: 'ClaimId')
  final int? claimId;

  @JsonKey(name: 'Status')
  final int? status;

  @JsonKey(name: 'RowCount')
  final RowCountClaims? rowCount;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  ClaimsListRequest({
    required this.serviceCode,
    required this.dateFrom,
    required this.dateTo,
    this.accNum,
    this.claimId,
    this.status,
    this.rowCount,
    required this.token,
    required this.version,
    required this.key,
  });

  factory ClaimsListRequest.fromJson(Map<String, dynamic> json) => _$ClaimsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsListRequestToJson(this);
  
}

@JsonSerializable()
class RowCountClaims {

  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@ClaimId')
  final int? claimId;

  RowCountClaims({
    required this.evalue,
    this.claimId,
  });
  
  factory RowCountClaims.fromJson(Map<String, dynamic> json) => _$RowCountClaimsFromJson(json);

  Map<String, dynamic> toJson() => _$RowCountClaimsToJson(this);

}
