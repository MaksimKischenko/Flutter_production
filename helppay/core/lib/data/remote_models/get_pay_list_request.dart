import 'package:json_annotation/json_annotation.dart';

part 'get_pay_list_request.g.dart';

@JsonSerializable()
class PsEripGetPayListRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripGetPayListRequest psErip;

  PsEripGetPayListRequestWrapper(this.psErip);

  factory PsEripGetPayListRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripGetPayListRequest {

  @JsonKey(name: 'GetPayListRequest')
  final GetPayListRequest request;

  PsEripGetPayListRequest(this.request);

  factory PsEripGetPayListRequest.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class GetPayListRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalID;

  @JsonKey(name: 'DIType')
  final int diType;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Filter')
  final FilterQr? filter;

  @JsonKey(name: 'PayCode')
  final int? payCode;

  @JsonKey(name: 'SessionId')
  final String? sessionId;

  @JsonKey(name: 'AttrRecord')
  final List<AttrRecordRequest>? attrRecord;

  GetPayListRequest({
    required this.terminalID,
    required this.diType,
    required this.version,
    required this.token,
    this.filter,
    this.payCode,
    this.sessionId,
    this.attrRecord,
  });

  factory GetPayListRequest.fromJson(Map<String, dynamic> json) => _$GetPayListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class AttrRecordRequest {

  @JsonKey(name: '@Code')
  final int code;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@Value')
  String? value;

  @JsonKey(name: '@Change')
  int? change;

  AttrRecordRequest({
    required this.code,
    this.name,
    this.codeOut,
    this.value,
    this.change,
  });

  factory AttrRecordRequest.fromJson(Map<String, dynamic> json) => _$AttrRecordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttrRecordRequestToJson(this);
  
}

@JsonSerializable()
class FilterQr {

  @JsonKey(name: 'AttrRecord')
  final List <AttrRecordQr> attrRecordQr;

  FilterQr({
    required this.attrRecordQr,
  });

  factory FilterQr.fromJson(Map<String, dynamic> json) => _$FilterQrFromJson(json);

  Map<String, dynamic> toJson() => _$FilterQrToJson(this);
  
}

@JsonSerializable()
class AttrRecordQr {

  @JsonKey(name: '@Code')
  final String? attrCode;

  @JsonKey(name: '@Value')
  final String? value;

  AttrRecordQr({
    this.attrCode,
    this.value,
  });

  factory AttrRecordQr.fromJson(Map<String, dynamic> json) => _$AttrRecordQrFromJson(json);

  Map<String, dynamic> toJson() => _$AttrRecordQrToJson(this);
  
}