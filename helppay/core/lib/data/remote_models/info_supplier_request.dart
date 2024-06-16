import 'package:json_annotation/json_annotation.dart';

part 'info_supplier_request.g.dart';

@JsonSerializable()
class MdomInfoSupplierRequestWrapper {

  @JsonKey(name: 'TPInfoRequest')
  final MdomInfoSupplierRequest request;

  MdomInfoSupplierRequestWrapper(this.request);

  factory MdomInfoSupplierRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomInfoSupplierRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomInfoSupplierRequestWrapperToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class MdomInfoSupplierRequest {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'Filter')
  final Filter filter;


  MdomInfoSupplierRequest({
    this.requestType = 'InfoSupplier',
    required this.terminalId,
    required this.version,
    required this.token,
    this.lang,
    // ignore: always_put_required_named_parameters_first
    required this.filter,
  });

  factory MdomInfoSupplierRequest.fromJson(Map<String, dynamic> json) => _$MdomInfoSupplierRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomInfoSupplierRequestToJson(this);

}

@JsonSerializable(includeIfNull: false)
class Filter {

  @JsonKey(name: '@SupplierUNN')
  final int? supplierUNN;

  @JsonKey(name: '@SupplierName')
  final String? supplierName;

  Filter(
      {required this.supplierUNN, required this.supplierName});

  factory Filter.fromJson(Map<String, dynamic> json) =>
      _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}


