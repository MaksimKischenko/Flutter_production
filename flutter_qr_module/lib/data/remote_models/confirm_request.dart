import 'package:json_annotation/json_annotation.dart';

part 'confirm_request.g.dart';

@JsonSerializable()
class PsEripConfirmRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripConfirmRequest psErip;

  PsEripConfirmRequestWrapper(this.psErip);

  factory PsEripConfirmRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripConfirmRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripConfirmRequest {

  @JsonKey(name: 'ConfirmRequest')
  final ConfirmRequest request;

  PsEripConfirmRequest(this.request);

  factory PsEripConfirmRequest.fromJson(Map<String, dynamic> json) => _$PsEripConfirmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripConfirmRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class ConfirmRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalID;

  @JsonKey(name: 'DIType')
  final int diType;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'PayRecord')
  final ConfirmRequestPayRecord payRecord;

  ConfirmRequest({
    required this.terminalID,
    required this.version,
    required this.diType,
    required this.payRecord});

  factory ConfirmRequest.fromJson(Map<String, dynamic> json) => _$ConfirmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmRequestToJson(this);
  
}

@JsonSerializable()
class ConfirmRequestPayRecord {

  @JsonKey(name: '@PaymentID')
  final int paymentID;

  @JsonKey(name: '@Date')
  final String date;

  @JsonKey(name: '@RecordID')
  final int recordID;

  /// 0 - for dismiss.
  /// 1 - for accept, only when paymentID not null.
  @JsonKey(name: '@ConfirmCode')
  final int confirmCode;

  @JsonKey(name: '@CancelReason')
  final String? cancelReason;

  ConfirmRequestPayRecord({
    required this.paymentID,
    required this.date,
    required this.recordID,
    required this.confirmCode,
    this.cancelReason
  });

  factory ConfirmRequestPayRecord.fromJson(Map<String, dynamic> json) => _$ConfirmRequestPayRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmRequestPayRecordToJson(this);
  
}