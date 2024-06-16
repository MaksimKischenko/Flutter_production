import 'package:dartx/dartx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user_profile_response.g.dart';

@JsonSerializable()
class PsEripUserProfileResponseWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripUserProfileResponse psErip;

  const PsEripUserProfileResponseWrapper(this.psErip);

  factory PsEripUserProfileResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsEripUserProfileResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripUserProfileResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripUserProfileResponse {

  @JsonKey(name: 'GetUserProfileResponse')
  final GetUserProfileResponse response;

  const PsEripUserProfileResponse(this.response);

  factory PsEripUserProfileResponse.fromJson(Map<String, dynamic> json) => _$PsEripUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripUserProfileResponseToJson(this);
}

@JsonSerializable()
class GetUserProfileResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Screen')
  final List<GetUserProfileScreenItem>? screens;

  const GetUserProfileResponse({
    this.errorCode,
    this.errorText,
    this.screens,
  });

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) => _$GetUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileResponseToJson(this);
  
}

@JsonSerializable()
class GetUserProfileScreenItem {

  @JsonKey(name: '@Idx')
  final int? idx;

  @JsonKey(name: 'Object')
  final List<GetUserProfileScreenItemObject>? objects;

  const GetUserProfileScreenItem({
    this.idx,
    this.objects,
  });

  factory GetUserProfileScreenItem.fromJson(Map<String, dynamic> json) => _$GetUserProfileScreenItemFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileScreenItemToJson(this);

  GetUserProfileScreenItemObject? getObjectWithId(int id) => objects?.firstOrNullWhere((e) => e.idx == id);
  
}

@JsonSerializable()
class GetUserProfileScreenItemObject {

  @JsonKey(name: '@Idx')
  final int? idx;

  @JsonKey(name: '@Text')
  final String? text;

  @JsonKey(name: '@URL')
  final String? url;

  const GetUserProfileScreenItemObject({
    this.idx,
    this.text,
    this.url
  });

  factory GetUserProfileScreenItemObject.fromJson(Map<String, dynamic> json) => _$GetUserProfileScreenItemObjectFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileScreenItemObjectToJson(this);
  
}