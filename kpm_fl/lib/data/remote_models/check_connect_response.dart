import 'package:json_annotation/json_annotation.dart';

part 'check_connect_response.g.dart';

@JsonSerializable()
class PsMtCheckConnectResponseWrapper {

  @JsonKey(name: 'PS_MT')
  final PsMtCheckConnectResponse psMt;

  const PsMtCheckConnectResponseWrapper(this.psMt);

  factory PsMtCheckConnectResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsMtCheckConnectResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsMtCheckConnectResponseWrapperToJson(this);
}

@JsonSerializable()
class PsMtCheckConnectResponse {

  @JsonKey(name: 'CheckConnectResponse')
  final CheckConnectResponse response;

  const PsMtCheckConnectResponse(this.response);

  factory PsMtCheckConnectResponse.fromJson(Map<String, dynamic> json) => _$PsMtCheckConnectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsMtCheckConnectResponseToJson(this);
}

@JsonSerializable()
class CheckConnectResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'NextRequest')
  final String? nextRequest;

  @JsonKey(name: 'DateTimeServer')
  final String? date;

  const CheckConnectResponse({
    this.errorCode,
    this.errorText,
    this.nextRequest,
    this.date,
  });

  factory CheckConnectResponse.fromJson(Map<String, dynamic> json) => _$CheckConnectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckConnectResponseToJson(this);
  
}
