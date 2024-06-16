// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_user_role_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetUserRoleRequest _$SetUserRoleRequestFromJson(Map<String, dynamic> json) =>
    SetUserRoleRequest(
      userName: json['p_user_name'] as String?,
      userRolesIds:
          (json['p_role_ids'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SetUserRoleRequestToJson(SetUserRoleRequest instance) =>
    <String, dynamic>{
      'p_user_name': instance.userName,
      'p_role_ids': instance.userRolesIds,
    };
