import 'package:json_annotation/json_annotation.dart';

part 'account_registration_request.g.dart';

@JsonSerializable()
class MdomAccountRegistrationRequestWrapper {
  @JsonKey(name: 'TPInfoRequest')
  final MdomAccountRegistrationRequest request;

  MdomAccountRegistrationRequestWrapper(this.request);

  factory MdomAccountRegistrationRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$MdomAccountRegistrationRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomAccountRegistrationRequestWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MdomAccountRegistrationRequest {
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

  @JsonKey(name: 'Account')
  final AccountRegistrationAccount account;

  MdomAccountRegistrationRequest(
      {required this.terminalId,
      required this.version,
      required this.token,
      this.lang,
      // ignore: always_put_required_named_parameters_first
      required this.account,
      this.requestType = 'AccountRegistration'});

  factory MdomAccountRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$MdomAccountRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomAccountRegistrationRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AccountRegistrationAccount {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@SupplierId')
  final int? supplierId;

  @JsonKey(name: '@isSendCodeSMS')
  final int? isSendCodeSMS;

  @JsonKey(name: '@isSendCodeEMail')
  final int? isSendCodeEMail;

  @JsonKey(name: '@CodeWord')
  final String? codeWord;

  AccountRegistrationAccount({
    required this.evalue,
    this.supplierId,
    this.isSendCodeSMS,
    this.isSendCodeEMail,
    // ignore: always_put_required_named_parameters_first
    required this.codeWord,
  });

  factory AccountRegistrationAccount.fromJson(Map<String, dynamic> json) =>
      _$AccountRegistrationAccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRegistrationAccountToJson(this);
}
