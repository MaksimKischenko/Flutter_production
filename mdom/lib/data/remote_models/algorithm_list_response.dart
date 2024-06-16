import 'package:json_annotation/json_annotation.dart';

part 'algorithm_list_response.g.dart';

@JsonSerializable()
class PsTpOAlgorithmListResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOAlgorithmListResponse psTpO;

  PsTpOAlgorithmListResponseWrapper(this.psTpO);

  factory PsTpOAlgorithmListResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOAlgorithmListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAlgorithmListResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpOAlgorithmListResponse {

  @JsonKey(name: 'AlgorithmListResponse')
  final AlgorithmListResponse response;

  PsTpOAlgorithmListResponse(this.response);

  factory PsTpOAlgorithmListResponse.fromJson(Map<String, dynamic> json) => _$PsTpOAlgorithmListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAlgorithmListResponseToJson(this);
}

@JsonSerializable()
class AlgorithmListResponse {

  @JsonKey(name: 'Algorithm')
  final List<ServiceAlgorithm>? algorithms;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  AlgorithmListResponse({
    required this.algorithms,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory AlgorithmListResponse.fromJson(Map<String, dynamic> json) => _$AlgorithmListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlgorithmListResponseToJson(this);
  
}

@JsonSerializable()
class ServiceAlgorithm {

  @JsonKey(name: '@Id')
  final int id;

  @JsonKey(name: '@Name')
  final String name;

  ServiceAlgorithm({
    required this.id,
    required this.name,
  });

  factory ServiceAlgorithm.fromJson(Map<String, dynamic> json) => _$ServiceAlgorithmFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceAlgorithmToJson(this);
  
}