import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'get_pay_list_response.g.dart';

@JsonSerializable()
class PsEripGetPayListResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripGetPayListResponse psErip;

  const PsEripGetPayListResponseWrapper(this.psErip);

  factory PsEripGetPayListResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripGetPayListResponse {

  @JsonKey(name: 'GetPayListResponse')
  final GetPayListResponse response;

  const PsEripGetPayListResponse(this.response);

  factory PsEripGetPayListResponse.fromJson(Map<String, dynamic> json) => _$PsEripGetPayListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetPayListResponseToJson(this);
}


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
