import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'get_pay_list_request.g.dart';

@JsonSerializable()
class PsEripGetPayListRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripGetPayListRequest psErip;

  const PsEripGetPayListRequestWrapper(this.psErip);

  factory PsEripGetPayListRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripGetPayListRequest {

  @JsonKey(name: 'GetPayListRequest')
  final GetPayListRequest request;

  const PsEripGetPayListRequest(this.request);

  factory PsEripGetPayListRequest.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class GetPayListRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'PAN')
  final PAN? pan;

  @JsonKey(name: 'TypePAN')
  final TypePAN? typePan;

  // @JsonKey(name: 'Token')
  // final String? token;

  @JsonKey(name: 'PayCode')
  final int payCode;

  @JsonKey(name: 'AttrRecord')
  final List<AttrRecordRequest>? attrRecord;

  @JsonKey(name: 'PaySumma')
  final GetPayListRequestPaySumma? paySumma;

  @JsonKey(name: 'SessionId')
  final String? sessionId;

  // @JsonKey(name: 'Property')
  // final List<RequestProperty>? properties;

  const GetPayListRequest({
    required this.terminalId,
    required this.version,
    this.pan,
    this.typePan,
    // this.token,
    required this.payCode,
    this.attrRecord,
    this.paySumma,
    this.sessionId,
    //this.properties
  });

  factory GetPayListRequest.fromJson(Map<String, dynamic> json) => _$GetPayListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class GetPayListRequestFilter {

  @JsonKey(name: 'AttrRecord')
  final List<FilterAttrRecord>? attrRecords;

  const GetPayListRequestFilter({
    this.attrRecords
  });

  factory GetPayListRequestFilter.fromJson(Map<String, dynamic> json) => _$GetPayListRequestFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListRequestFilterToJson(this);
}

@JsonSerializable(includeIfNull: false)
class FilterAttrRecord extends Equatable {

  @JsonKey(name: '@Code')
  final int code;

  @JsonKey(name: '@Value')
  final String? value;

  const FilterAttrRecord({
    required this.code,
    required this.value,
  });

  factory FilterAttrRecord.fromJson(Map<String, dynamic> json) => _$FilterAttrRecordFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAttrRecordToJson(this);

  @override
  List<Object?> get props => [code, value];

}

@JsonSerializable(includeIfNull: false)
class GetPayListRequestPaySumma {

  @JsonKey(name: 'evalue')
  final double? evalue;

  @JsonKey(name: '@Currency')
  final int? currency;

  const GetPayListRequestPaySumma({
    this.evalue,
    this.currency
  });

  factory GetPayListRequestPaySumma.fromJson(Map<String, dynamic> json) => _$GetPayListRequestPaySummaFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListRequestPaySummaToJson(this);
  
}