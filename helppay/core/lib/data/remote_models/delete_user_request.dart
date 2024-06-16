import 'package:json_annotation/json_annotation.dart';

part 'delete_user_request.g.dart';

@JsonSerializable()
class MdomDeleteUserRequestWrapper {
  @JsonKey(name: 'UserRequest')
  final MdomDeleteUserRequest userRequest;

  MdomDeleteUserRequestWrapper(this.userRequest);

  factory MdomDeleteUserRequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$MdomDeleteUserRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomDeleteUserRequestWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MdomDeleteUserRequest {
  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'Login')
  final String? login;

  @JsonKey(name: 'UserId')
  final int? userId;

  MdomDeleteUserRequest({
    this.requestType = 'DeleteUser',
    required this.terminalId,
    required this.version,
    required this.token,
    this.lang,
    this.userId,
    this.login,
  });

  factory MdomDeleteUserRequest.fromJson(Map<String, dynamic> json) =>
      _$MdomDeleteUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomDeleteUserRequestToJson(this);
}
