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

  const InformationRequest({
    required this.version,
    required this.key,
    required this.token,
    required this.terminalId,
  });

  factory InformationRequest.fromJson(Map<String, dynamic> json) => _$InformationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InformationRequestToJson(this);
  
}
