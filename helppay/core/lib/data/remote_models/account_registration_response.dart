import 'package:helppay_core/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_registration_response.g.dart';

@JsonSerializable()
class MdomAccountRegistrationResponseWrapper {

  @JsonKey(name: 'TPInfoResponse')
  final MdomAccountRegistrationResponse response;

  MdomAccountRegistrationResponseWrapper(this.response);

  factory MdomAccountRegistrationResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomAccountRegistrationResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomAccountRegistrationResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomAccountRegistrationResponse {

  @JsonKey(name: 'RequestType')
  final String? requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomTpInfoErrorCode? errorCode;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Account')
  final PropertyAccountAccount? account;

  @JsonKey(name: 'Params')
  final MdomTpInfoResponseParams? params;

  @JsonKey(name: 'Lookups')
  final MdomTpInfoLookups? lookups;

  const MdomAccountRegistrationResponse({
    this.requestType,
    this.errorCode,
    // ignore: always_put_required_named_parameters_first
    required this.token,
    this.account,
    this.params,
    this.lookups
  });

  factory MdomAccountRegistrationResponse.fromJson(Map<String, dynamic> json) => _$MdomAccountRegistrationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomAccountRegistrationResponseToJson(this);
  
}