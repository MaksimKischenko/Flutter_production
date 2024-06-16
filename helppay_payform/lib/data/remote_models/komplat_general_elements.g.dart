// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komplat_general_elements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayRecordResponse _$PayRecordResponseFromJson(Map<String, dynamic> json) =>
    PayRecordResponse(
      code: json['@Code'] as int?,
      diType: json['@DIType'] as int?,
      codeOut: json['@CodeOut'] as int?,
      name: json['@Name'] as String?,
      recordType: json['@RecordType'] as int?,
      stornoMode: json['@StornoMode'] as String?,
      change: json['@Change'] as int?,
      recordID: json['@RecordID'] as int?,
      getPayListType: json['@GetPayListType'] as int?,
      picture: json['Picture'] == null
          ? null
          : Picture.fromJson(json['Picture'] as Map<String, dynamic>),
      payAll: (json['@PayAll'] as num?)?.toDouble(),
      summa: (json['@Summa'] as num?)?.toDouble(),
      min: (json['@Min'] as num?)?.toDouble(),
      max: (json['@Max'] as num?)?.toDouble(),
      nominal: (json['@Nominal'] as num?)?.toDouble(),
      edit: json['@Edit'] as int?,
      view: json['@View'] as int?,
      fine: (json['@Fine'] as num?)?.toDouble(),
      currency: json['@Currency'] as int?,
      payCommission: (json['@PayCommission'] as num?)?.toDouble(),
      sessionId: json['@SessionId'] as String?,
      paymentID: json['@PaymentID'] as int?,
      date: json['@Date'] as String?,
      attrRecord: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => AttrRecordResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      lookups: json['Lookups'] == null
          ? null
          : Lookups.fromJson(json['Lookups'] as Map<String, dynamic>),
      check: json['Check'] == null
          ? null
          : CheckResponse.fromJson(json['Check'] as Map<String, dynamic>),
      groupRecord: json['GroupRecord'] == null
          ? null
          : GroupRecord.fromJson(json['GroupRecord'] as Map<String, dynamic>),
      claims: (json['Claim'] as List<dynamic>?)
          ?.map((e) => ResponseClaim.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayRecordResponseToJson(PayRecordResponse instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@DIType': instance.diType,
      '@CodeOut': instance.codeOut,
      '@Name': instance.name,
      '@RecordType': instance.recordType,
      '@StornoMode': instance.stornoMode,
      '@Change': instance.change,
      '@RecordID': instance.recordID,
      '@GetPayListType': instance.getPayListType,
      'Picture': instance.picture,
      '@PayAll': instance.payAll,
      '@Summa': instance.summa,
      '@Min': instance.min,
      '@Max': instance.max,
      '@Nominal': instance.nominal,
      '@Edit': instance.edit,
      '@View': instance.view,
      '@Fine': instance.fine,
      '@Currency': instance.currency,
      '@PayCommission': instance.payCommission,
      '@SessionId': instance.sessionId,
      '@PaymentID': instance.paymentID,
      '@Date': instance.date,
      'AttrRecord': instance.attrRecord,
      'Lookups': instance.lookups,
      'Check': instance.check,
      'GroupRecord': instance.groupRecord,
      'Claim': instance.claims,
    };

Picture _$PictureFromJson(Map<String, dynamic> json) => Picture(
      evalue: json['evalue'] as String?,
      url: json['@URL'] as String?,
    );

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@URL': instance.url,
    };

AttrRecordResponse _$AttrRecordResponseFromJson(Map<String, dynamic> json) =>
    AttrRecordResponse(
      code: json['@Code'] as int?,
      name: json['@Name'] as String?,
      lookup: json['@Lookup'] as String?,
      type: json['@Type'] as String?,
      hint: json['@Hint'] as String?,
      codeOut: json['@CodeOut'] as int?,
      minLength: json['@MinLength'] as int?,
      maxLength: json['@MaxLength'] as int?,
      min: (json['@Min'] as num?)?.toDouble(),
      max: (json['@Max'] as num?)?.toDouble(),
      mandatory: json['@Mandatory'] as int?,
      edit: json['@Edit'] as int?,
      view: json['@View'] as int?,
      mask: json['Mask'] as String?,
      value: json['@Value'] as String?,
      change: json['@Change'] as int?,
    );

Map<String, dynamic> _$AttrRecordResponseToJson(AttrRecordResponse instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@Name': instance.name,
      '@Lookup': instance.lookup,
      '@Type': instance.type,
      '@Hint': instance.hint,
      '@CodeOut': instance.codeOut,
      '@MinLength': instance.minLength,
      '@MaxLength': instance.maxLength,
      '@Min': instance.min,
      '@Max': instance.max,
      '@Mandatory': instance.mandatory,
      '@Edit': instance.edit,
      '@View': instance.view,
      'Mask': instance.mask,
      '@Value': instance.value,
      '@Change': instance.change,
    };

Lookups _$LookupsFromJson(Map<String, dynamic> json) => Lookups(
      lookupList: (json['Lookup'] as List<dynamic>?)
          ?.map((e) => Lookup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookupsToJson(Lookups instance) => <String, dynamic>{
      'Lookup': instance.lookupList,
    };

Lookup _$LookupFromJson(Map<String, dynamic> json) => Lookup(
      name: json['@Name'] as String?,
      items: (json['Item'] as List<dynamic>?)
          ?.map((e) => LookupItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookupToJson(Lookup instance) => <String, dynamic>{
      '@Name': instance.name,
      'Item': instance.items,
    };

LookupItem _$LookupItemFromJson(Map<String, dynamic> json) => LookupItem(
      name: json['@Name'] as String?,
      evalue: json['evalue'] as String?,
    );

Map<String, dynamic> _$LookupItemToJson(LookupItem instance) =>
    <String, dynamic>{
      '@Name': instance.name,
      'evalue': instance.evalue,
    };

CheckResponse _$CheckResponseFromJson(Map<String, dynamic> json) =>
    CheckResponse(
      checkHeader: json['CheckHeader'] == null
          ? null
          : CheckHeaderItem.fromJson(
              json['CheckHeader'] as Map<String, dynamic>),
      checkFooter: json['CheckFooter'] == null
          ? null
          : CheckHeaderItem.fromJson(
              json['CheckFooter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckResponseToJson(CheckResponse instance) =>
    <String, dynamic>{
      'CheckHeader': instance.checkHeader,
      'CheckFooter': instance.checkFooter,
    };

CheckHeaderItem _$CheckHeaderItemFromJson(Map<String, dynamic> json) =>
    CheckHeaderItem(
      count: json['@Count'] as int?,
      checkLine: (json['CheckLine'] as List<dynamic>?)
          ?.map((e) => CheckLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckHeaderItemToJson(CheckHeaderItem instance) =>
    <String, dynamic>{
      '@Count': instance.count,
      'CheckLine': instance.checkLine,
    };

CheckLineItem _$CheckLineItemFromJson(Map<String, dynamic> json) =>
    CheckLineItem(
      idx: json['@Idx'] as int?,
      evalue: json['evalue'] as String?,
    );

Map<String, dynamic> _$CheckLineItemToJson(CheckLineItem instance) =>
    <String, dynamic>{
      '@Idx': instance.idx,
      'evalue': instance.evalue,
    };

TokenRecord _$TokenRecordFromJson(Map<String, dynamic> json) => TokenRecord(
      token: json['Token'] as String?,
      terminalID: json['TerminalID'] as String?,
      pan: json['PAN'] == null
          ? null
          : PAN.fromJson(json['PAN'] as Map<String, dynamic>),
      typePAN: json['TypePAN'] == null
          ? null
          : TypePAN.fromJson(json['TypePAN'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenRecordToJson(TokenRecord instance) =>
    <String, dynamic>{
      'Token': instance.token,
      'TerminalID': instance.terminalID,
      'PAN': instance.pan,
      'TypePAN': instance.typePAN,
    };

PAN _$PANFromJson(Map<String, dynamic> json) => PAN(
      evalue: json['evalue'] as String?,
      expiry: json['@Expiry'] as String?,
    );

Map<String, dynamic> _$PANToJson(PAN instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@Expiry': instance.expiry,
    };

TypePAN _$TypePANFromJson(Map<String, dynamic> json) => TypePAN(
      evalue: json['evalue'] as String?,
      accountType: json['AccountType'] as String?,
    );

Map<String, dynamic> _$TypePANToJson(TypePAN instance) => <String, dynamic>{
      'evalue': instance.evalue,
      'AccountType': instance.accountType,
    };

GroupRecord _$GroupRecordFromJson(Map<String, dynamic> json) => GroupRecord(
      code: json['@Code'] as int?,
      name: json['@Name'] as String?,
    );

Map<String, dynamic> _$GroupRecordToJson(GroupRecord instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@Name': instance.name,
    };

PayRecordRequest _$PayRecordRequestFromJson(Map<String, dynamic> json) =>
    PayRecordRequest(
      code: json['@Code'] as int?,
      codeOut: json['@CodeOut'] as int?,
      nameOut: json['@NameOut'] as String?,
      summa: (json['@Summa'] as num?)?.toDouble(),
      currency: json['@Currency'] as int?,
      sessionId: json['@SessionId'] as String?,
      attrRecord: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => AttrRecordRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayRecordRequestToJson(PayRecordRequest instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@CodeOut': instance.codeOut,
      '@NameOut': instance.nameOut,
      '@Summa': instance.summa,
      '@Currency': instance.currency,
      '@SessionId': instance.sessionId,
      'AttrRecord': instance.attrRecord,
    };

AttrRecordRequest _$AttrRecordRequestFromJson(Map<String, dynamic> json) =>
    AttrRecordRequest(
      code: json['@Code'] as int,
      codeOut: json['@CodeOut'] as int?,
      value: json['@Value'] as String?,
      change: json['@Change'] as int?,
    );

Map<String, dynamic> _$AttrRecordRequestToJson(AttrRecordRequest instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@CodeOut': instance.codeOut,
      '@Value': instance.value,
      '@Change': instance.change,
    };

RequestProperty _$RequestPropertyFromJson(Map<String, dynamic> json) =>
    RequestProperty(
      evalue: json['evalue'] as String?,
      idx: json['@Idx'] as int?,
    );

Map<String, dynamic> _$RequestPropertyToJson(RequestProperty instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Idx': instance.idx,
    };

ResponseClaim _$ResponseClaimFromJson(Map<String, dynamic> json) =>
    ResponseClaim(
      properties: (json['Property'] as List<dynamic>?)
          ?.map(
              (e) => ResponseClaimProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
      infoLines: (json['InfoLine'] as List<dynamic>?)
          ?.map(
              (e) => ResponseClaimInfoLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['Service'] as List<dynamic>?)
          ?.map((e) => ResponseClaimService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseClaimToJson(ResponseClaim instance) =>
    <String, dynamic>{
      'Property': instance.properties,
      'InfoLine': instance.infoLines,
      'Service': instance.services,
    };

ResponseClaimProperty _$ResponseClaimPropertyFromJson(
        Map<String, dynamic> json) =>
    ResponseClaimProperty(
      evalue: json['evalue'] as String?,
      idx: json['@Idx'] as int?,
      assignment: json['@Assignment'] as int?,
      name: json['@Name'] as String?,
      view: json['@View'] as int?,
      edit: json['@Edit'] as int?,
      type: json['@Type'] as String?,
      minLength: json['@MinLength'] as int?,
      maxLength: json['@MaxLength'] as int?,
      min: json['@Min'] as int?,
      max: json['@Max'] as int?,
      mandatory: json['@Mandatory'] as int?,
      hint: json['@Hint'] as String?,
      format: json['@Format'] as String?,
    );

Map<String, dynamic> _$ResponseClaimPropertyToJson(
        ResponseClaimProperty instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Idx': instance.idx,
      '@Assignment': instance.assignment,
      '@Name': instance.name,
      '@View': instance.view,
      '@Edit': instance.edit,
      '@Type': instance.type,
      '@MinLength': instance.minLength,
      '@MaxLength': instance.maxLength,
      '@Min': instance.min,
      '@Max': instance.max,
      '@Mandatory': instance.mandatory,
      '@Hint': instance.hint,
      '@Format': instance.format,
    };

ResponseClaimInfoLine _$ResponseClaimInfoLineFromJson(
        Map<String, dynamic> json) =>
    ResponseClaimInfoLine(
      evalue: json['evalue'] as String?,
      idx: json['@Idx'] as int?,
    );

Map<String, dynamic> _$ResponseClaimInfoLineToJson(
        ResponseClaimInfoLine instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Idx': instance.idx,
    };

ResponseClaimService _$ResponseClaimServiceFromJson(
        Map<String, dynamic> json) =>
    ResponseClaimService(
      properties: (json['Property'] as List<dynamic>?)
          ?.map(
              (e) => ResponseClaimProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
      infoLines: (json['InfoLine'] as List<dynamic>?)
          ?.map(
              (e) => ResponseClaimInfoLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      counters: (json['Counter'] as List<dynamic>?)
          ?.map((e) =>
              ResponseClaimServiceCounter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseClaimServiceToJson(
        ResponseClaimService instance) =>
    <String, dynamic>{
      'Property': instance.properties,
      'InfoLine': instance.infoLines,
      'Counter': instance.counters,
    };

ResponseClaimServiceCounter _$ResponseClaimServiceCounterFromJson(
        Map<String, dynamic> json) =>
    ResponseClaimServiceCounter(
      properties: (json['Property'] as List<dynamic>?)
          ?.map(
              (e) => ResponseClaimProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
      infoLines: (json['InfoLine'] as List<dynamic>?)
          ?.map(
              (e) => ResponseClaimInfoLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseClaimServiceCounterToJson(
        ResponseClaimServiceCounter instance) =>
    <String, dynamic>{
      'Property': instance.properties,
      'InfoLine': instance.infoLines,
    };
