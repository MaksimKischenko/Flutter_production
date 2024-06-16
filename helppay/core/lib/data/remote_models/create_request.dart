import 'package:helppay_core/data/remote_models/mdom_base_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_request.g.dart';

@JsonSerializable()
class MdomCreateRequestWrapper {

  @JsonKey(name: 'UserRequest')
  final MdomCreateRequest userRequest;

  MdomCreateRequestWrapper(this.userRequest);

  factory MdomCreateRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomCreateRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCreateRequestWrapperToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class MdomCreateRequest {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'Login')
  final MdomLogin login;

  @JsonKey(name: 'isSendCodeSMS')
  final MdomCreateRequestIsSendCodeSMS? isSendCodeSMS;

  @JsonKey(name: 'Action')
  final String action;

  @JsonKey(name: 'isSendCodeEMail')
  final int? isSendCodeEMail;

  @JsonKey(name: 'isOrganization')
  final MdomCreateUserIsOrganization? isOrganization;

  MdomCreateRequest({
    this.requestType = 'Create',
    this.lang,
    required this.login,
    this.isSendCodeSMS,
    this.action = 'OWN',
    this.isSendCodeEMail,
    this.isOrganization
  });

  factory MdomCreateRequest.fromJson(Map<String, dynamic> json) => _$MdomCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCreateRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class MdomCreateRequestIsSendCodeSMS {

  @JsonKey(name: 'evalue')
  final int? evalue;

  @JsonKey(name: '@Phone')
  final String? phone;

  MdomCreateRequestIsSendCodeSMS({
    this.evalue,
    this.phone
  });

  factory MdomCreateRequestIsSendCodeSMS.fromJson(Map<String, dynamic> json) => _$MdomCreateRequestIsSendCodeSMSFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCreateRequestIsSendCodeSMSToJson(this);

}

@JsonSerializable()
class MdomCreateUserIsOrganization {

  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@KeyRegistration')
  final String? keyRegistration;

  MdomCreateUserIsOrganization({
    required this.evalue,
    this.keyRegistration
  });

  factory MdomCreateUserIsOrganization.fromJson(Map<String, dynamic> json) => _$MdomCreateUserIsOrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCreateUserIsOrganizationToJson(this);
  
}