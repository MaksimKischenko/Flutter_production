import 'package:helppay_core/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'companies_response.g.dart';

@JsonSerializable()
class MdomCompaniesResponseWrapper {

  @JsonKey(name: 'TPInfoResponse')
  final MdomCompaniesResponse response;

  MdomCompaniesResponseWrapper(this.response);

  factory MdomCompaniesResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomCompaniesResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCompaniesResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomCompaniesResponse {

  @JsonKey(name: 'RequestType')
  final String? requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomTpInfoErrorCode? errorCode;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Params')
  final MdomTpInfoResponseParams? params;

  @JsonKey(name: 'Lookups')
  final MdomTpInfoLookups? lookups;

  @JsonKey(name: 'Company')
  final List<CompaniesResponseCompany>? companies;

  const MdomCompaniesResponse({
    this.requestType,
    this.errorCode,
    required this.token,
    this.params,
    this.lookups,
    this.companies
  });

  factory MdomCompaniesResponse.fromJson(Map<String, dynamic> json) => _$MdomCompaniesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCompaniesResponseToJson(this);
  
}

@JsonSerializable()
class CompaniesResponseCompany {

  @JsonKey(name: 'SupplierId')
  final int supplierId;

  @JsonKey(name: 'Params')
  final MdomTpInfoResponseParams? params;

  @JsonKey(name: 'Lookups')
  final MdomTpInfoLookups? lookups;

  @JsonKey(name: 'PropertyAccount')
  final List<PropertyAccount>? propertyAccount;

  CompaniesResponseCompany({
    required this.supplierId,
    this.params,
    this.lookups,
    this.propertyAccount,
  });

  String get name {
    final index = params?.params?.indexWhere((param) => param.alias == 'SUPPLIERNAME') ?? -1;
    if (index == -1) {
      return 'Компания';
    } else {
      return params!.params![index].evalue ?? 'Компания';
    }
  }

  factory CompaniesResponseCompany.fromJson(Map<String, dynamic> json) => _$CompaniesResponseCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompaniesResponseCompanyToJson(this);
  
}

@JsonSerializable()
class PropertyAccount {

  @JsonKey(name: 'Account')
  final PropertyAccountAccount? account;

  @JsonKey(name: 'Params')
  final MdomTpInfoResponseParams? params;

  @JsonKey(name: 'Lookups')
  final MdomTpInfoLookups? lookups;
  
  PropertyAccount({
    this.account,
    this.params,
    this.lookups
  });

  factory PropertyAccount.fromJson(Map<String, dynamic> json) => _$PropertyAccountFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyAccountToJson(this);
  
}

@JsonSerializable()
class PropertyAccountAccount {

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@isConfirmed')
  final int isConfirmed;
  
  PropertyAccountAccount({
    required this.evalue,
    required this.isConfirmed,
  });

  factory PropertyAccountAccount.fromJson(Map<String, dynamic> json) => _$PropertyAccountAccountFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyAccountAccountToJson(this);
  
}