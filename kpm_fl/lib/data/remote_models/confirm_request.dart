import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'confirm_request.g.dart';

@JsonSerializable()
class PsEripConfirmRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripConfirmRequest psErip;

  const PsEripConfirmRequestWrapper(this.psErip);

  factory PsEripConfirmRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripConfirmRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripConfirmRequest {

  @JsonKey(name: 'ConfirmRequest')
  final ConfirmRequest request;

  const PsEripConfirmRequest(this.request);

  factory PsEripConfirmRequest.fromJson(Map<String, dynamic> json) => _$PsEripConfirmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmRequestToJson(this);
  
}

@JsonSerializable()
class ConfirmRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'PAN')
  final PAN? pan;

  @JsonKey(name: 'TypePAN')
  final TypePAN? typePan;

  @JsonKey(name: 'PayRecord')
  final List<ConfirmRequestPayRecord>? payRecord;

  const ConfirmRequest({
    required this.terminalId,
    required this.version,
    this.pan,
    this.typePan,
    this.payRecord,
  });

  factory ConfirmRequest.fromJson(Map<String, dynamic> json) => _$ConfirmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmRequestToJson(this);
  
}

@JsonSerializable()
class ConfirmRequestPayRecord {

  @JsonKey(name: '@PaymentID')
  final int? paymentID;

  @JsonKey(name: '@Date')
  final String? date;

  @JsonKey(name: '@KioskReceipt')
  final String? kioskReceipt;

  @JsonKey(name: '@RecordID')
  final int? recordId;

  // 0 - for dismiss
  // 1 - for accept, only when paymentID not null
  @JsonKey(name: '@ConfirmCode')
  final int confirmCode;

  @JsonKey(name: '@CancelReason')
  final String? cancelReason;

  const ConfirmRequestPayRecord({
    this.paymentID,
    this.date,
    this.kioskReceipt,
    this.recordId,
    required this.confirmCode,
    this.cancelReason,
  });

  factory ConfirmRequestPayRecord.fromJson(Map<String, dynamic> json) => _$ConfirmRequestPayRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmRequestPayRecordToJson(this);

}
