import 'package:json_annotation/json_annotation.dart';

part 'services_list_request.g.dart';

@JsonSerializable()
class PsTpOServicesListRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOServicesListRequest psTpO;

  PsTpOServicesListRequestWrapper(this.psTpO);

  factory PsTpOServicesListRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOServicesListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOServicesListRequestWrapperToJson(this);
}

@JsonSerializable()
class PsTpOServicesListRequest {

  @JsonKey(name: 'ServicesListRequest')
  final ServicesListRequest request;

  PsTpOServicesListRequest(this.request);

  factory PsTpOServicesListRequest.fromJson(Map<String, dynamic> json) => _$PsTpOServicesListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOServicesListRequestToJson(this);
  
}

@JsonSerializable()
class ServicesListRequest {

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'KeyRequest')
  final int key;

  ServicesListRequest({
    required this.version,
    required this.token,
    required this.key,
  });

  factory ServicesListRequest.fromJson(Map<String, dynamic> json) => _$ServicesListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesListRequestToJson(this);
  
}
