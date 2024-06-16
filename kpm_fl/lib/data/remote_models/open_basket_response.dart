import 'package:json_annotation/json_annotation.dart';

part 'open_basket_response.g.dart';

@JsonSerializable()
class PsEripOpenBasketResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripOpenBasketResponse psErip;

  const PsEripOpenBasketResponseWrapper(this.psErip);

  factory PsEripOpenBasketResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripOpenBasketResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripOpenBasketResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripOpenBasketResponse {

  @JsonKey(name: 'OpenBasketResponse')
  final OpenBasketResponse response;

  const PsEripOpenBasketResponse(this.response);

  factory PsEripOpenBasketResponse.fromJson(Map<String, dynamic> json) => _$PsEripOpenBasketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripOpenBasketResponseToJson(this);
}

@JsonSerializable()
class OpenBasketResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'BarCode')
  final String? barcode;

  @JsonKey(name: 'KioskReceipt')
  final String? kioskReceipt;

  const OpenBasketResponse({
    this.errorCode,
    this.errorText,
    this.barcode,
    this.kioskReceipt,
  });

  factory OpenBasketResponse.fromJson(Map<String, dynamic> json) => _$OpenBasketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OpenBasketResponseToJson(this);
  
}
