import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'get_pay_list_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetPayListResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Token')
  final String? token;

  @JsonKey(name: 'PayRecord')
  final List<PayRecordResponse>? payRecord;

  const GetPayListResponse({
    this.errorCode,
    this.errorText,
    this.token,
    this.payRecord
  });

  factory GetPayListResponse.fromJson(Map<String, dynamic> json) => _$GetPayListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListResponseToJson(this);
  
}
