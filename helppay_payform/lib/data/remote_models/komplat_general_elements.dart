import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'komplat_general_elements.g.dart';

@JsonSerializable()
class PayRecordResponse extends Equatable {

  @JsonKey(name: '@Code')
  final int? code;

  @JsonKey(name: '@DIType')
  final int? diType;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@RecordType')
  final int? recordType;

  @JsonKey(name: '@StornoMode')
  final String? stornoMode;

  @JsonKey(name: '@Change')
  final int? change;

  @JsonKey(name: '@RecordID')
  final int? recordID;

  @JsonKey(name: '@GetPayListType')
  final int? getPayListType;

  @JsonKey(name: 'Picture')
  final Picture? picture;

  @JsonKey(name: '@PayAll')
  final double? payAll;

  @JsonKey(name: '@Summa')
  final double? summa;

  @JsonKey(name: '@Min')
  final double? min;

  @JsonKey(name: '@Max')
  final double? max;

  @JsonKey(name: '@Nominal')
  final double? nominal;

  @JsonKey(name: '@Edit')
  final int? edit;

  @JsonKey(name: '@View')
  final int? view;

  @JsonKey(name: '@Fine')
  final double? fine;

  @JsonKey(name: '@Currency')
  final int? currency;

  @JsonKey(name: '@PayCommission')
  final double? payCommission;

  @JsonKey(name: '@SessionId')
  final String? sessionId;

  @JsonKey(name: '@PaymentID')
  final int? paymentID;

  @JsonKey(name: '@Date')
  final String? date;

  @JsonKey(name: 'AttrRecord')
  final List<AttrRecordResponse>? attrRecord;

  @JsonKey(name: 'Lookups')
  final Lookups? lookups;

  @JsonKey(name: 'Check')
  final CheckResponse? check;

  @JsonKey(name: 'GroupRecord')
  final GroupRecord? groupRecord;

  @JsonKey(name: 'Claim')
  final List<ResponseClaim>? claims;

  const PayRecordResponse({
    this.code,
    this.diType,
    this.codeOut,
    this.name,
    this.recordType,
    this.stornoMode,
    this.change,
    this.recordID,
    this.getPayListType,
    this.picture,
    this.payAll,
    this.summa,
    this.min,
    this.max,
    this.nominal,
    this.edit,
    this.view,
    this.fine,
    this.currency,
    this.payCommission,
    this.sessionId,
    this.paymentID,
    this.date,
    this.attrRecord,
    this.lookups,
    this.check,
    this.groupRecord,
    this.claims
  });

  AttrRecordResponse? findAttr(int code) {
    final _index = attrRecord?.indexWhere((attr) => attr.code == code) ?? -1;
    return _index > -1 ? (attrRecord?[_index]) : null;
  }

  factory PayRecordResponse.fromJson(Map<String, dynamic> json) => _$PayRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayRecordResponseToJson(this);

  PayRecordResponse copyWith({
    int? code,
    int? codeOut,
    String? name,
    int? recordType,
    String? stornoMode,
    int? change,
    int? recordID,
    int? getPayListType,
    Picture? picture,
    double? payAll,
    double? summa,
    double? min,
    double? max,
    double? nominal,
    int? edit,
    int? view,
    double? fine,
    int? currency,
    double? payCommission,
    String? sessionId,
    int? paymentID,
    String? date,
    List<AttrRecordResponse>? attrRecord,
    Lookups? lookups,
    CheckResponse? check,
    GroupRecord? groupRecord,
    List<ResponseClaim>? claims
  }) => PayRecordResponse(
    code: code ?? this.code,
    codeOut: codeOut ?? this.codeOut,
    name: name ?? this.name,
    recordType: recordType ?? this.recordType,
    stornoMode: stornoMode ?? this.stornoMode,
    change: change ?? this.change,
    recordID: recordID ?? this.recordID,
    getPayListType: getPayListType ?? this.getPayListType,
    picture: picture ?? this.picture,
    payAll: payAll ?? this.payAll,
    summa: summa ?? this.summa,
    min: min ?? this.min,
    max: max ?? this.max,
    nominal: nominal ?? this.nominal,
    edit: edit ?? this.edit,
    view: view ?? this.view,
    fine: fine ?? this.fine,
    currency: currency ?? this.currency,
    payCommission: payCommission ?? this.payCommission,
    sessionId: sessionId ?? this.sessionId,
    paymentID: paymentID ?? this.paymentID,
    date: date ?? this.date,
    attrRecord: attrRecord ?? this.attrRecord,
    lookups: lookups ?? this.lookups,
    check: check ?? this.check,
    groupRecord: groupRecord ?? this.groupRecord,
    claims: claims ?? this.claims
  );

  @override
  List<Object?> get props => [code, codeOut, name, recordType, stornoMode,
  change, recordID, getPayListType, picture, payAll, summa, min, max,
  nominal, edit, view, fine, currency, payCommission, sessionId, paymentID,
  date, attrRecord, lookups, check, groupRecord, claims];

  @override
  String toString() => 'PayRecordResponse ( name = $name, code = $code )';
  
}

@JsonSerializable()
class Picture extends Equatable {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@URL')
  final String? url;

  const Picture({
    this.evalue,
    this.url
  });

  factory Picture.fromJson(Map<String, dynamic> json) => _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);

  @override
  List<Object?> get props => [evalue, url];
  
}

@JsonSerializable()
class AttrRecordResponse extends Equatable {

  @JsonKey(name: '@Code')
  final int? code;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@Lookup')
  final String? lookup;

  @JsonKey(name: '@Type')
  final String? type;

  @JsonKey(name: '@Hint')
  final String? hint;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@MinLength')
  final int? minLength;

  @JsonKey(name: '@MaxLength')
  final int? maxLength;

  @JsonKey(name: '@Min')
  final double? min;

  @JsonKey(name: '@Max')
  final double? max;

  @JsonKey(name: '@Mandatory')
  final int? mandatory;

  @JsonKey(name: '@Edit')
  final int? edit;

  @JsonKey(name: '@View')
  final int? view;

  @JsonKey(name: 'Mask')
  final String? mask;

  @JsonKey(name: '@Value')
  final String? value;

  @JsonKey(name: '@Change')
  final int? change;

  const AttrRecordResponse({
    this.code,
    this.name,
    this.lookup,
    this.type,
    this.hint,
    this.codeOut,
    this.minLength,
    this.maxLength,
    this.min,
    this.max,
    this.mandatory,
    this.edit,
    this.view,
    this.mask,
    this.value,
    this.change
  });

  factory AttrRecordResponse.fromJson(Map<String, dynamic> json) => _$AttrRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttrRecordResponseToJson(this);

  @override
  List<Object?> get props => [code, name, lookup, type, hint, codeOut, minLength,
  maxLength, min, max, mandatory, edit, view, mask, value, change];
  
}

@JsonSerializable()
class Lookups extends Equatable {

  @JsonKey(name: 'Lookup')
  final List<Lookup>? lookupList;

  const Lookups({
    this.lookupList
  });

  factory Lookups.fromJson(Map<String, dynamic> json) => _$LookupsFromJson(json);

  Map<String, dynamic> toJson() => _$LookupsToJson(this);

  @override
  List<Object?> get props => [lookupList];
  
}

@JsonSerializable()
class Lookup extends Equatable {

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: 'Item')
  final List<LookupItem>? items;

  const Lookup({
    this.name,
    this.items
  });

  factory Lookup.fromJson(Map<String, dynamic> json) => _$LookupFromJson(json);

  Map<String, dynamic> toJson() => _$LookupToJson(this);

  @override
  List<Object?> get props => [name, items];
  
}

@JsonSerializable()
class LookupItem extends Equatable {

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: 'evalue')
  final String? evalue;

  const LookupItem({
    this.name,
    this.evalue
  });

  factory LookupItem.fromJson(Map<String, dynamic> json) => _$LookupItemFromJson(json);

  Map<String, dynamic> toJson() => _$LookupItemToJson(this);

  @override
  List<Object?> get props => [name, evalue];
  
}

@JsonSerializable()
class CheckResponse extends Equatable {

  @JsonKey(name: 'CheckHeader')
  final CheckHeaderItem? checkHeader;

  @JsonKey(name: 'CheckFooter')
  final CheckHeaderItem? checkFooter;

  const CheckResponse({
    this.checkHeader,
    this.checkFooter
  });

  factory CheckResponse.fromJson(Map<String, dynamic> json) => _$CheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckResponseToJson(this);

  @override
  List<Object?> get props => [checkHeader, checkFooter];
  
}

@JsonSerializable()
class CheckHeaderItem extends Equatable {

  @JsonKey(name: '@Count')
  final int? count;

  @JsonKey(name: 'CheckLine')
  final List<CheckLineItem>? checkLine;

  const CheckHeaderItem({
    this.count,
    this.checkLine
  });

  factory CheckHeaderItem.fromJson(Map<String, dynamic> json) => _$CheckHeaderItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckHeaderItemToJson(this);

  @override
  List<Object?> get props => [count, checkLine];
  
}

@JsonSerializable()
class CheckLineItem extends Equatable {

  @JsonKey(name: '@Idx')
  final int? idx;

  @JsonKey(name: 'evalue')
  final String? evalue;

  const CheckLineItem({
    this.idx,
    this.evalue
  });

  factory CheckLineItem.fromJson(Map<String, dynamic> json) => _$CheckLineItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckLineItemToJson(this);

  @override
  List<Object?> get props => [idx, evalue];
  
}

@JsonSerializable()
class TokenRecord {

  @JsonKey(name: 'Token')
  final String? token;

  @JsonKey(name: 'TerminalID')
  final String? terminalID;

  @JsonKey(name: 'PAN')
  final PAN? pan;

  @JsonKey(name: 'TypePAN')
  final TypePAN? typePAN;

  const TokenRecord({
    this.token,
    this.terminalID,
    this.pan,
    this.typePAN,
  });

  factory TokenRecord.fromJson(Map<String, dynamic> json) => _$TokenRecordFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRecordToJson(this);
  
}

@JsonSerializable()
class PAN {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@Expiry')
  final String? expiry;

  const PAN({
    this.evalue,
    this.expiry,
  });

  factory PAN.fromJson(Map<String, dynamic> json) => _$PANFromJson(json);

  Map<String, dynamic> toJson() => _$PANToJson(this);
  
}

@JsonSerializable()
class TypePAN {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: 'AccountType')
  final String? accountType;

  const TypePAN({
    this.evalue,
    this.accountType,
  });

  factory TypePAN.fromJson(Map<String, dynamic> json) => _$TypePANFromJson(json);

  Map<String, dynamic> toJson() => _$TypePANToJson(this);
  
}

@JsonSerializable()
class GroupRecord {

  @JsonKey(name: '@Code')
  final int? code;

  @JsonKey(name: '@Name')
  final String? name;

  const GroupRecord({
    this.code,
    this.name,
  });

  factory GroupRecord.fromJson(Map<String, dynamic> json) => _$GroupRecordFromJson(json);

  Map<String, dynamic> toJson() => _$GroupRecordToJson(this);
  
}

@JsonSerializable()
class PayRecordRequest {

  @JsonKey(name: '@Code')
  final int? code;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@NameOut')
  final String? nameOut;

  @JsonKey(name: '@Summa')
  final double? summa;

  @JsonKey(name: '@Currency')
  final int? currency;

  @JsonKey(name: '@SessionId')
  final String? sessionId;

  @JsonKey(name: 'AttrRecord')
  final List<AttrRecordRequest>? attrRecord;

  PayRecordRequest({
    this.code,
    this.codeOut,
    this.nameOut,
    this.summa,
    this.currency,
    this.sessionId,
    this.attrRecord
  });

  factory PayRecordRequest.fromJson(Map<String, dynamic> json) => _$PayRecordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayRecordRequestToJson(this);
  
}

@JsonSerializable()
class AttrRecordRequest {

  @JsonKey(name: '@Code')
  final int code;

  @JsonKey(name: '@CodeOut')
  final int? codeOut;

  @JsonKey(name: '@Value')
  String? value;

  @JsonKey(name: '@Change')
  int? change;

  AttrRecordRequest({
    required this.code,
    this.codeOut,
    required this.value,
    required this.change,
  });

  AttrRecordRequest copyWith({
    int? code,
    int? codeOut,
    String? value,
    int? change,
  }) => AttrRecordRequest(
    code: code ?? this.code,
    codeOut: codeOut ?? this.codeOut,
    value: value ?? this.value,
    change: change ?? this.change,
  );

  factory AttrRecordRequest.fromJson(Map<String, dynamic> json) => _$AttrRecordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttrRecordRequestToJson(this);
  
}

@JsonSerializable()
class RequestProperty {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@Idx')
  final int? idx;

  RequestProperty({
    this.evalue,
    this.idx,
  });

  factory RequestProperty.fromJson(Map<String, dynamic> json) => _$RequestPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$RequestPropertyToJson(this);
  
}

@JsonSerializable()
class ResponseClaim {

  @JsonKey(name: 'Property')
  final List<ResponseClaimProperty>? properties;

  @JsonKey(name: 'InfoLine')
  final List<ResponseClaimInfoLine>? infoLines;

  @JsonKey(name: 'Service')
  final List<ResponseClaimService>? services;

  ResponseClaim({
    this.properties,
    this.infoLines,
    this.services,
  });

  factory ResponseClaim.fromJson(Map<String, dynamic> json) => _$ResponseClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseClaimToJson(this);
  
}

@JsonSerializable()
class ResponseClaimProperty {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@Idx')
  final int? idx;

  @JsonKey(name: '@Assignment')
  final int? assignment;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@View')
  final int? view;

  @JsonKey(name: '@Edit')
  final int? edit;

  @JsonKey(name: '@Type')
  final String? type;

  @JsonKey(name: '@MinLength')
  final int? minLength;

  @JsonKey(name: '@MaxLength')
  final int? maxLength;

  @JsonKey(name: '@Min')
  final int? min;

  @JsonKey(name: '@Max')
  final int? max;

  @JsonKey(name: '@Mandatory')
  final int? mandatory;

  @JsonKey(name: '@Hint')
  final String? hint;

  @JsonKey(name: '@Format')
  final String? format;

  ResponseClaimProperty({
    this.evalue,
    this.idx,
    this.assignment,
    this.name,
    this.view,
    this.edit,
    this.type,
    this.minLength,
    this.maxLength,
    this.min,
    this.max,
    this.mandatory,
    this.hint,
    this.format,
  });

  factory ResponseClaimProperty.fromJson(Map<String, dynamic> json) => _$ResponseClaimPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseClaimPropertyToJson(this);
  
}

@JsonSerializable()
class ResponseClaimInfoLine {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@Idx')
  final int? idx;

  ResponseClaimInfoLine({
    this.evalue,
    this.idx,
  });

  factory ResponseClaimInfoLine.fromJson(Map<String, dynamic> json) => _$ResponseClaimInfoLineFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseClaimInfoLineToJson(this);
  
}

@JsonSerializable()
class ResponseClaimService {

  @JsonKey(name: 'Property')
  final List<ResponseClaimProperty>? properties;

  @JsonKey(name: 'InfoLine')
  final List<ResponseClaimInfoLine>? infoLines;

  @JsonKey(name: 'Counter')
  final List<ResponseClaimServiceCounter>? counters;

  ResponseClaimService({
    this.properties,
    this.infoLines,
    this.counters,
  });

  factory ResponseClaimService.fromJson(Map<String, dynamic> json) => _$ResponseClaimServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseClaimServiceToJson(this);
  
}

@JsonSerializable()
class ResponseClaimServiceCounter {

  @JsonKey(name: 'Property')
  final List<ResponseClaimProperty>? properties;

  @JsonKey(name: 'InfoLine')
  final List<ResponseClaimInfoLine>? infoLines;

  ResponseClaimServiceCounter({
    this.properties,
    this.infoLines,
  });

  factory ResponseClaimServiceCounter.fromJson(Map<String, dynamic> json) => _$ResponseClaimServiceCounterFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseClaimServiceCounterToJson(this);
  
}