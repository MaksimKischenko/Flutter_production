// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomCreateRequestWrapper _$MdomCreateRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomCreateRequestWrapper(
      MdomCreateRequest.fromJson(json['UserRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomCreateRequestWrapperToJson(
        MdomCreateRequestWrapper instance) =>
    <String, dynamic>{
      'UserRequest': instance.userRequest,
    };

MdomCreateRequest _$MdomCreateRequestFromJson(Map<String, dynamic> json) =>
    MdomCreateRequest(
      requestType: json['RequestType'] as String? ?? 'Create',
      lang: json['Lang'] as String?,
      login: MdomLogin.fromJson(json['Login'] as Map<String, dynamic>),
      isSendCodeSMS: json['isSendCodeSMS'] == null
          ? null
          : MdomCreateRequestIsSendCodeSMS.fromJson(
              json['isSendCodeSMS'] as Map<String, dynamic>),
      action: json['Action'] as String? ?? 'OWN',
      isSendCodeEMail: json['isSendCodeEMail'] as int?,
      isOrganization: json['isOrganization'] == null
          ? null
          : MdomCreateUserIsOrganization.fromJson(
              json['isOrganization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomCreateRequestToJson(MdomCreateRequest instance) {
  final val = <String, dynamic>{
    'RequestType': instance.requestType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['Login'] = instance.login;
  writeNotNull('isSendCodeSMS', instance.isSendCodeSMS);
  val['Action'] = instance.action;
  writeNotNull('isSendCodeEMail', instance.isSendCodeEMail);
  writeNotNull('isOrganization', instance.isOrganization);
  return val;
}

MdomCreateRequestIsSendCodeSMS _$MdomCreateRequestIsSendCodeSMSFromJson(
        Map<String, dynamic> json) =>
    MdomCreateRequestIsSendCodeSMS(
      evalue: json['evalue'] as int?,
      phone: json['@Phone'] as String?,
    );

Map<String, dynamic> _$MdomCreateRequestIsSendCodeSMSToJson(
    MdomCreateRequestIsSendCodeSMS instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('evalue', instance.evalue);
  writeNotNull('@Phone', instance.phone);
  return val;
}

MdomCreateUserIsOrganization _$MdomCreateUserIsOrganizationFromJson(
        Map<String, dynamic> json) =>
    MdomCreateUserIsOrganization(
      evalue: json['evalue'] as int,
      keyRegistration: json['@KeyRegistration'] as String?,
    );

Map<String, dynamic> _$MdomCreateUserIsOrganizationToJson(
        MdomCreateUserIsOrganization instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@KeyRegistration': instance.keyRegistration,
    };
