import 'package:helppay_core/data/remote_models/mdom_base_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_user_response.g.dart';

@JsonSerializable()
class MdomEditUserResponseWrapper {

  @JsonKey(name: 'UserResponse')
  final MdomEditUserResponse userResponse;

  MdomEditUserResponseWrapper(this.userResponse);

  factory MdomEditUserResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomEditUserResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomEditUserResponse {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomErrorCode errorCode;

  @JsonKey(name: 'Token')
  final MdomToken? token;

  const MdomEditUserResponse({
    required this.requestType,
    required this.errorCode,
    required this.token
  });

  factory MdomEditUserResponse.fromJson(Map<String, dynamic> json) => _$MdomEditUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserResponseToJson(this);
  
}