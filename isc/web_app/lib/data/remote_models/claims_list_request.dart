// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:isc_web_app/models/models.dart';
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

  @JsonKey(name: 'ServiceCode')
  final int serviceCode;

  @JsonKey(name: 'DateFrom')
  final String dateFrom;

  @JsonKey(name: 'DateTo')
  final String dateTo;

  @JsonKey(name: 'AccNum')
  final String? accNum;

  @JsonKey(name: 'Status')
  final ClaimStatus status; 

  @JsonKey(name: 'RowCount')
  final RowCount? rowCount;

  ClaimsListRequest({
    required this.version,
    required this.key,
    required this.token,
    required this.terminalId,
    required this.serviceCode,
    required this.dateFrom,
    required this.dateTo,
    this.accNum,
    required this.status,
    this.rowCount,
  });



  factory ClaimsListRequest.fromJson(Map<String, dynamic> json) => _$ClaimsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class RowCount {

  @JsonKey(name:'evalue')
  final int evalue;

  @JsonKey(name: '@ClaimId')
  final int? claimId;

  const RowCount({
    required this.evalue,
    this.claimId,
  });
  
  factory RowCount.fromJson(Map<String, dynamic> json) => _$RowCountFromJson(json);

  Map<String, dynamic> toJson() => _$RowCountToJson(this);
}
