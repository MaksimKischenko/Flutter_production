// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_balance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripGetBalanceResponseWrapper _$PsEripGetBalanceResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripGetBalanceResponseWrapper(
      PsEripGetBalanceResponse.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetBalanceResponseWrapperToJson(
        PsEripGetBalanceResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripGetBalanceResponse _$PsEripGetBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripGetBalanceResponse(
      GetBalanceResponse.fromJson(
          json['GetBalanceResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetBalanceResponseToJson(
        PsEripGetBalanceResponse instance) =>
    <String, dynamic>{
      'GetBalanceResponse': instance.response,
    };

GetBalanceResponse _$GetBalanceResponseFromJson(Map<String, dynamic> json) =>
    GetBalanceResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      balance: json['Balance'] == null
          ? null
          : Balance.fromJson(json['Balance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBalanceResponseToJson(GetBalanceResponse instance) {
  final val = <String, dynamic>{
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('Balance', instance.balance);
  return val;
}

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
      sessionID: json['@SessionID'] as int,
      amount: (json['@Amount'] as num).toDouble(),
      currency: json['@Currency'] as int,
      draftEnabled: json['@DraftEnabled'] as String,
      aditionalParams: (json['@AddParams'] as List<dynamic>?)
          ?.map(
              (e) => AditionalBalanceParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BalanceToJson(Balance instance) {
  final val = <String, dynamic>{
    '@SessionID': instance.sessionID,
    '@Amount': instance.amount,
    '@Currency': instance.currency,
    '@DraftEnabled': instance.draftEnabled,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@AddParams', instance.aditionalParams);
  return val;
}

AditionalBalanceParam _$AditionalBalanceParamFromJson(
        Map<String, dynamic> json) =>
    AditionalBalanceParam(
      name: json['@Name'] as String,
      value: json['@Value'] as String,
    );

Map<String, dynamic> _$AditionalBalanceParamToJson(
        AditionalBalanceParam instance) =>
    <String, dynamic>{
      '@Name': instance.name,
      '@Value': instance.value,
    };
