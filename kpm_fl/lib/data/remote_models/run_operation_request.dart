import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

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
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'Lang')
  final String lang;

  // @JsonKey(name: 'Token')
  // final String? token;

  @JsonKey(name: 'PayDate')
  final String payDate;

  @JsonKey(name: 'KioskReceipt')
  final String kioskReceipt;

  @JsonKey(name: 'PayRecord')
  final List<PayRecordRequest>? payRecord;

  @JsonKey(name: 'PAN')
  final PAN? pan;

  @JsonKey(name: 'TypePAN')
  final TypePAN? typePAN;

  // @JsonKey(name: 'Property')
  // final List<RequestProperty>? properties;

  RunOperationRequest({
    required this.terminalId,
    required this.version,
    required this.lang,
    // required this.token,
    required this.payDate,
    required this.kioskReceipt,
    required this.payRecord,
    this.pan,
    this.typePAN,
    //this.properties
  });

  factory RunOperationRequest.fromJson(Map<String, dynamic> json) => _$RunOperationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RunOperationRequestToJson(this);
  
}
