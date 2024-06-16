// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_helppay_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteHelpPayResponseWrapper _$DeleteHelpPayResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    DeleteHelpPayResponseWrapper(
      json['PSHelpPayResponse'] == null
          ? null
          : PSHelpPayDeleteResponse.fromJson(
              json['PSHelpPayResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeleteHelpPayResponseWrapperToJson(
        DeleteHelpPayResponseWrapper instance) =>
    <String, dynamic>{
      'PSHelpPayResponse': instance.psHelppay,
    };

PSHelpPayDeleteResponse _$PSHelpPayDeleteResponseFromJson(
        Map<String, dynamic> json) =>
    PSHelpPayDeleteResponse(
      json['DeleteHelpPaySessionResponse'] == null
          ? null
          : DeleteHelpPayResponse.fromJson(
              json['DeleteHelpPaySessionResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PSHelpPayDeleteResponseToJson(
        PSHelpPayDeleteResponse instance) =>
    <String, dynamic>{
      'DeleteHelpPaySessionResponse': instance.response,
    };

DeleteHelpPayResponse _$DeleteHelpPayResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteHelpPayResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$DeleteHelpPayResponseToJson(
    DeleteHelpPayResponse instance) {
  final val = <String, dynamic>{
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  return val;
}
