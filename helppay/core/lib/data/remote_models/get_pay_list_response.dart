import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_pay_list_response.g.dart';

@JsonSerializable()
class PsEripGetPayListResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripGetPayListResponse psErip;

  const PsEripGetPayListResponseWrapper(this.psErip);

  factory PsEripGetPayListResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripGetPayListResponse {

  @JsonKey(name: 'GetPayListResponse')
  final GetPayListResponse response;

  const PsEripGetPayListResponse(this.response);

  factory PsEripGetPayListResponse.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GetPayListResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Token')
  final String? token;

  @JsonKey(name: 'PayRecord')
  final List<PayRecordResponse>? payRecord;

  const GetPayListResponse({
    this.errorCode,
    this.errorText,
    this.token,
    this.payRecord,
  });

  factory GetPayListResponse.fromJson(Map<String, dynamic> json) => _$GetPayListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListResponseToJson(this);
  
}

@JsonSerializable()
class PayRecordResponse extends Equatable {
  // class PayRecordResponse {

  @JsonKey(name: '@Code')
  final int code;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@CodeOut')
  final int? codeOut; 

  @JsonKey(name: '@DIType')
  final int? diType;

  @JsonKey(name: '@GetPayListType')
  final int? getPayListType;

  @JsonKey(name: '@Category')
  final int? category;

  @JsonKey(name: '@RecordType')
  final int? recordType;

  @JsonKey(name: '@StornoMode')
  final String? stornoMode;

  @JsonKey(name: '@Change')
  final int? change;

  @JsonKey(name: '@RecordID')
  final int? recordID;

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
  final double? currency;

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

  const PayRecordResponse({
    required this.code,
    required this.name,   
    required this.codeOut,     
    required this.diType,
    required this.getPayListType,
    required this.category,    
    required this.paymentID,
    required this.date,
    required this.recordID,
    this.recordType,
    this.stornoMode,
    this.change,
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
    this.attrRecord,
    this.lookups,
    this.check
  });

  factory PayRecordResponse.fromJson(Map<String, dynamic> json) => _$PayRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayRecordResponseToJson(this);

  PayRecordResponse copy({
    int? code,
    int? diType,
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
    double? currency,
    double? payCommission,
    String? sessionId,
    int? paymentID,
    String? date,
    List<AttrRecordResponse>? attrRecord,
    Lookups? lookups,
    CheckResponse? check
  }) => PayRecordResponse(
    code: code ?? this.code,
    category: category ?? category,
    diType: diType ?? this.diType,
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
    check: check ?? this.check
  );

  @override
  List<Object?> get props => [code,category, codeOut, getPayListType, name, 
  diType, codeOut, name, recordType, stornoMode,
  change, recordID, getPayListType, picture, payAll, summa, min, max,
  nominal, edit, view, fine, currency, payCommission, sessionId, paymentID,
  date, attrRecord, lookups, check];

}

@JsonSerializable()
class Picture extends Equatable {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@URL')
  final String? url;

  const Picture({
    this.evalue,
    this.url,
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
    required this.code,
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
  final List<Lookup> lookupList;

  const Lookups({
    required this.lookupList,
  });

  factory Lookups.fromJson(Map<String, dynamic> json) => _$LookupsFromJson(json);

  Map<String, dynamic> toJson() => _$LookupsToJson(this);

  @override
  List<Object> get props => [lookupList];
  
}

@JsonSerializable()
class Lookup extends Equatable {

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: 'Item')
  final List<LookupItem>? items;

  const Lookup({
    required this.name,
    this.items,
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
    this.evalue,
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
    this.checkFooter,
  });

  factory CheckResponse.fromJson(Map<String, dynamic> json) => _$CheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckResponseToJson(this);

  @override
  List<Object?> get props => [checkHeader, checkFooter];
  
}

@JsonSerializable()
class CheckHeaderItem extends Equatable {

  @JsonKey(name: '@Count')
  final int count;

  @JsonKey(name: 'CheckLine')
  final List<CheckLineItem> checkLine;

  const CheckHeaderItem({
    required this.count,
    required this.checkLine,
  });

  factory CheckHeaderItem.fromJson(Map<String, dynamic> json) => _$CheckHeaderItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckHeaderItemToJson(this);

  @override
  List<Object> get props => [count, checkLine];
  
}

@JsonSerializable()
class CheckLineItem extends Equatable {

  @JsonKey(name: '@Idx')
  final int idx;

  @JsonKey(name: 'evalue')
  final String? evalue;

  const CheckLineItem({
    required this.idx,
    required this.evalue,
  });

  factory CheckLineItem.fromJson(Map<String, dynamic> json) => _$CheckLineItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckLineItemToJson(this);

  @override
  List<Object?> get props => [idx, evalue];
  
}