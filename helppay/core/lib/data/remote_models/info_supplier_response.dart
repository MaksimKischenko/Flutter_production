import 'package:helppay_core/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info_supplier_response.g.dart';

@JsonSerializable()
class MdomInfoSupplierResponseWrapper {

  @JsonKey(name: 'TPInfoResponse')
  final MdomInfoSupplierResponse response;

  MdomInfoSupplierResponseWrapper(this.response);

  factory MdomInfoSupplierResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomInfoSupplierResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomInfoSupplierResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomInfoSupplierResponse {

  @JsonKey(name: 'RequestType')
  final String? requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomTpInfoErrorCode? errorCode;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Company')
  final List<InfoSupplierResponseCompany>? companies;

  const MdomInfoSupplierResponse({
    this.requestType = 'InfoSupplier',
    this.errorCode,
    required this.token,
    this.companies
  });

  factory MdomInfoSupplierResponse.fromJson(Map<String, dynamic> json) => _$MdomInfoSupplierResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomInfoSupplierResponseToJson(this);
  
}

@JsonSerializable()
class InfoSupplierResponseCompany {

  @JsonKey(name: 'SupplierId')
  final int? supplierId;

  @JsonKey(name: 'Params')
  final MdomObjectParam? objectParam;

  InfoSupplierResponseCompany({
    this.supplierId,
    required this.objectParam,
  });


  factory InfoSupplierResponseCompany.fromJson(Map<String, dynamic> json) => _$InfoSupplierResponseCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$InfoSupplierResponseCompanyToJson(this);
  
}
