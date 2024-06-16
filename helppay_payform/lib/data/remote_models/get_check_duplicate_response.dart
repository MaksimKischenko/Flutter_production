import 'package:json_annotation/json_annotation.dart';

import 'komplat_general_elements.dart';

part 'get_check_duplicate_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetCheckDuplicateResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Token')
  final String? token;

  @JsonKey(name: 'Check')
  final CheckResponse? check;

  const GetCheckDuplicateResponse({
    this.errorCode,
    this.errorText,
    this.token,
    this.check
  });

  factory GetCheckDuplicateResponse.fromJson(Map<String, dynamic> json) => _$GetCheckDuplicateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCheckDuplicateResponseToJson(this);
  
}
