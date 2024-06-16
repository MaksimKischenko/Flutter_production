import 'package:json_annotation/json_annotation.dart';

part 'close_basket_request.g.dart';

@JsonSerializable()
class PsEripCloseBasketRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripCloseBasketRequest psErip;

  const PsEripCloseBasketRequestWrapper(this.psErip);

  factory PsEripCloseBasketRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripCloseBasketRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripCloseBasketRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripCloseBasketRequest {

  @JsonKey(name: 'CloseBasketRequest')
  final CloseBasketRequest request;

  const PsEripCloseBasketRequest(this.request);

  factory PsEripCloseBasketRequest.fromJson(Map<String, dynamic> json) => _$PsEripCloseBasketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripCloseBasketRequestToJson(this);
  
}

@JsonSerializable()
class CloseBasketRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'BarCode')
  final String? barcode;

  // @JsonKey(name: 'Lang')
  // final Lang lang;

  const CloseBasketRequest({
    required this.terminalId,
    required this.version,
    this.barcode,
    // required this.lang,
  });

  factory CloseBasketRequest.fromJson(Map<String, dynamic> json) => _$CloseBasketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CloseBasketRequestToJson(this);
  
}