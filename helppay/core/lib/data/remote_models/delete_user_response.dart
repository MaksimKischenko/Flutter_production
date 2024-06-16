import 'package:helppay_core/data/remote_models/mdom_base_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_user_response.g.dart';

@JsonSerializable()
class MdomDeleteUserResponseWrapper {
  @JsonKey(name: 'UserResponse')
  final MdomDeleteUserResponse userResponse;

  MdomDeleteUserResponseWrapper(this.userResponse);

  factory MdomDeleteUserResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$MdomDeleteUserResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomDeleteUserResponseWrapperToJson(this);
}

@JsonSerializable()
class MdomDeleteUserResponse {
  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomErrorCode errorCode;

  @JsonKey(name: 'Token')
  final MdomToken? token;

  const MdomDeleteUserResponse(
      {required this.requestType,
      required this.errorCode,
      required this.token});

  factory MdomDeleteUserResponse.fromJson(Map<String, dynamic> json) =>
      _$MdomDeleteUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomDeleteUserResponseToJson(this);
}
