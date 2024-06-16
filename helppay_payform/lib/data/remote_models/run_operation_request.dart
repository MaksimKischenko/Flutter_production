import 'package:json_annotation/json_annotation.dart';
import 'komplat_general_elements.dart';

part 'run_operation_request.g.dart';

@JsonSerializable(includeIfNull: false)
class RunOperationRequest {

  @JsonKey(name: 'PayDate')
  final String payDate;

  @JsonKey(name: 'KioskReceipt')
  final String kioskReceipt;

  @JsonKey(name: 'PayRecord')
  final PayRecordRequest? payRecord;

  @JsonKey(name: 'PAN')
  final PAN? pan;

  @JsonKey(name: 'TypePAN')
  final TypePAN? typePAN;

  @JsonKey(name: 'Property')
  final List<RequestProperty>? properties;

  RunOperationRequest({
    required this.payDate,
    required this.kioskReceipt,
    required this.payRecord,
    this.pan,
    this.typePAN,
    this.properties
  });

  factory RunOperationRequest.fromJson(Map<String, dynamic> json) => _$RunOperationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RunOperationRequestToJson(this);
  
}