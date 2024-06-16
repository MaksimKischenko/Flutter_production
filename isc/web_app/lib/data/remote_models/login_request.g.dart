// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomLoginRequestWrapper _$MdomLoginRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomLoginRequestWrapper(
      MdomLoginRequest.fromJson(json['UserRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomLoginRequestWrapperToJson(
        MdomLoginRequestWrapper instance) =>
    <String, dynamic>{
      'UserRequest': instance.userRequest,
    };

MdomLoginRequest _$MdomLoginRequestFromJson(Map<String, dynamic> json) =>
    MdomLoginRequest(
      requestType: json['RequestType'] as String,
      terminalId: json['TerminalId'] as String?,
      tokenRecord: json['TokenRecord'] == null
          ? null
          : MdomTokenRecord.fromJson(
              json['TokenRecord'] as Map<String, dynamic>),
      version: json['Version'] as String?,
      login: json['Login'] == null
          ? null
          : MdomLogin.fromJson(json['Login'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomLoginRequestToJson(MdomLoginRequest instance) {
  final val = <String, dynamic>{
    'RequestType': instance.requestType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('TerminalId', instance.terminalId);
  writeNotNull('TokenRecord', instance.tokenRecord);
  writeNotNull('Version', instance.version);
  writeNotNull('Login', instance.login);
  return val;
}
