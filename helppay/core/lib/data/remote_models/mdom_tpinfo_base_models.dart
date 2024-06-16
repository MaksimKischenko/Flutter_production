import 'package:json_annotation/json_annotation.dart';

part 'mdom_tpinfo_base_models.g.dart';

@JsonSerializable()
class MdomTpInfoErrorCode {

  @JsonKey(name: 'evalue')
  final int? evalue;

  @JsonKey(name: '@ErrorText')
  final String? errorText;

  const MdomTpInfoErrorCode({
    required this.evalue,
    this.errorText
  });

  factory MdomTpInfoErrorCode.fromJson(Map<String, dynamic> json) => _$MdomTpInfoErrorCodeFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoErrorCodeToJson(this);
  
}

@JsonSerializable()
class MdomTpInfoRequestParams {

  @JsonKey(name: 'Param')
  final List<MdomTpInfoRequestParam>? params;

  MdomTpInfoRequestParams({
    this.params
  });

  factory MdomTpInfoRequestParams.fromJson(Map<String, dynamic> json) => _$MdomTpInfoRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoRequestParamsToJson(this);
  
}

@JsonSerializable()
class MdomTpInfoRequestParam {

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Id')
  final int id;

  @JsonKey(name: '@IdParent')
  final int? idParent;

  MdomTpInfoRequestParam({
    required this.evalue,
    required this.name,
    required this.id,
    this.idParent,
  });

  factory MdomTpInfoRequestParam.fromJson(Map<String, dynamic> json) => _$MdomTpInfoRequestParamFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoRequestParamToJson(this);
  
}

@JsonSerializable()
class MdomTpInfoResponseParams {

  @JsonKey(name: 'Param')
  final List<MdomTpInfoResponseParam>? params;

  MdomTpInfoResponseParams({
    this.params
  });

  factory MdomTpInfoResponseParams.fromJson(Map<String, dynamic> json) => _$MdomTpInfoResponseParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoResponseParamsToJson(this);
  
}
@JsonSerializable()
class MdomObjectParam {

  @JsonKey(name: 'Param')
  final List<MdomTpInfoResponseParam>? params;

  MdomObjectParam({
    required this.params,
  });

  factory MdomObjectParam.fromJson(Map<String, dynamic> json) => _$MdomObjectParamFromJson(json);

  Map<String, dynamic> toJson() => _$MdomObjectParamToJson(this);
}

@JsonSerializable()
class MdomTpInfoResponseParam {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@Type')
  final int? type;

  @JsonKey(name: '@TypeC')
  final int? typeC;

  @JsonKey(name: '@Id')
  final int? id;

  @JsonKey(name: '@IdParent')
  final int? idParent;

  @JsonKey(name: '@Mandatory')
  final int? mandatory;

  @JsonKey(name: '@Edit')
  final int? edit;

  @JsonKey(name: '@View')
  final int? view;

  @JsonKey(name: '@MinLength')
  final int? minLength;

  @JsonKey(name: '@MaxLength')
  final int? maxLength;

  @JsonKey(name: '@Format')
  final String? format;

  @JsonKey(name: '@Hint')
  final String? hint;

  @JsonKey(name: '@Lookup')
  final String? lookup;

  @JsonKey(name: '@Alias')
  final String? alias;

  @JsonKey(name: '@SupplierUNN')
  final String? supplierUNN;

  @JsonKey(name: '@SupplierID')
  final int? supplierID;

  @JsonKey(name: '@KeyRegistration')
  final String? keyRegistration;

  @JsonKey(name: '@SupplierShortName')
  final String? supplierShortName;

  @JsonKey(name: '@SupplierName')
  final String? supplierName;

  @JsonKey(name: '@LName')
  final String? lName;

  @JsonKey(name: '@ManagerPost')
  final String? managerPost;

  @JsonKey(name: '@Email')
  final String? email;

  @JsonKey(name: '@ManagerName')
  final String? managerName;

  @JsonKey(name: '@BookkeperName')
  final String? bookkeperName;
  
  @JsonKey(name: '@ManagerPhone')
  final String? managerPhone;

  @JsonKey(name: '@SupplierDomicile')
  final String? supplierDomicile;

  @JsonKey(name: '@SchemeNameBilling')
  final String? schemeNameBilling;

  
  MdomTpInfoResponseParam({
    this.evalue,
    this.name,
    this.type,
    this.typeC,
    this.id,
    this.idParent,
    this.mandatory,
    this.edit,
    this.view,
    this.minLength,
    this.maxLength,
    this.format,
    this.hint,
    this.lookup,
    this.alias,
    this.supplierUNN,
    this.supplierID,
    this.keyRegistration,
    this.supplierShortName,
    this.supplierName,
    this.lName,
    this.managerPost,
    this.email,
    this.managerName,
    this.bookkeperName,
    this.managerPhone,
    this.supplierDomicile,
    this.schemeNameBilling,
  });


  factory MdomTpInfoResponseParam.fromJson(Map<String, dynamic> json) => _$MdomTpInfoResponseParamFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoResponseParamToJson(this);
  
}

@JsonSerializable()
class MdomTpInfoLookups {

  @JsonKey(name: 'Lookup')
  final List<MdomTpInfoLookup>? lookups;

  MdomTpInfoLookups({
    this.lookups,
  });

  factory MdomTpInfoLookups.fromJson(Map<String, dynamic> json) => _$MdomTpInfoLookupsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoLookupsToJson(this);
  
}

@JsonSerializable()
class MdomTpInfoLookup {

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: 'Item')
  final List<MdomTpInfoLookupItem> items;

  MdomTpInfoLookup({
    required this.name,
    required this.items,
  });

  factory MdomTpInfoLookup.fromJson(Map<String, dynamic> json) => _$MdomTpInfoLookupFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoLookupToJson(this);
  
}

@JsonSerializable()
class MdomTpInfoLookupItem {

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Name')
  final String name;

  MdomTpInfoLookupItem({
    required this.evalue,
    required this.name,
  });

  factory MdomTpInfoLookupItem.fromJson(Map<String, dynamic> json) => _$MdomTpInfoLookupItemFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpInfoLookupItemToJson(this);
  
}
