
import 'package:json_annotation/json_annotation.dart';

part 'delete_helppay_session_response.g.dart';


@JsonSerializable()
class DeleteHelpPayResponseWrapper {

  @JsonKey(name: 'PSHelpPayResponse')
  final PSHelpPayDeleteResponse? psHelppay;

  DeleteHelpPayResponseWrapper(this.psHelppay);

  factory DeleteHelpPayResponseWrapper.fromJson(Map<String, dynamic> json) => _$DeleteHelpPayResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteHelpPayResponseWrapperToJson(this);
}


@JsonSerializable()
class PSHelpPayDeleteResponse {

  @JsonKey(name: 'DeleteHelpPaySessionResponse')
  final DeleteHelpPayResponse? response;

  PSHelpPayDeleteResponse(this.response);

  factory PSHelpPayDeleteResponse.fromJson(Map<String, dynamic> json) => _$PSHelpPayDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PSHelpPayDeleteResponseToJson(this);
  
}


@JsonSerializable(includeIfNull: false)
class DeleteHelpPayResponse {

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  DeleteHelpPayResponse({
    required this.errorCode,
    required this.errorText,
  });

  factory DeleteHelpPayResponse.fromJson(Map<String, dynamic> json) => _$DeleteHelpPayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteHelpPayResponseToJson(this);
}
