// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomCompaniesResponseWrapper _$MdomCompaniesResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomCompaniesResponseWrapper(
      MdomCompaniesResponse.fromJson(
          json['TPInfoResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomCompaniesResponseWrapperToJson(
        MdomCompaniesResponseWrapper instance) =>
    <String, dynamic>{
      'TPInfoResponse': instance.response,
    };

MdomCompaniesResponse _$MdomCompaniesResponseFromJson(
        Map<String, dynamic> json) =>
    MdomCompaniesResponse(
      requestType: json['RequestType'] as String?,
      errorCode: json['ErrorCode'] == null
          ? null
          : MdomTpInfoErrorCode.fromJson(
              json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] as String,
      params: json['Params'] == null
          ? null
          : MdomTpInfoResponseParams.fromJson(
              json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomTpInfoLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
      companies: (json['Company'] as List<dynamic>?)
          ?.map((e) =>
              CompaniesResponseCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomCompaniesResponseToJson(
        MdomCompaniesResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
      'Params': instance.params,
      'Lookups': instance.lookups,
      'Company': instance.companies,
    };

CompaniesResponseCompany _$CompaniesResponseCompanyFromJson(
        Map<String, dynamic> json) =>
    CompaniesResponseCompany(
      supplierId: json['SupplierId'] as int,
      params: json['Params'] == null
          ? null
          : MdomTpInfoResponseParams.fromJson(
              json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomTpInfoLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
      propertyAccount: (json['PropertyAccount'] as List<dynamic>?)
          ?.map((e) => PropertyAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompaniesResponseCompanyToJson(
        CompaniesResponseCompany instance) =>
    <String, dynamic>{
      'SupplierId': instance.supplierId,
      'Params': instance.params,
      'Lookups': instance.lookups,
      'PropertyAccount': instance.propertyAccount,
    };

PropertyAccount _$PropertyAccountFromJson(Map<String, dynamic> json) =>
    PropertyAccount(
      account: json['Account'] == null
          ? null
          : PropertyAccountAccount.fromJson(
              json['Account'] as Map<String, dynamic>),
      params: json['Params'] == null
          ? null
          : MdomTpInfoResponseParams.fromJson(
              json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomTpInfoLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PropertyAccountToJson(PropertyAccount instance) =>
    <String, dynamic>{
      'Account': instance.account,
      'Params': instance.params,
      'Lookups': instance.lookups,
    };

PropertyAccountAccount _$PropertyAccountAccountFromJson(
        Map<String, dynamic> json) =>
    PropertyAccountAccount(
      evalue: json['evalue'] as String,
      isConfirmed: json['@isConfirmed'] as int,
    );

Map<String, dynamic> _$PropertyAccountAccountToJson(
        PropertyAccountAccount instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@isConfirmed': instance.isConfirmed,
    };
