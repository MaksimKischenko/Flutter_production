// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_helppay_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitHelpPayResponseWrapper _$InitHelpPayResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    InitHelpPayResponseWrapper(
      PSHelpPayResponse.fromJson(
          json['PSHelpPayResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InitHelpPayResponseWrapperToJson(
        InitHelpPayResponseWrapper instance) =>
    <String, dynamic>{
      'PSHelpPayResponse': instance.psHelppay,
    };

PSHelpPayResponse _$PSHelpPayResponseFromJson(Map<String, dynamic> json) =>
    PSHelpPayResponse(
      json['InitHelpPayResponse'] == null
          ? null
          : InitHelpPayResponse.fromJson(
              json['InitHelpPayResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PSHelpPayResponseToJson(PSHelpPayResponse instance) =>
    <String, dynamic>{
      'InitHelpPayResponse': instance.response,
    };

InitHelpPayResponse _$InitHelpPayResponseFromJson(Map<String, dynamic> json) =>
    InitHelpPayResponse(
      helpPayURI: json['HelpPayURI'] as String?,
      sessionToken: json['SessionToken'] as String?,
      servicesWrapper: json['Services'] == null
          ? null
          : ServiceWrapper.fromJson(json['Services'] as Map<String, dynamic>),
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$InitHelpPayResponseToJson(InitHelpPayResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('HelpPayURI', instance.helpPayURI);
  writeNotNull('SessionToken', instance.sessionToken);
  writeNotNull('Services', instance.servicesWrapper);
  val['ErrorCode'] = instance.errorCode;
  writeNotNull('ErrorText', instance.errorText);
  return val;
}

ServiceWrapper _$ServiceWrapperFromJson(Map<String, dynamic> json) =>
    ServiceWrapper(
      services: (json['Service'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceWrapperToJson(ServiceWrapper instance) =>
    <String, dynamic>{
      'Service': instance.services,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['@Id'] as int,
      name: json['@Name'] as String,
      groupServiceCode: json['@GroupServiceCode'] as int,
      pictureURL: json['@PictureURL'] as String?,
      nodeType: json['@Type'] as int?,
      description: json['Attr745'] == null
          ? null
          : Attr745.fromJson(json['Attr745'] as Map<String, dynamic>),
      supplierName: json['@SupplierName'] as String?,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) {
  final val = <String, dynamic>{
    '@Id': instance.id,
    '@Name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@Type', instance.nodeType);
  val['@GroupServiceCode'] = instance.groupServiceCode;
  writeNotNull('@PictureURL', instance.pictureURL);
  writeNotNull('@SupplierName', instance.supplierName);
  writeNotNull('Attr745', instance.description);
  return val;
}

Attr745 _$Attr745FromJson(Map<String, dynamic> json) => Attr745(
      type: json['@Type'] as int?,
      name: json['@Name'] as String,
      minLength: json['@MinLength'] as int?,
      maxLength: json['@MaxLength'] as int?,
      hint: json['@Hint'] as String?,
    );

Map<String, dynamic> _$Attr745ToJson(Attr745 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@Type', instance.type);
  val['@Name'] = instance.name;
  writeNotNull('@MinLength', instance.minLength);
  writeNotNull('@MaxLength', instance.maxLength);
  writeNotNull('@Hint', instance.hint);
  return val;
}
