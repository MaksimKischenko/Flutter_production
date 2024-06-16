// ignore_for_file: always_put_required_named_parameters_first

import 'package:json_annotation/json_annotation.dart';

part 'services_list_response.g.dart';

@JsonSerializable()
class PsTpOServicesListResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOServicesListResponse psTpO;

  PsTpOServicesListResponseWrapper(this.psTpO);

  factory PsTpOServicesListResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOServicesListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOServicesListResponseWrapperToJson(this);

}

@JsonSerializable()
class PsTpOServicesListResponse {

  @JsonKey(name: 'ServicesListResponse')
  final ServicesListResponse response;

  PsTpOServicesListResponse(this.response);

  factory PsTpOServicesListResponse.fromJson(Map<String, dynamic> json) => _$PsTpOServicesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOServicesListResponseToJson(this);
  
}

@JsonSerializable()
class ServicesListResponse {

  @JsonKey(name: 'Service')
  final List<Service>? services;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  ServicesListResponse({
    this.services,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText
  });

  factory ServicesListResponse.fromJson(Map<String, dynamic> json) => _$ServicesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesListResponseToJson(this);
  
}

@JsonSerializable()
class Service {

  @JsonKey(name: 'ServiceCode')
  final int? code;

  @JsonKey(name: 'ServiceCodeRasvikom')
  final int codeRasvikom;

  @JsonKey(name: 'ServiceName')
  final String name;

  @JsonKey(name: 'ItemUnit')
  final String? itemUnit;

  @JsonKey(name: 'NeedDevice')
  final int? needDevice;

  @JsonKey(name: 'NeedGenerateAccNum')
  final int? needGenerateAccNum;

  @JsonKey(name: 'ClaimSumMax')
  final double? claimSumMax;

  Service({
    required this.code,
    required this.codeRasvikom,
    required this.name,
    this.itemUnit,
    this.needDevice,
    this.needGenerateAccNum,
    this.claimSumMax
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
  
}