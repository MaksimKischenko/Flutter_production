import 'package:helppay_core/data/remote_models/mdom_base_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_response.g.dart';

@JsonSerializable()
class MdomCreateResponseWrapper {

  @JsonKey(name: 'UserResponse')
  final MdomCreateResponse userResponse;

  MdomCreateResponseWrapper(this.userResponse);

  factory MdomCreateResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomCreateResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCreateResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomCreateResponse {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomErrorCode errorCode;

  @JsonKey(name: 'Token')
  final MdomToken? token;

  @JsonKey(name: 'Params')
  final MdomResponseParams? params;

  @JsonKey(name: 'Lookups')
  final MdomLookups? lookups;

  const MdomCreateResponse({
    required this.requestType,
    required this.errorCode,
    required this.token,
    this.params,
    this.lookups
  });

  factory MdomCreateResponse.fromJson(Map<String, dynamic> json) => _$MdomCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCreateResponseToJson(this);
  
}