import 'package:fl_qr_module/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'run_operation_request.g.dart';

@JsonSerializable()
class PsEripRunOperationRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripRunOperationRequest psErip;

  PsEripRunOperationRequestWrapper(this.psErip);

  factory PsEripRunOperationRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripRunOperationRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripRunOperationRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripRunOperationRequest {

  @JsonKey(name: 'RunOperationRequest')
  final RunOperationRequest request;

  PsEripRunOperationRequest(this.request);

  factory PsEripRunOperationRequest.fromJson(Map<String, dynamic> json) => _$PsEripRunOperationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripRunOperationRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class RunOperationRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'DIType')
  final int? diType;

  @JsonKey(name: 'PayRecordCount')
  final int? payRecordCount;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'PayDate')
  final String payDate;

  @JsonKey(name: 'KioskReceipt')
  final int? kioskReceipt;

  @JsonKey(name: 'PayRecord')
  final PayRecordRequest? payRecord;

  @JsonKey(name: 'PAN')
  final Pan? pan;

  @JsonKey(name: 'TypePAN')
  final TypePan? typePan;

  @JsonKey(name: 'Lang')
  final Lang? lang;

  RunOperationRequest({
    required this.terminalID,
    required this.version,
    required this.diType,
    required this.token,
    required this.kioskReceipt,
    required this.payDate,
    this.payRecordCount,
    this.payRecord,
    this.pan,
    this.typePan,
    this.lang
  });

  factory RunOperationRequest.fromJson(Map<String, dynamic> json) => _$RunOperationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RunOperationRequestToJson(this);
  
}

//<PayRecord CodeOut="10004440631" RecordID="1" ClaimID="0" Code="10004440631" Summa="15.00" Currency="933" Fine="0.00" PayCommission="0.00">

@JsonSerializable(includeIfNull: false)
class PayRecordRequest {

  @JsonKey(name: '@Code')
  final int code;

  @JsonKey(name: '@RecordID')
  final String? recordID;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@NameOut')
  final String? nameOut;

  @JsonKey(name: '@Summa')
  final double? summa;

  @JsonKey(name: '@PayCommission')
  final double? payCommission; 

  @JsonKey(name: '@Fine')
  final double? fine;

  @JsonKey(name: '@Currency')
  final double? currency;

  @JsonKey(name: '@SessionId')
  final String? sessionId;

  @JsonKey(name: 'AttrRecord')
  final List<AttrRecordRequest> attrRecord;

  PayRecordRequest({
    required this.code,
    required this.attrRecord,
    this.codeOut,
    this.recordID,
    this.nameOut,
    this.summa,
    this.payCommission,
    this.fine,
    this.currency,
    this.sessionId,
  });

  factory PayRecordRequest.fromJson(Map<String, dynamic> json) => _$PayRecordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayRecordRequestToJson(this);
  
}