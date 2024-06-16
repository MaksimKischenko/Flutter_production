import 'package:json_annotation/json_annotation.dart';

part 'confirm_response.g.dart';

@JsonSerializable()
class PsEripConfirmResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripConfirmResponse psErip;

  PsEripConfirmResponseWrapper(this.psErip);

  factory PsEripConfirmResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripConfirmResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripConfirmResponse {

  @JsonKey(name: 'ConfirmResponse')
  final ConfirmResponse response;

  PsEripConfirmResponse(this.response);

  factory PsEripConfirmResponse.fromJson(Map<String, dynamic> json) => _$PsEripConfirmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ConfirmResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'PayRecord')
  final ConfirmPayRecordResponse? payRecord;

  const ConfirmResponse({
    this.errorCode,
    this.errorText,
    this.payRecord,
  });

  factory ConfirmResponse.fromJson(Map<String, dynamic> json) => _$ConfirmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmResponseToJson(this);
  
}

@JsonSerializable()
class ConfirmPayRecordResponse {

  @JsonKey(name: '@PaymentID')
  final int paymentID;

  @JsonKey(name: '@Date')
  final String date;

  @JsonKey(name: '@KioskReceipt')
  final String kioskReceipt;

  @JsonKey(name: '@RecordID')
  final int recordID;

  @JsonKey(name: '@Storn')
  final int? storn;

  @JsonKey(name: '@AttrRecord')
  final ConfirmAttrRecordResponse? attrRecord;

  @JsonKey(name: '@Check')
  final ConfirmCheckResponse? check;

  

  ConfirmPayRecordResponse({
    required this.paymentID,
    required this.date,
    required this.kioskReceipt,
    required this.recordID,
    required this.storn,
    this.attrRecord,
    this.check
  });

  factory ConfirmPayRecordResponse.fromJson(Map<String, dynamic> json) => _$ConfirmPayRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPayRecordResponseToJson(this);
  
}

@JsonSerializable()
class ConfirmAttrRecordResponse {

  @JsonKey(name: '@Code')
  final int code;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Value')
  final String? value;

  ConfirmAttrRecordResponse({
    required this.code,
    this.codeOut,
    required this.name,
    this.value
  });

  factory ConfirmAttrRecordResponse.fromJson(Map<String, dynamic> json) => _$ConfirmAttrRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAttrRecordResponseToJson(this);
  
}

@JsonSerializable()
class ConfirmCheckResponse {

  @JsonKey(name: 'CheckFooter')
  final CheckFooterItem? checkFooter;

  ConfirmCheckResponse({
    this.checkFooter,
  });

  factory ConfirmCheckResponse.fromJson(Map<String, dynamic> json) => _$ConfirmCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmCheckResponseToJson(this);
  
}

@JsonSerializable()
class CheckFooterItem {

  @JsonKey(name: '@Count')
  final int count;

  @JsonKey(name: 'CheckLine')
  final List<CheckLineFooterItem> checkLine;

  CheckFooterItem({
    required this.count,
    required this.checkLine,
  });

  factory CheckFooterItem.fromJson(Map<String, dynamic> json) => _$CheckFooterItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckFooterItemToJson(this);
  
}

@JsonSerializable()
class CheckLineFooterItem {

  @JsonKey(name: '@Idx')
  final int idx;

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@DoubleHeightSymbol')
  final int? doubleHeightSymbol;

  @JsonKey(name: '@DoubleWidthSymbol')
  final int? doubleWidthSymbol;

  @JsonKey(name: '@InverseSymbol')
  final int? inverseSymbol;

  CheckLineFooterItem({
    required this.idx,
    required this.evalue,
    this.doubleHeightSymbol,
    this.doubleWidthSymbol,
    this.inverseSymbol
  });

  factory CheckLineFooterItem.fromJson(Map<String, dynamic> json) => _$CheckLineFooterItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckLineFooterItemToJson(this);
  
}