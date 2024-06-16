// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartx/dartx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mdom_base_models.g.dart';

@JsonSerializable()
class MdomErrorCode {
  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@ErrorText')
  final String? errorText;

  const MdomErrorCode({required this.evalue, this.errorText});

  factory MdomErrorCode.fromJson(Map<String, dynamic> json) =>
      _$MdomErrorCodeFromJson(json);

  Map<String, dynamic> toJson() => _$MdomErrorCodeToJson(this);
}

@JsonSerializable()
class MdomToken {
  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@TerminalId')
  final String? terminalId;

  @JsonKey(name: '@Version')
  final String? version;

  @JsonKey(name: '@NeedConfirmRegistration')
  final int? needConfirmRegistration;

  const MdomToken(
      {required this.evalue,
      this.terminalId,
      this.version,
      this.needConfirmRegistration});

  factory MdomToken.fromJson(Map<String, dynamic> json) =>
      _$MdomTokenFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTokenToJson(this);
}

@JsonSerializable()
class MdomLogin {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Name')
  final String fio;

  @JsonKey(name: '@Password')
  final String password;

  @JsonKey(name: '@DeviceType')
  final String deviceType;

  MdomLogin(
      {required this.evalue,
      required this.fio,
      required this.password,
      this.deviceType = 'MB'});

  factory MdomLogin.fromJson(Map<String, dynamic> json) =>
      _$MdomLoginFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MdomTokenRecord {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@SendCode')
  final int sendCode;

  @JsonKey(name: '@TerminalId')
  final String terminalId;

  MdomTokenRecord(
      {required this.evalue, required this.sendCode, required this.terminalId});

  factory MdomTokenRecord.fromJson(Map<String, dynamic> json) =>
      _$MdomTokenRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTokenRecordToJson(this);
}

@JsonSerializable()
class MdomLookups {
  @JsonKey(name: 'Lookup')
  final List<MdomLookup> lookups;

  MdomLookups({
    required this.lookups,
  });

  factory MdomLookups.fromJson(Map<String, dynamic> json) =>
      _$MdomLookupsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLookupsToJson(this);
}

@JsonSerializable()
class MdomLookup {
  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: 'Item')
  final List<MdomLookupItem>? items;

  MdomLookup({required this.name, this.items});

  factory MdomLookup.fromJson(Map<String, dynamic> json) =>
      _$MdomLookupFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLookupToJson(this);
}

@JsonSerializable()
class MdomLookupItem {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Name')
  final String? name;

  MdomLookupItem({required this.evalue, this.name});

  factory MdomLookupItem.fromJson(Map<String, dynamic> json) =>
      _$MdomLookupItemFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLookupItemToJson(this);
}

@JsonSerializable()
class MdomRequestParams {
  @JsonKey(name: 'Param')
  final List<MdomRequestParam> params;

  MdomRequestParams({
    required this.params,
  });

  factory MdomRequestParams.fromJson(Map<String, dynamic> json) =>
      _$MdomRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomRequestParamsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MdomRequestParam {
  @JsonKey(name: 'evalue')
  String? evalue;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Id')
  final int id;

  @JsonKey(name: '@IdParent')
  final int? idParent;

  @JsonKey(name: '@Alias')
  final String? alias;

  MdomRequestParam(
      {required this.evalue,
      required this.name,
      required this.id,
      this.idParent,
      this.alias});

  factory MdomRequestParam.fromJson(Map<String, dynamic> json) =>
      _$MdomRequestParamFromJson(json);

  Map<String, dynamic> toJson() => _$MdomRequestParamToJson(this);
}

@JsonSerializable()
class MdomResponseParams {
  @JsonKey(name: 'Param')
  final List<MdomResponseParam> params;

  const MdomResponseParams({
    required this.params,
  });

  factory MdomResponseParams.clone(MdomResponseParams cloneParams) => MdomResponseParams(params: cloneParams.params);

  factory MdomResponseParams.fromJson(Map<String, dynamic> json) =>
      _$MdomResponseParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomResponseParamsToJson(this);

  MdomResponseParam? findByAlias(String alias) =>
      params.firstOrNullWhere((param) => param.alias == alias);
      
  @override
  String toString() => 'MdomResponseParams(params: $params)';

  void changeListParametrByAlias(String alias, String newValue) {
   final index = params.indexOf(params.firstOrNullWhere((param) => param.alias == alias)!); 
   params[index] = findByAlias(alias)!.copyWith(evalue: newValue);
  }

  MdomResponseParams copyWith({
    List<MdomResponseParam>? params,
  }) => MdomResponseParams(
      params: params ?? this.params,
    );
  
}

@JsonSerializable()
class MdomResponseParam {
  @JsonKey(name: 'evalue')
  String? evalue;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Type')
  final int type;

  @JsonKey(name: '@TypeC')
  final int? typeC;

  @JsonKey(name: '@Id')
  final int id;

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

  MdomResponseParam({
    this.evalue,
    required this.name,
    required this.type,
    this.typeC,
    required this.id,
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
  });

  factory MdomResponseParam.fromJson(Map<String, dynamic> json) =>
      _$MdomResponseParamFromJson(json);

  Map<String, dynamic> toJson() => _$MdomResponseParamToJson(this);

  @override
  String toString() =>
      'MdomResponseParam(evalue: $evalue, name: $name, type: $type, typeC: $typeC, id: $id, idParent: $idParent, mandatory: $mandatory, edit: $edit, view: $view, minLength: $minLength, maxLength: $maxLength, format: $format, hint: $hint, lookup: $lookup, alias: $alias)';

  MdomResponseParam copyWith({
    String? evalue,
    String? name,
    int? type,
    int? typeC,
    int? id,
    int? idParent,
    int? mandatory,
    int? edit,
    int? view,
    int? minLength,
    int? maxLength,
    String? format,
    String? hint,
    String? lookup,
    String? alias,
  }) => MdomResponseParam(
      evalue: evalue ?? this.evalue,
      name: name ?? this.name,
      type: type ?? this.type,
      typeC: typeC ?? this.typeC,
      id: id ?? this.id,
      idParent: idParent ?? this.idParent,
      mandatory: mandatory ?? this.mandatory,
      edit: edit ?? this.edit,
      view: view ?? this.view,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      format: format ?? this.format,
      hint: hint ?? this.hint,
      lookup: lookup ?? this.lookup,
      alias: alias ?? this.alias,
    );
}
