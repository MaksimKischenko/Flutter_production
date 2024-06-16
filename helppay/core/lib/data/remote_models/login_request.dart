import 'package:helppay_core/data/remote_models/mdom_base_models.dart';
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

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'TokenRecord')
  final MdomTokenRecord? tokenRecord;

  @JsonKey(name: 'Login')
  final MdomLogin? login;

  MdomLoginRequest({
    this.requestType = 'Login',
    this.lang,
    this.tokenRecord,
    this.login
  });

  factory MdomLoginRequest.fromJson(Map<String, dynamic> json) => _$MdomLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginRequestToJson(this);
  
}