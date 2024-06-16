import 'package:json_annotation/json_annotation.dart';

part 'supplier_status_response.g.dart';

@JsonSerializable()
class PsTpOSupplierStatusResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOSupplierStatusResponse psTpO;

  PsTpOSupplierStatusResponseWrapper(this.psTpO);

  factory PsTpOSupplierStatusResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOSupplierStatusResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOSupplierStatusResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpOSupplierStatusResponse {

  @JsonKey(name: 'SupplierStatusResponse')
  final SupplierStatusResponse response;

  PsTpOSupplierStatusResponse(this.response);

  factory PsTpOSupplierStatusResponse.fromJson(Map<String, dynamic> json) => _$PsTpOSupplierStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOSupplierStatusResponseToJson(this);
}

@JsonSerializable()
class SupplierStatusResponse {

  @JsonKey(name: 'EripStatus')
  final int eripStatus;

  @JsonKey(name: 'TestModeStatus')
  final int testModeStatus;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  SupplierStatusResponse({
    required this.eripStatus,
    required this.testModeStatus,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory SupplierStatusResponse.fromJson(Map<String, dynamic> json) => _$SupplierStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierStatusResponseToJson(this);
  
}
