// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mdom_tpinfo_base_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpInfoErrorCode _$MdomTpInfoErrorCodeFromJson(Map<String, dynamic> json) =>
    MdomTpInfoErrorCode(
      evalue: json['evalue'] as int?,
      errorText: json['@ErrorText'] as String?,
    );

Map<String, dynamic> _$MdomTpInfoErrorCodeToJson(
        MdomTpInfoErrorCode instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@ErrorText': instance.errorText,
    };

MdomTpInfoRequestParams _$MdomTpInfoRequestParamsFromJson(
        Map<String, dynamic> json) =>
    MdomTpInfoRequestParams(
      params: (json['Param'] as List<dynamic>?)
          ?.map(
              (e) => MdomTpInfoRequestParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomTpInfoRequestParamsToJson(
        MdomTpInfoRequestParams instance) =>
    <String, dynamic>{
      'Param': instance.params,
    };

MdomTpInfoRequestParam _$MdomTpInfoRequestParamFromJson(
        Map<String, dynamic> json) =>
    MdomTpInfoRequestParam(
      evalue: json['evalue'] as String,
      name: json['@Name'] as String,
      id: json['@Id'] as int,
      idParent: json['@IdParent'] as int?,
    );

Map<String, dynamic> _$MdomTpInfoRequestParamToJson(
        MdomTpInfoRequestParam instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Name': instance.name,
      '@Id': instance.id,
      '@IdParent': instance.idParent,
    };

MdomTpInfoResponseParams _$MdomTpInfoResponseParamsFromJson(
        Map<String, dynamic> json) =>
    MdomTpInfoResponseParams(
      params: (json['Param'] as List<dynamic>?)
          ?.map((e) =>
              MdomTpInfoResponseParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomTpInfoResponseParamsToJson(
        MdomTpInfoResponseParams instance) =>
    <String, dynamic>{
      'Param': instance.params,
    };

MdomObjectParam _$MdomObjectParamFromJson(Map<String, dynamic> json) =>
    MdomObjectParam(
      params: (json['Param'] as List<dynamic>?)
          ?.map((e) =>
              MdomTpInfoResponseParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomObjectParamToJson(MdomObjectParam instance) =>
    <String, dynamic>{
      'Param': instance.params,
    };

MdomTpInfoResponseParam _$MdomTpInfoResponseParamFromJson(
        Map<String, dynamic> json) =>
    MdomTpInfoResponseParam(
      evalue: json['evalue'] as String?,
      name: json['@Name'] as String?,
      type: json['@Type'] as int?,
      typeC: json['@TypeC'] as int?,
      id: json['@Id'] as int?,
      idParent: json['@IdParent'] as int?,
      mandatory: json['@Mandatory'] as int?,
      edit: json['@Edit'] as int?,
      view: json['@View'] as int?,
      minLength: json['@MinLength'] as int?,
      maxLength: json['@MaxLength'] as int?,
      format: json['@Format'] as String?,
      hint: json['@Hint'] as String?,
      lookup: json['@Lookup'] as String?,
      alias: json['@Alias'] as String?,
      supplierUNN: json['@SupplierUNN'] as String?,
      supplierID: json['@SupplierID'] as int?,
      keyRegistration: json['@KeyRegistration'] as String?,
      supplierShortName: json['@SupplierShortName'] as String?,
      supplierName: json['@SupplierName'] as String?,
      lName: json['@LName'] as String?,
      managerPost: json['@ManagerPost'] as String?,
      email: json['@Email'] as String?,
      managerName: json['@ManagerName'] as String?,
      bookkeperName: json['@BookkeperName'] as String?,
      managerPhone: json['@ManagerPhone'] as String?,
      supplierDomicile: json['@SupplierDomicile'] as String?,
      schemeNameBilling: json['@SchemeNameBilling'] as String?,
    );

Map<String, dynamic> _$MdomTpInfoResponseParamToJson(
        MdomTpInfoResponseParam instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Name': instance.name,
      '@Type': instance.type,
      '@TypeC': instance.typeC,
      '@Id': instance.id,
      '@IdParent': instance.idParent,
      '@Mandatory': instance.mandatory,
      '@Edit': instance.edit,
      '@View': instance.view,
      '@MinLength': instance.minLength,
      '@MaxLength': instance.maxLength,
      '@Format': instance.format,
      '@Hint': instance.hint,
      '@Lookup': instance.lookup,
      '@Alias': instance.alias,
      '@SupplierUNN': instance.supplierUNN,
      '@SupplierID': instance.supplierID,
      '@KeyRegistration': instance.keyRegistration,
      '@SupplierShortName': instance.supplierShortName,
      '@SupplierName': instance.supplierName,
      '@LName': instance.lName,
      '@ManagerPost': instance.managerPost,
      '@Email': instance.email,
      '@ManagerName': instance.managerName,
      '@BookkeperName': instance.bookkeperName,
      '@ManagerPhone': instance.managerPhone,
      '@SupplierDomicile': instance.supplierDomicile,
      '@SchemeNameBilling': instance.schemeNameBilling,
    };

MdomTpInfoLookups _$MdomTpInfoLookupsFromJson(Map<String, dynamic> json) =>
    MdomTpInfoLookups(
      lookups: (json['Lookup'] as List<dynamic>?)
          ?.map((e) => MdomTpInfoLookup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomTpInfoLookupsToJson(MdomTpInfoLookups instance) =>
    <String, dynamic>{
      'Lookup': instance.lookups,
    };

MdomTpInfoLookup _$MdomTpInfoLookupFromJson(Map<String, dynamic> json) =>
    MdomTpInfoLookup(
      name: json['@Name'] as String,
      items: (json['Item'] as List<dynamic>)
          .map((e) => MdomTpInfoLookupItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomTpInfoLookupToJson(MdomTpInfoLookup instance) =>
    <String, dynamic>{
      '@Name': instance.name,
      'Item': instance.items,
    };

MdomTpInfoLookupItem _$MdomTpInfoLookupItemFromJson(
        Map<String, dynamic> json) =>
    MdomTpInfoLookupItem(
      evalue: json['evalue'] as String,
      name: json['@Name'] as String,
    );

Map<String, dynamic> _$MdomTpInfoLookupItemToJson(
        MdomTpInfoLookupItem instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Name': instance.name,
    };
