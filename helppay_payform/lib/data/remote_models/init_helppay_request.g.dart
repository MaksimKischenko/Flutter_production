// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_helppay_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitHelpPayRequestWrapper _$InitHelpPayRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    InitHelpPayRequestWrapper(
      PSHelpPayRequest.fromJson(
          json['PSHelpPayRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InitHelpPayRequestWrapperToJson(
        InitHelpPayRequestWrapper instance) =>
    <String, dynamic>{
      'PSHelpPayRequest': instance.request,
    };

PSHelpPayRequest _$PSHelpPayRequestFromJson(Map<String, dynamic> json) =>
    PSHelpPayRequest(
      InitHelpPayRequest.fromJson(
          json['InitHelpPayRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PSHelpPayRequestToJson(PSHelpPayRequest instance) =>
    <String, dynamic>{
      'InitHelpPayRequest': instance.request,
    };

InitHelpPayRequest _$InitHelpPayRequestFromJson(Map<String, dynamic> json) =>
    InitHelpPayRequest(
      loginName: LoginName.fromJson(json['LoginName'] as Map<String, dynamic>),
      password: json['Password'] as String,
      returnURI: json['ReturnURI'] as String?,
      confirmURI: json['ConfirmURI'] as String,
      mode: json['Mode'] as String,
      node: json['Node'] as int?,
      payer: json['Payer'] == null
          ? null
          : Payer.fromJson(json['Payer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InitHelpPayRequestToJson(InitHelpPayRequest instance) {
  final val = <String, dynamic>{
    'LoginName': instance.loginName,
    'Password': instance.password,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ReturnURI', instance.returnURI);
  val['ConfirmURI'] = instance.confirmURI;
  val['Mode'] = instance.mode;
  writeNotNull('Node', instance.node);
  writeNotNull('Payer', instance.payer);
  return val;
}

LoginName _$LoginNameFromJson(Map<String, dynamic> json) => LoginName(
      value: json['evalue'] as String,
      deviceType: json['@DeviceType'] as String,
    );

Map<String, dynamic> _$LoginNameToJson(LoginName instance) => <String, dynamic>{
      'evalue': instance.value,
      '@DeviceType': instance.deviceType,
    };

Payer _$PayerFromJson(Map<String, dynamic> json) => Payer(
      payerId: json['@PayerId'] as String,
      maxAmount: (json['@MaxAmount'] as num?)?.toDouble(),
      serviceId: json['@ServiceId'] as int?,
      account: json['@Account'] as String?,
      description: json['Description'] == null
          ? null
          : Description.fromJson(json['Description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayerToJson(Payer instance) {
  final val = <String, dynamic>{
    '@PayerId': instance.payerId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@MaxAmount', instance.maxAmount);
  writeNotNull('@ServiceId', instance.serviceId);
  writeNotNull('@Account', instance.account);
  writeNotNull('Description', instance.description);
  return val;
}

Description _$DescriptionFromJson(Map<String, dynamic> json) => Description(
      evalue: json['evalue'] as String,
      value: json['@Value'] as String,
    );

Map<String, dynamic> _$DescriptionToJson(Description instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Value': instance.value,
    };
