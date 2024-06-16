import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'run_operation_response.g.dart';

@JsonSerializable()
class PsEripRunOperationResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripRunOperationResponse psErip;

  PsEripRunOperationResponseWrapper(this.psErip);

  factory PsEripRunOperationResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripRunOperationResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripRunOperationResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripRunOperationResponse {

  @JsonKey(name: 'RunOperationResponse')
  final RunOperationResponse response;

  PsEripRunOperationResponse(this.response);

  factory PsEripRunOperationResponse.fromJson(Map<String, dynamic> json) => _$PsEripRunOperationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripRunOperationResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RunOperationResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'KioskReceipt')
  final String? kioskReceipt;

  @JsonKey(name: 'PayRecord')
  final List<PayRecordResponse>? payRecord;

  RunOperationResponse({
    this.errorCode,
    this.errorText,
    this.kioskReceipt,
    this.payRecord
  });

  factory RunOperationResponse.fromJson(Map<String, dynamic> json) => _$RunOperationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RunOperationResponseToJson(this);
  
}