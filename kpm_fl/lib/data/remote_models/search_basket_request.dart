import 'package:json_annotation/json_annotation.dart';

part 'search_basket_request.g.dart';

@JsonSerializable()
class PsEripSearchBasketRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripSearchBasketRequest psErip;

  const PsEripSearchBasketRequestWrapper(this.psErip);

  factory PsEripSearchBasketRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripSearchBasketRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripSearchBasketRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripSearchBasketRequest {

  @JsonKey(name: 'SearchBasketRequest')
  final SearchBasketRequest request;

  const PsEripSearchBasketRequest(this.request);

  factory PsEripSearchBasketRequest.fromJson(Map<String, dynamic> json) => _$PsEripSearchBasketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripSearchBasketRequestToJson(this);
  
}

@JsonSerializable()
class SearchBasketRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  // @JsonKey(name: 'Token')
  // final String? token;

  @JsonKey(name: 'BarCode')
  final String barcode;

  const SearchBasketRequest({
    required this.terminalId,
    required this.version,
    // required this.token,
    required this.barcode,
  });

  factory SearchBasketRequest.fromJson(Map<String, dynamic> json) => _$SearchBasketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBasketRequestToJson(this);
  
}