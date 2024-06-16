// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_info_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenBody _$TokenBodyFromJson(Map<String, dynamic> json) => TokenBody(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      exp: json['expires_in'] as int?,
    );

Map<String, dynamic> _$TokenBodyToJson(TokenBody instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.exp,
    };

TokenBodyData _$TokenBodyDataFromJson(Map<String, dynamic> json) =>
    TokenBodyData(
      userRole: json['role'] as String?,
      userName: json['login'] as String?,
      userType: $enumDecodeNullable(
          _$UserTypeRoleByIdEnumMap, json['user_type_id'],
          unknownValue: UserTypeRoleById.userViewer),
      jwtSecret: json['pgws_jwt_secret'] as String?,
      sources:
          (json['sources'] as List<dynamic>?)?.map((e) => e as int).toList(),
      exp: json['exp'] as int?,
    );

Map<String, dynamic> _$TokenBodyDataToJson(TokenBodyData instance) =>
    <String, dynamic>{
      'role': instance.userRole,
      'login': instance.userName,
      'user_type_id': _$UserTypeRoleByIdEnumMap[instance.userType],
      'pgws_jwt_secret': instance.jwtSecret,
      'sources': instance.sources,
      'exp': instance.exp,
    };

const _$UserTypeRoleByIdEnumMap = {
  UserTypeRoleById.user: 2,
  UserTypeRoleById.admin: 1,
  UserTypeRoleById.userViewer: 4,
};
