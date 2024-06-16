import 'package:json_annotation/json_annotation.dart';

part 'open_basket_request.g.dart';

@JsonSerializable()
class PsEripOpenBasketRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripOpenBasketRequest psErip;

  const PsEripOpenBasketRequestWrapper(this.psErip);

  factory PsEripOpenBasketRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripOpenBasketRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripOpenBasketRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripOpenBasketRequest {

  @JsonKey(name: 'OpenBasketRequest')
  final OpenBasketRequest request;

  const PsEripOpenBasketRequest(this.request);

  factory PsEripOpenBasketRequest.fromJson(Map<String, dynamic> json) => _$PsEripOpenBasketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripOpenBasketRequestToJson(this);
  
}

@JsonSerializable()
class OpenBasketRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'ClientInfo')
  final ClientInfo? clientInfo;


  const OpenBasketRequest({
    required this.terminalId,
    required this.version,
    this.clientInfo,

  });

  factory OpenBasketRequest.fromJson(Map<String, dynamic> json) => _$OpenBasketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OpenBasketRequestToJson(this);
  
}

@JsonSerializable()
class ClientInfo {

  @JsonKey(name: '@ID')
  final String? id;

  @JsonKey(name: '@IdType')
  final String? idType;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@UNP')
  final String? unp;

  const ClientInfo({
    this.id,
    this.idType,
    this.name,
    this.unp
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) => _$ClientInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ClientInfoToJson(this);
  
}
