// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomLoginResponseWrapper _$MdomLoginResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomLoginResponseWrapper(
      MdomLoginResponse.fromJson(json['UserResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomLoginResponseWrapperToJson(
        MdomLoginResponseWrapper instance) =>
    <String, dynamic>{
      'UserResponse': instance.userResponse,
    };

MdomLoginResponse _$MdomLoginResponseFromJson(Map<String, dynamic> json) =>
    MdomLoginResponse(
      requestType: json['RequestType'] as String,
      errorCode:
          MdomErrorCode.fromJson(json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] == null
          ? null
          : MdomToken.fromJson(json['Token'] as Map<String, dynamic>),
      params: json['Params'] == null
          ? null
          : MdomResponseParams.fromJson(json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
      products: json['Products'] == null
          ? null
          : MdomLoginResponseProducts.fromJson(
              json['Products'] as Map<String, dynamic>),
      terminals: json['Terminals'] == null
          ? null
          : MdomLoginResponseTerminals.fromJson(
              json['Terminals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomLoginResponseToJson(MdomLoginResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
      'Params': instance.params,
      'Lookups': instance.lookups,
      'Products': instance.products,
      'Terminals': instance.terminals,
    };

MdomLoginResponseProducts _$MdomLoginResponseProductsFromJson(
        Map<String, dynamic> json) =>
    MdomLoginResponseProducts(
      current: (json['Current'] as List<dynamic>?)
          ?.map((e) => MdomLoginResponseProductsCurrent.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      ruleNew: (json['RuleNew'] as List<dynamic>)
          .map((e) => MdomLoginResponseProductsCurrent.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomLoginResponseProductsToJson(
        MdomLoginResponseProducts instance) =>
    <String, dynamic>{
      'Current': instance.current,
      'RuleNew': instance.ruleNew,
    };

MdomLoginResponseProductsCurrent _$MdomLoginResponseProductsCurrentFromJson(
        Map<String, dynamic> json) =>
    MdomLoginResponseProductsCurrent(
      params:
          MdomResponseParams.fromJson(json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomLoginResponseProductsCurrentToJson(
        MdomLoginResponseProductsCurrent instance) =>
    <String, dynamic>{
      'Params': instance.params,
      'Lookups': instance.lookups,
    };

MdomLoginResponseTerminals _$MdomLoginResponseTerminalsFromJson(
        Map<String, dynamic> json) =>
    MdomLoginResponseTerminals(
      terminals: (json['TerminalKKS'] as List<dynamic>)
          .map((e) => MdomLoginResponseTerminalsTerminalKKS.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomLoginResponseTerminalsToJson(
        MdomLoginResponseTerminals instance) =>
    <String, dynamic>{
      'TerminalKKS': instance.terminals,
    };

MdomLoginResponseTerminalsTerminalKKS
    _$MdomLoginResponseTerminalsTerminalKKSFromJson(
            Map<String, dynamic> json) =>
        MdomLoginResponseTerminalsTerminalKKS(
          evalue: json['@Value'] as String,
          params: MdomResponseParams.fromJson(
              json['Params'] as Map<String, dynamic>),
          lookups: json['Lookups'] == null
              ? null
              : MdomLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomLoginResponseTerminalsTerminalKKSToJson(
        MdomLoginResponseTerminalsTerminalKKS instance) =>
    <String, dynamic>{
      '@Value': instance.evalue,
      'Params': instance.params,
      'Lookups': instance.lookups,
    };
