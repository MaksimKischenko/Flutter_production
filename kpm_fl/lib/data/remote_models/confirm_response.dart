import 'package:json_annotation/json_annotation.dart';
import 'package:kpm_fl/data/remote_models/komplat_general_elements.dart';

part 'confirm_response.g.dart';

@JsonSerializable()
class PsEripConfirmResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripConfirmResponse psErip;

  const PsEripConfirmResponseWrapper(this.psErip);

  factory PsEripConfirmResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripConfirmResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripConfirmResponse {

  @JsonKey(name: 'ConfirmResponse')
  final ConfirmResponse response;

  const PsEripConfirmResponse(this.response);

  factory PsEripConfirmResponse.fromJson(Map<String, dynamic> json) => _$PsEripConfirmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmResponseToJson(this);
}

@JsonSerializable()
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
  final int? paymentID;

  @JsonKey(name: '@Date')
  final String? date;

  @JsonKey(name: '@KioskReceipt')
  final String? kioskReceipt;

  @JsonKey(name: '@RecordID')
  final int? recordID;

  @JsonKey(name: '@Storn')
  final int? storn;

  @JsonKey(name: '@AttrRecord')
  final ConfirmAttrRecordResponse? attrRecord;

  @JsonKey(name: '@Check')
  final CheckResponse? check;

  

  ConfirmPayRecordResponse({
    this.paymentID,
    this.date,
    this.kioskReceipt,
    this.recordID,
    this.storn,
    this.attrRecord,
    this.check
  });

  factory ConfirmPayRecordResponse.fromJson(Map<String, dynamic> json) => _$ConfirmPayRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPayRecordResponseToJson(this);
  
}

@JsonSerializable()
class ConfirmAttrRecordResponse {

  @JsonKey(name: '@Code')
  final int? code;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@Value')
  final String? value;

  ConfirmAttrRecordResponse({
    this.code,
    this.codeOut,
    this.name,
    this.value
  });

  factory ConfirmAttrRecordResponse.fromJson(Map<String, dynamic> json) => _$ConfirmAttrRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAttrRecordResponseToJson(this);
  
}