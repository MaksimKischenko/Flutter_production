// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'payment_atrr_request.g.dart';

@JsonSerializable()
class PaymentAtrrRequest {

  @JsonKey(name: 'p_source_id')
  final int sourceId;

  @JsonKey(name: 'p_payment_id')
  final int? paymentId;

  const PaymentAtrrRequest({
    required this.sourceId,
    required this.paymentId,
  });


  factory PaymentAtrrRequest.fromJson(Map<String, dynamic> json) => _$PaymentAtrrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentAtrrRequestToJson(this);
  
}
