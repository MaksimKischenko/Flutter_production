
import 'package:json_annotation/json_annotation.dart';

part 'delete_helppay_session_request.g.dart';


@JsonSerializable()
class DeleteHelpPayRequestWrapper {

  @JsonKey(name: 'PSHelpPayRequest')
  final PSHelpPayDeleteRequest request;

  DeleteHelpPayRequestWrapper(this.request);

  factory DeleteHelpPayRequestWrapper.fromJson(Map<String, dynamic> json) => _$DeleteHelpPayRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteHelpPayRequestWrapperToJson(this);
}


@JsonSerializable()
class PSHelpPayDeleteRequest {

  @JsonKey(name: 'DeleteHelpPaySessionRequest')
  final DeleteHelpPayRequest request;

  PSHelpPayDeleteRequest(this.request);

  factory PSHelpPayDeleteRequest.fromJson(Map<String, dynamic> json) => _$PSHelpPayDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PSHelpPayDeleteRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class DeleteHelpPayRequest {

  @JsonKey(name: 'LoginName')
  final String login;

  @JsonKey(name: 'Password')
  final String password;

  @JsonKey(name: 'SessionToken')
  final String? token;

  DeleteHelpPayRequest({
    required this.login,
    required this.password,
    this.token,
  });


  factory DeleteHelpPayRequest.fromJson(Map<String, dynamic> json) => _$DeleteHelpPayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteHelpPayRequestToJson(this);
}
