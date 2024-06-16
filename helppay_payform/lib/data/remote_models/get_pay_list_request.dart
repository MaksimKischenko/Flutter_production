import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'get_pay_list_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetPayListRequest {

  @JsonKey(name: 'PayCode')
  final GetPayListRequestPayCode payCode;

  @JsonKey(name: 'DIType')
  final int diType;

  @JsonKey(name: 'Filter')
  final GetPayListRequestFilter? filter;

  @JsonKey(name: 'SessionId')
  final String? sessionId;

  @JsonKey(name: 'AttrRecord')
  final List<AttrRecordRequest>? attrRecord;

  @JsonKey(name: 'PaySumma')
  final GetPayListRequestPaySumma? paySumma;

  @JsonKey(name: 'Property')
  final List<RequestProperty>? properties;

  const GetPayListRequest({
    required this.payCode,
    required this.diType,
    this.filter,
    this.sessionId,
    this.attrRecord,
    this.paySumma,
    this.properties
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
  String? value;

  FilterAttrRecord({
    required this.code,
    required this.value,
  });

  factory FilterAttrRecord.fromJson(Map<String, dynamic> json) => _$FilterAttrRecordFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAttrRecordToJson(this);

  @override
  List<Object?> get props => [code, value];

}

@JsonSerializable(includeIfNull: false)
class GetPayListRequestPayCode {

  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@Type')
  final String? type;

  const GetPayListRequestPayCode({
    required this.evalue,
    this.type
  });

  factory GetPayListRequestPayCode.fromJson(Map<String, dynamic> json) => _$GetPayListRequestPayCodeFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListRequestPayCodeToJson(this);

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