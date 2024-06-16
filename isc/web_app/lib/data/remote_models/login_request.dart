// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:isc_web_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class MdomLoginRequestWrapper {
  @JsonKey(name: 'UserRequest')
  final MdomLoginRequest userRequest;

  MdomLoginRequestWrapper(this.userRequest);

  factory MdomLoginRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomLoginRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginRequestWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MdomLoginRequest {
  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'TerminalId')
  final String? terminalId;

  @JsonKey(name: 'TokenRecord')
  final MdomTokenRecord? tokenRecord;

  @JsonKey(name: 'Version')
  final String? version; 

  @JsonKey(name: 'Login')
  final MdomLogin? login;

  MdomLoginRequest({
    required this.requestType,
    this.terminalId,
    this.tokenRecord,
    this.version,
    this.login,
  });


  factory MdomLoginRequest.fromJson(Map<String, dynamic> json) => _$MdomLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginRequestToJson(this);
}
