
import 'package:isc_web_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class MdomLoginResponseWrapper {

  @JsonKey(name: 'UserResponse')
  final MdomLoginResponse userResponse;

  MdomLoginResponseWrapper(this.userResponse);

  factory MdomLoginResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomLoginResponse {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomErrorCode errorCode;

  @JsonKey(name: 'Token')
  final MdomToken? token;
  
  @JsonKey(name: 'Params')
  final MdomResponseParams? params;

  const MdomLoginResponse({
    required this.requestType,
    required this.errorCode,
    required this.token,
    this.params,
  });

  factory MdomLoginResponse.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseToJson(this);
}
