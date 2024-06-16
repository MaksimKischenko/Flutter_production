// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripUserProfileResponseWrapper _$PsEripUserProfileResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripUserProfileResponseWrapper(
      PsEripUserProfileResponse.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripUserProfileResponseWrapperToJson(
        PsEripUserProfileResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripUserProfileResponse _$PsEripUserProfileResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripUserProfileResponse(
      GetUserProfileResponse.fromJson(
          json['GetUserProfileResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripUserProfileResponseToJson(
        PsEripUserProfileResponse instance) =>
    <String, dynamic>{
      'GetUserProfileResponse': instance.response,
    };

GetUserProfileResponse _$GetUserProfileResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserProfileResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      screens: (json['Screen'] as List<dynamic>?)
          ?.map((e) =>
              GetUserProfileScreenItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserProfileResponseToJson(
        GetUserProfileResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'Screen': instance.screens,
    };

GetUserProfileScreenItem _$GetUserProfileScreenItemFromJson(
        Map<String, dynamic> json) =>
    GetUserProfileScreenItem(
      idx: json['@Idx'] as int?,
      objects: (json['Object'] as List<dynamic>?)
          ?.map((e) => GetUserProfileScreenItemObject.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserProfileScreenItemToJson(
        GetUserProfileScreenItem instance) =>
    <String, dynamic>{
      '@Idx': instance.idx,
      'Object': instance.objects,
    };

GetUserProfileScreenItemObject _$GetUserProfileScreenItemObjectFromJson(
        Map<String, dynamic> json) =>
    GetUserProfileScreenItemObject(
      idx: json['@Idx'] as int?,
      text: json['@Text'] as String?,
      url: json['@URL'] as String?,
    );

Map<String, dynamic> _$GetUserProfileScreenItemObjectToJson(
        GetUserProfileScreenItemObject instance) =>
    <String, dynamic>{
      '@Idx': instance.idx,
      '@Text': instance.text,
      '@URL': instance.url,
    };
