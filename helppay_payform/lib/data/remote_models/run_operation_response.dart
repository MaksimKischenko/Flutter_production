import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'run_operation_response.g.dart';

@JsonSerializable(includeIfNull: false)
class RunOperationResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'KioskReceipt')
  final String? kioskReceipt;

  @JsonKey(name: 'PayRecord')
  final PayRecordResponse? payRecord;

  RunOperationResponse({
    this.errorCode,
    this.errorText,
    this.kioskReceipt,
    this.payRecord
  });

  factory RunOperationResponse.fromJson(Map<String, dynamic> json) => _$RunOperationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RunOperationResponseToJson(this);
  
}