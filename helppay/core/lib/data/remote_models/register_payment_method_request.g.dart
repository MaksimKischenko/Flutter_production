// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_payment_method_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayRegisterPaymentMethodRequestWrapper
    _$PsHelppayRegisterPaymentMethodRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayRegisterPaymentMethodRequestWrapper(
          PsHelppayRegisterPaymentMethodRequest.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayRegisterPaymentMethodRequestWrapperToJson(
        PsHelppayRegisterPaymentMethodRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayRegisterPaymentMethodRequest
    _$PsHelppayRegisterPaymentMethodRequestFromJson(
            Map<String, dynamic> json) =>
        PsHelppayRegisterPaymentMethodRequest(
          RegisterPaymentMethodRequest.fromJson(
              json['RegPayMeanRequest'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayRegisterPaymentMethodRequestToJson(
        PsHelppayRegisterPaymentMethodRequest instance) =>
    <String, dynamic>{
      'RegPayMeanRequest': instance.request,
    };

RegisterPaymentMethodRequest _$RegisterPaymentMethodRequestFromJson(
        Map<String, dynamic> json) =>
    RegisterPaymentMethodRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: json['PAN'] == null
          ? null
          : QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      cardEmissionParam: json['CardEmissionParam'] == null
          ? null
          : CardEmissionParam.fromJson(
              json['CardEmissionParam'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterPaymentMethodRequestToJson(
    RegisterPaymentMethodRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'Version': instance.version,
    'TypePAN': instance.typePan,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PAN', instance.pan);
  writeNotNull('CardEmissionParam', instance.cardEmissionParam);
  return val;
}

CardEmissionParam _$CardEmissionParamFromJson(Map<String, dynamic> json) =>
    CardEmissionParam(
      phoneNumber: json['PhoneNumber'] as String,
      bankId: json['BankId'] as int,
      attemptNumber: json['AttemptNumber'] as int?,
      contractKind: json['ContractKind'] as int?,
      personalNumber: json['PersonalNumber'] as String?,
      requestId: json['RequestId'] as String?,
      cardId: json['CardId'] as String?,
    );

Map<String, dynamic> _$CardEmissionParamToJson(CardEmissionParam instance) {
  final val = <String, dynamic>{
    'PhoneNumber': instance.phoneNumber,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AttemptNumber', instance.attemptNumber);
  val['BankId'] = instance.bankId;
  writeNotNull('ContractKind', instance.contractKind);
  writeNotNull('PersonalNumber', instance.personalNumber);
  writeNotNull('RequestId', instance.requestId);
  writeNotNull('CardId', instance.cardId);
  return val;
}
