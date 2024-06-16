// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_helppay_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteHelpPayRequestWrapper _$DeleteHelpPayRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    DeleteHelpPayRequestWrapper(
      PSHelpPayDeleteRequest.fromJson(
          json['PSHelpPayRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeleteHelpPayRequestWrapperToJson(
        DeleteHelpPayRequestWrapper instance) =>
    <String, dynamic>{
      'PSHelpPayRequest': instance.request,
    };

PSHelpPayDeleteRequest _$PSHelpPayDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    PSHelpPayDeleteRequest(
      DeleteHelpPayRequest.fromJson(
          json['DeleteHelpPaySessionRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PSHelpPayDeleteRequestToJson(
        PSHelpPayDeleteRequest instance) =>
    <String, dynamic>{
      'DeleteHelpPaySessionRequest': instance.request,
    };

DeleteHelpPayRequest _$DeleteHelpPayRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteHelpPayRequest(
      login: json['LoginName'] as String,
      password: json['Password'] as String,
      token: json['SessionToken'] as String?,
    );

Map<String, dynamic> _$DeleteHelpPayRequestToJson(
    DeleteHelpPayRequest instance) {
  final val = <String, dynamic>{
    'LoginName': instance.login,
    'Password': instance.password,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SessionToken', instance.token);
  return val;
}
