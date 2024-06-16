// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mdom_base_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomErrorCode _$MdomErrorCodeFromJson(Map<String, dynamic> json) =>
    MdomErrorCode(
      evalue: json['evalue'] as int,
      errorText: json['@ErrorText'] as String?,
    );

Map<String, dynamic> _$MdomErrorCodeToJson(MdomErrorCode instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@ErrorText': instance.errorText,
    };

MdomToken _$MdomTokenFromJson(Map<String, dynamic> json) => MdomToken(
      evalue: json['evalue'] as String?,
      terminalId: json['@TerminalId'] as String?,
      version: json['@Version'] as String?,
      needConfirmRegistration: json['@NeedConfirmRegistration'] as int?,
    );

Map<String, dynamic> _$MdomTokenToJson(MdomToken instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@TerminalId': instance.terminalId,
      '@Version': instance.version,
      '@NeedConfirmRegistration': instance.needConfirmRegistration,
    };

MdomLogin _$MdomLoginFromJson(Map<String, dynamic> json) => MdomLogin(
      evalue: json['evalue'] as String,
      fio: json['@Name'] as String,
      password: json['@Password'] as String,
      deviceType: json['@DeviceType'] as String? ?? 'MB',
    );

Map<String, dynamic> _$MdomLoginToJson(MdomLogin instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@Name': instance.fio,
      '@Password': instance.password,
      '@DeviceType': instance.deviceType,
    };

MdomTokenRecord _$MdomTokenRecordFromJson(Map<String, dynamic> json) =>
    MdomTokenRecord(
      evalue: json['evalue'] as String,
      sendCode: json['@SendCode'] as int,
      terminalId: json['@TerminalId'] as String,
    );

Map<String, dynamic> _$MdomTokenRecordToJson(MdomTokenRecord instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@SendCode': instance.sendCode,
      '@TerminalId': instance.terminalId,
    };

MdomLookups _$MdomLookupsFromJson(Map<String, dynamic> json) => MdomLookups(
      lookups: (json['Lookup'] as List<dynamic>)
          .map((e) => MdomLookup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomLookupsToJson(MdomLookups instance) =>
    <String, dynamic>{
      'Lookup': instance.lookups,
    };

MdomLookup _$MdomLookupFromJson(Map<String, dynamic> json) => MdomLookup(
      name: json['@Name'] as String,
      items: (json['Item'] as List<dynamic>?)
          ?.map((e) => MdomLookupItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomLookupToJson(MdomLookup instance) =>
    <String, dynamic>{
      '@Name': instance.name,
      'Item': instance.items,
    };

MdomLookupItem _$MdomLookupItemFromJson(Map<String, dynamic> json) =>
    MdomLookupItem(
      evalue: json['evalue'] as String,
      name: json['@Name'] as String?,
    );

Map<String, dynamic> _$MdomLookupItemToJson(MdomLookupItem instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Name': instance.name,
    };

MdomRequestParams _$MdomRequestParamsFromJson(Map<String, dynamic> json) =>
    MdomRequestParams(
      params: (json['Param'] as List<dynamic>)
          .map((e) => MdomRequestParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomRequestParamsToJson(MdomRequestParams instance) =>
    <String, dynamic>{
      'Param': instance.params,
    };

MdomRequestParam _$MdomRequestParamFromJson(Map<String, dynamic> json) =>
    MdomRequestParam(
      evalue: json['evalue'] as String?,
      name: json['@Name'] as String,
      id: json['@Id'] as int,
      idParent: json['@IdParent'] as int?,
      alias: json['@Alias'] as String?,
    );

Map<String, dynamic> _$MdomRequestParamToJson(MdomRequestParam instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('evalue', instance.evalue);
  val['@Name'] = instance.name;
  val['@Id'] = instance.id;
  writeNotNull('@IdParent', instance.idParent);
  writeNotNull('@Alias', instance.alias);
  return val;
}

MdomResponseParams _$MdomResponseParamsFromJson(Map<String, dynamic> json) =>
    MdomResponseParams(
      params: (json['Param'] as List<dynamic>)
          .map((e) => MdomResponseParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomResponseParamsToJson(MdomResponseParams instance) =>
    <String, dynamic>{
      'Param': instance.params,
    };

MdomResponseParam _$MdomResponseParamFromJson(Map<String, dynamic> json) =>
    MdomResponseParam(
      evalue: json['evalue'] as String?,
      name: json['@Name'] as String,
      type: json['@Type'] as int,
      typeC: json['@TypeC'] as int?,
      id: json['@Id'] as int,
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
    );

Map<String, dynamic> _$MdomResponseParamToJson(MdomResponseParam instance) =>
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
    };
