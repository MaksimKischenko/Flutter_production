import 'package:json_annotation/json_annotation.dart';

part 'init_helppay_request.g.dart';

@JsonSerializable()
class InitHelpPayRequestWrapper {
  @JsonKey(name: 'PSHelpPayRequest')
  final PSHelpPayRequest request;

  InitHelpPayRequestWrapper(this.request);

  factory InitHelpPayRequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$InitHelpPayRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$InitHelpPayRequestWrapperToJson(this);
}

@JsonSerializable()
class PSHelpPayRequest {
  @JsonKey(name: 'InitHelpPayRequest')
  final InitHelpPayRequest request;

  PSHelpPayRequest(this.request);

  factory PSHelpPayRequest.fromJson(Map<String, dynamic> json) =>
      _$PSHelpPayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PSHelpPayRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class InitHelpPayRequest {
  @JsonKey(name: 'LoginName')
  final LoginName loginName;

  @JsonKey(name: 'Password')
  final String password;

  @JsonKey(name: 'ReturnURI')
  final String? returnURI;

  @JsonKey(name: 'ConfirmURI')
  final String confirmURI;

  @JsonKey(name: 'Mode')
  final String mode;

  @JsonKey(name: 'Node')
  final int? node;
  // ? Required if mode is "Node" and its must be Services/Service/@Id from InitHelpPayResponse

  @JsonKey(name: 'Payer')
  final Payer? payer;

  InitHelpPayRequest({
    required this.loginName,
    required this.password,
    this.returnURI,
    required this.confirmURI,
    required this.mode,
    this.node,
    this.payer,
  });

  factory InitHelpPayRequest.fromJson(Map<String, dynamic> json) =>
      _$InitHelpPayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InitHelpPayRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class LoginName {
  @JsonKey(name: 'evalue')
  final String value;

  @JsonKey(name: '@DeviceType')
  final String deviceType;

  LoginName({
    required this.value,
    required this.deviceType,
  });

  factory LoginName.fromJson(Map<String, dynamic> json) =>
      _$LoginNameFromJson(json);

  Map<String, dynamic> toJson() => _$LoginNameToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Payer {
  @JsonKey(name: '@PayerId')
  final String payerId;

  @JsonKey(name: '@MaxAmount')
  final double? maxAmount;

  @JsonKey(name: '@ServiceId')
  final int? serviceId;

  @JsonKey(name: '@Account')
  final String? account;

  @JsonKey(name: 'Description')
  final Description? description;

  Payer({
    required this.payerId,
    this.maxAmount,
    this.serviceId,
    this.account,
    this.description,
  });

  factory Payer.fromJson(Map<String, dynamic> json) => _$PayerFromJson(json);

  Map<String, dynamic> toJson() => _$PayerToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Description {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Value')
  final String value;

  Description({
    required this.evalue,
    required this.value,
  });

  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$DescriptionToJson(this);
}
