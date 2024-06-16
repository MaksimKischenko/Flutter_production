import 'package:json_annotation/json_annotation.dart';

part 'information_request.g.dart';

@JsonSerializable()
class PsTpOInformationRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOInformationRequest psTpO;

  PsTpOInformationRequestWrapper(this.psTpO);

  factory PsTpOInformationRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOInformationRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOInformationRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOInformationRequest {

  @JsonKey(name: 'InformationRequest')
  final InformationRequest request;

  PsTpOInformationRequest(this.request);

  factory PsTpOInformationRequest.fromJson(Map<String, dynamic> json) => _$PsTpOInformationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOInformationRequestToJson(this);
  
}

@JsonSerializable()
class InformationRequest {

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  InformationRequest({
    required this.token,
    required this.version,
    required this.key,
  });

  factory InformationRequest.fromJson(Map<String, dynamic> json) => _$InformationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InformationRequestToJson(this);
  
}
