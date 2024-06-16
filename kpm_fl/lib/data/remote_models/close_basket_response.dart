import 'package:json_annotation/json_annotation.dart';

import 'package:kpm_fl/data/remote_models/komplat_general_elements.dart';

part 'close_basket_response.g.dart';

@JsonSerializable()
class PsEripCloseBasketResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripCloseBasketResponse psErip;

  const PsEripCloseBasketResponseWrapper(this.psErip);

  factory PsEripCloseBasketResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripCloseBasketResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripCloseBasketResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripCloseBasketResponse {

  @JsonKey(name: 'CloseBasketResponse')
  final CloseBasketResponse response;

  const PsEripCloseBasketResponse(this.response);

  factory PsEripCloseBasketResponse.fromJson(Map<String, dynamic> json) => _$PsEripCloseBasketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripCloseBasketResponseToJson(this);
}

@JsonSerializable()
class CloseBasketResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'PrinterExists')
  final int? printerExists;

  @JsonKey(name: 'Check')
  final CheckResponse? check;

  const CloseBasketResponse({
    this.errorCode,
    this.errorText,
    this.printerExists,
    this.check,
  });

  factory CloseBasketResponse.fromJson(Map<String, dynamic> json) => _$CloseBasketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CloseBasketResponseToJson(this);
  
}
