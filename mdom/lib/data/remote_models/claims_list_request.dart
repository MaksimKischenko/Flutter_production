import 'package:bpc/models/models.dart';
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

  // general part

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  // general part END

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
  final ClaimStatus? status;

  @JsonKey(name: 'RowCount')
  final RowCountClaims? rowCount;

  const ClaimsListRequest({
    required this.version,
    required this.key,
    required this.token,
    required this.terminalId,
    required this.serviceCode,
    required this.dateFrom,
    required this.dateTo,
    this.accNum,
    this.claimId,
    this.status,
    this.rowCount,
  });

  factory ClaimsListRequest.fromJson(Map<String, dynamic> json) => _$ClaimsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class RowCountClaims {

  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@ClaimId')
  final int? claimId;

  const RowCountClaims({
    required this.evalue,
    this.claimId,
  });
  
  factory RowCountClaims.fromJson(Map<String, dynamic> json) => _$RowCountClaimsFromJson(json);

  Map<String, dynamic> toJson() => _$RowCountClaimsToJson(this);

}
