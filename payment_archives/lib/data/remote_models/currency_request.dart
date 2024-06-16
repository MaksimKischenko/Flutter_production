// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'currency_request.g.dart';

@JsonSerializable()
class CurrencyRequest {

  @JsonKey(name: 'p_sum')
  final double paySumm;

  @JsonKey(name: 'p_currency')
  final int? payCurrency;

  const CurrencyRequest({
    required this.paySumm,
    required this.payCurrency,
  });


  factory CurrencyRequest.fromJson(Map<String, dynamic> json) => _$CurrencyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyRequestToJson(this);
  
}
