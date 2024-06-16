import 'package:json_annotation/json_annotation.dart';

part 'get_user_profile_request.g.dart';

@JsonSerializable()
class PsEripGetUserProfileRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripGetUserProfileRequest psErip;

  const PsEripGetUserProfileRequestWrapper(this.psErip);

  factory PsEripGetUserProfileRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripGetUserProfileRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetUserProfileRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripGetUserProfileRequest {

  @JsonKey(name: 'GetUserProfileRequest')
  final GetUserProfileRequest request;

  const PsEripGetUserProfileRequest(this.request);

  factory PsEripGetUserProfileRequest.fromJson(Map<String, dynamic> json) => _$PsEripGetUserProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetUserProfileRequestToJson(this);
  
}

@JsonSerializable()
class GetUserProfileRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  const GetUserProfileRequest({
    required this.terminalId,
    required this.version,
  });

  factory GetUserProfileRequest.fromJson(Map<String, dynamic> json) => _$GetUserProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileRequestToJson(this);
  
}