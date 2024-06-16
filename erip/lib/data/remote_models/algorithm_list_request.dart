import 'package:json_annotation/json_annotation.dart';

part 'algorithm_list_request.g.dart';

@JsonSerializable()
class PsTpOAlgorithmListRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOAlgorithmListRequest psTpO;

  PsTpOAlgorithmListRequestWrapper(this.psTpO);

  factory PsTpOAlgorithmListRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOAlgorithmListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAlgorithmListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOAlgorithmListRequest {

  @JsonKey(name: 'AlgorithmListRequest')
  final AlgorithmListRequest request;

  PsTpOAlgorithmListRequest(this.request);

  factory PsTpOAlgorithmListRequest.fromJson(Map<String, dynamic> json) => _$PsTpOAlgorithmListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAlgorithmListRequestToJson(this);
  
}

@JsonSerializable()
class AlgorithmListRequest {

  @JsonKey(name: 'ServiceCode')
  final int serviceCode;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  AlgorithmListRequest(this.serviceCode, this.token, this.version, this.key);

  factory AlgorithmListRequest.fromJson(Map<String, dynamic> json) => _$AlgorithmListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AlgorithmListRequestToJson(this);
  
}