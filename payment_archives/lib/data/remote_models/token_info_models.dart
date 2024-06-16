// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';

part 'token_info_models.g.dart';

@JsonSerializable()
class TokenBody {
  @JsonKey(name: 'access_token')
  final String? accessToken;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @JsonKey(name: 'expires_in')
  final int? exp;

  TokenBody({
    this.accessToken,
    this.refreshToken,
    this.exp,
  });


  factory TokenBody.fromJson(Map<String, dynamic> json) =>
      _$TokenBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TokenBodyToJson(this);
}

@JsonSerializable()
class TokenBodyData {

  @JsonKey(name: 'role')
  final String? userRole;

  @JsonKey(name: 'login')
  final String? userName;

  @JsonKey(name: 'user_type_id', unknownEnumValue: UserTypeRoleById.userViewer)
  final UserTypeRoleById? userType;

  @JsonKey(name: 'pgws_jwt_secret')
  final String? jwtSecret;

  @JsonKey(name: 'sources')
  final List<int>? sources;

  @JsonKey(name: 'exp')
  final int? exp;

  TokenBodyData({
    this.userRole,
    this.userName,
    this.userType,
    this.jwtSecret,
    this.sources,
    this.exp,
  });


  factory TokenBodyData.fromJson(Map<String, dynamic> json) =>
      _$TokenBodyDataFromJson(json);

  Map<String, dynamic> toJson() => _$TokenBodyDataToJson(this);
}



