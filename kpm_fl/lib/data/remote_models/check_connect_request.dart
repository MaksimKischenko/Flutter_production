import 'package:json_annotation/json_annotation.dart';

part 'check_connect_request.g.dart';

@JsonSerializable()
class PsMtCheckConnectRequestWrapper {

  @JsonKey(name: 'PS_MT')
  final PsMtCheckConnectRequest psMt;

  const PsMtCheckConnectRequestWrapper(this.psMt);

  factory PsMtCheckConnectRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsMtCheckConnectRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsMtCheckConnectRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsMtCheckConnectRequest {

  @JsonKey(name: 'CheckConnectRequest')
  final CheckConnectRequest request;

  const PsMtCheckConnectRequest(this.request);

  factory PsMtCheckConnectRequest.fromJson(Map<String, dynamic> json) => _$PsMtCheckConnectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsMtCheckConnectRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class CheckConnectRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  // @JsonKey(name: 'Token')
  // final String? token;

  @JsonKey(name: 'ResultUpdate')
  final int? resultUpdate;

  @JsonKey(name: 'Ip')
  final String? ip;

  const CheckConnectRequest({
    required this.terminalId,
    required this.version,
    // this.token,
    this.resultUpdate,
    this.ip,
  });

  factory CheckConnectRequest.fromJson(Map<String, dynamic> json) => _$CheckConnectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckConnectRequestToJson(this);
  
}
