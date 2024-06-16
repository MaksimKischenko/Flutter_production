// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_payment_method_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayConfirmPaymentMethodRequestWrapper
    _$PsHelppayConfirmPaymentMethodRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayConfirmPaymentMethodRequestWrapper(
          PsHelppayConfirmPaymentMethodRequest.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayConfirmPaymentMethodRequestWrapperToJson(
        PsHelppayConfirmPaymentMethodRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayConfirmPaymentMethodRequest
    _$PsHelppayConfirmPaymentMethodRequestFromJson(Map<String, dynamic> json) =>
        PsHelppayConfirmPaymentMethodRequest(
          ConfirmPaymentMethodRequest.fromJson(
              json['ConfirmPayMeanRequest'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayConfirmPaymentMethodRequestToJson(
        PsHelppayConfirmPaymentMethodRequest instance) =>
    <String, dynamic>{
      'ConfirmPayMeanRequest': instance.request,
    };

ConfirmPaymentMethodRequest _$ConfirmPaymentMethodRequestFromJson(
        Map<String, dynamic> json) =>
    ConfirmPaymentMethodRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: json['PAN'] == null
          ? null
          : QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      requestId:
          RequestIdentifier.fromJson(json['RequestId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmPaymentMethodRequestToJson(
    ConfirmPaymentMethodRequest instance) {
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
  val['RequestId'] = instance.requestId;
  return val;
}

RequestIdentifier _$RequestIdentifierFromJson(Map<String, dynamic> json) =>
    RequestIdentifier(
      evalue: json['Value'] as int,
      otpCode: json['OTPCode'] as String?,
      confirmCode: json['ConfirmCode'] as int,
      contractKind: json['ContractKind'] as int?,
      cardId: json['CardId'] as int?,
      attemptNumber: json['AttemptNumber'] as int?,
    );

Map<String, dynamic> _$RequestIdentifierToJson(RequestIdentifier instance) {
  final val = <String, dynamic>{
    'Value': instance.evalue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OTPCode', instance.otpCode);
  writeNotNull('AttemptNumber', instance.attemptNumber);
  writeNotNull('CardId', instance.cardId);
  writeNotNull('ContractKind', instance.contractKind);
  val['ConfirmCode'] = instance.confirmCode;
  return val;
}
