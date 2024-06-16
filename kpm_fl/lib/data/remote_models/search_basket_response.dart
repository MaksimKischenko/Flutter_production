import 'package:json_annotation/json_annotation.dart';

import 'package:kpm_fl/data/data.dart';

part 'search_basket_response.g.dart';

@JsonSerializable()
class PsEripSearchBasketResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripSearchBasketResponse psErip;

  const PsEripSearchBasketResponseWrapper(this.psErip);

  factory PsEripSearchBasketResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripSearchBasketResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripSearchBasketResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripSearchBasketResponse {

  @JsonKey(name: 'SearchBasketResponse')
  final SearchBasketResponse response;

  const PsEripSearchBasketResponse(this.response);

  factory PsEripSearchBasketResponse.fromJson(Map<String, dynamic> json) => _$PsEripSearchBasketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripSearchBasketResponseToJson(this);
}

@JsonSerializable()
class SearchBasketResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'BarCode')
  final String? barcode;

  @JsonKey(name: 'Status')
  final BasketStatus? status;

  @JsonKey(name: 'Check')
  final CheckResponse? check;

  @JsonKey(name: 'PayCodeRecord')
  final PayCodeRecordResponse? payCodeRecord;

  const SearchBasketResponse({
    this.errorCode,
    this.errorText,
    this.barcode,
    this.status,
    this.check,
    this.payCodeRecord,
  });

  factory SearchBasketResponse.fromJson(Map<String, dynamic> json) => _$SearchBasketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBasketResponseToJson(this);
  
}

enum BasketStatus {
  @JsonValue(1)
  opened,
  @JsonValue(2)
  closed,
  @JsonValue(3)
  paid
}

@JsonSerializable()
class PayCodeRecordResponse {

  @JsonKey(name: 'PayRecord')
  final List<PayRecordResponse>? payRecord;

  const PayCodeRecordResponse({
    this.payRecord
  });

  factory PayCodeRecordResponse.fromJson(Map<String, dynamic> json) => _$PayCodeRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayCodeRecordResponseToJson(this);
}