import 'package:json_annotation/json_annotation.dart';

part 'supplier_status_request.g.dart';

@JsonSerializable()
class PsTpOSupplierStatusRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOSupplierStatusRequest psTpO;

  PsTpOSupplierStatusRequestWrapper(this.psTpO);

  factory PsTpOSupplierStatusRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOSupplierStatusRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOSupplierStatusRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOSupplierStatusRequest {

  @JsonKey(name: 'SupplierStatusRequest')
  final SupplierStatusRequest request;

  PsTpOSupplierStatusRequest(this.request);

  factory PsTpOSupplierStatusRequest.fromJson(Map<String, dynamic> json) => _$PsTpOSupplierStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOSupplierStatusRequestToJson(this);

}

@JsonSerializable()
class SupplierStatusRequest {

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'KeyRequest')
  final int key;

  SupplierStatusRequest({
    required this.version,
    required this.token,
    required this.key,
  });

  factory SupplierStatusRequest.fromJson(Map<String, dynamic> json) => _$SupplierStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierStatusRequestToJson(this);
  
}
