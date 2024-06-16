import 'package:json_annotation/json_annotation.dart';

part 'init_helppay_response.g.dart';

@JsonSerializable()
class InitHelpPayResponseWrapper {
  @JsonKey(name: 'PSHelpPayResponse')
  final PSHelpPayResponse psHelppay;

  InitHelpPayResponseWrapper(this.psHelppay);

  factory InitHelpPayResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$InitHelpPayResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$InitHelpPayResponseWrapperToJson(this);
}

@JsonSerializable()
class PSHelpPayResponse {
  @JsonKey(name: 'InitHelpPayResponse')
  final InitHelpPayResponse? response;

  PSHelpPayResponse(this.response);

  factory PSHelpPayResponse.fromJson(Map<String, dynamic> json) =>
      _$PSHelpPayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PSHelpPayResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class InitHelpPayResponse {
  @JsonKey(name: 'HelpPayURI')
  final String? helpPayURI;

  @JsonKey(name: 'SessionToken')
  final String? sessionToken;

  @JsonKey(name: 'Services')
  final ServiceWrapper? servicesWrapper;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  InitHelpPayResponse({
    this.helpPayURI,
    required this.sessionToken,
    required this.servicesWrapper,
    required this.errorCode,
    this.errorText,
  });

  factory InitHelpPayResponse.fromJson(Map<String, dynamic> json) =>
      _$InitHelpPayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitHelpPayResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ServiceWrapper {
  @JsonKey(name: 'Service')
  final List<Service> services;

  ServiceWrapper({
    required this.services,
  });

  factory ServiceWrapper.fromJson(Map<String, dynamic> json) =>
      _$ServiceWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Service {
  @JsonKey(name: '@Id')
  final int id;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Type')
  final int?
      nodeType; //1-sevice or 2-node and on press we send new initHelppayRequest

  @JsonKey(name: '@GroupServiceCode')
  final int groupServiceCode;

  @JsonKey(name: '@PictureURL')
  final String? pictureURL;
  @JsonKey(name: '@SupplierName')
  final String? supplierName;

  @JsonKey(name: 'Attr745')
  final Attr745? description;

  Service({
    required this.id,
    required this.name,
    required this.groupServiceCode,
    this.pictureURL,
    this.nodeType,
    this.description,
    this.supplierName,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Attr745 {
  @JsonKey(name: '@Type')
  final int? type;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@MinLength')
  final int? minLength;

  @JsonKey(name: '@MaxLength')
  final int? maxLength;

  @JsonKey(name: '@Hint')
  final String? hint;

  Attr745({
    this.type,
    required this.name,
    this.minLength,
    this.maxLength,
    this.hint,
  });

  factory Attr745.fromJson(Map<String, dynamic> json) =>
      _$Attr745FromJson(json);

  Map<String, dynamic> toJson() => _$Attr745ToJson(this);
}
