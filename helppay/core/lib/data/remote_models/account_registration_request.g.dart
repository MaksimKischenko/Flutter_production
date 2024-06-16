// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomAccountRegistrationRequestWrapper
    _$MdomAccountRegistrationRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomAccountRegistrationRequestWrapper(
          MdomAccountRegistrationRequest.fromJson(
              json['TPInfoRequest'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomAccountRegistrationRequestWrapperToJson(
        MdomAccountRegistrationRequestWrapper instance) =>
    <String, dynamic>{
      'TPInfoRequest': instance.request,
    };

MdomAccountRegistrationRequest _$MdomAccountRegistrationRequestFromJson(
        Map<String, dynamic> json) =>
    MdomAccountRegistrationRequest(
      terminalId: json['TerminalId'] as String,
      version: json['Version'] as String,
      token: json['Token'] as String,
      lang: json['Lang'] as String?,
      account: AccountRegistrationAccount.fromJson(
          json['Account'] as Map<String, dynamic>),
      requestType: json['RequestType'] as String? ?? 'AccountRegistration',
    );

Map<String, dynamic> _$MdomAccountRegistrationRequestToJson(
    MdomAccountRegistrationRequest instance) {
  final val = <String, dynamic>{
    'RequestType': instance.requestType,
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'Token': instance.token,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['Account'] = instance.account;
  return val;
}

AccountRegistrationAccount _$AccountRegistrationAccountFromJson(
        Map<String, dynamic> json) =>
    AccountRegistrationAccount(
      evalue: json['evalue'] as String,
      supplierId: json['@SupplierId'] as int?,
      isSendCodeSMS: json['@isSendCodeSMS'] as int?,
      isSendCodeEMail: json['@isSendCodeEMail'] as int?,
      codeWord: json['@CodeWord'] as String?,
    );

Map<String, dynamic> _$AccountRegistrationAccountToJson(
    AccountRegistrationAccount instance) {
  final val = <String, dynamic>{
    'evalue': instance.evalue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@SupplierId', instance.supplierId);
  writeNotNull('@isSendCodeSMS', instance.isSendCodeSMS);
  writeNotNull('@isSendCodeEMail', instance.isSendCodeEMail);
  writeNotNull('@CodeWord', instance.codeWord);
  return val;
}
