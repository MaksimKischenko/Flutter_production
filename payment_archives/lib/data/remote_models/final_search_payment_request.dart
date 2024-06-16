// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'final_search_payment_request.g.dart';

@JsonSerializable()
class FinalSearchPaymentRequest {

  @JsonKey(name: 'p_id')
  String? uuid;
  

  FinalSearchPaymentRequest({
    this.uuid,
  });

  factory FinalSearchPaymentRequest.fromJson(Map<String, dynamic> json) => _$FinalSearchPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FinalSearchPaymentRequestToJson(this);
  
}



