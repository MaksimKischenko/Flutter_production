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

  // general part

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  // general part END

  @JsonKey(name: 'ServiceCode')
  final int serviceCode;

  AlgorithmListRequest({
    required this.version,
    required this.key,
    required this.token,
    required this.terminalId,
    required this.serviceCode,
  });

  factory AlgorithmListRequest.fromJson(Map<String, dynamic> json) => _$AlgorithmListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AlgorithmListRequestToJson(this);
  
}
