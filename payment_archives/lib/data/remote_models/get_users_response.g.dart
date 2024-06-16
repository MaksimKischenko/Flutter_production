// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['user_id'] as int,
      name: json['name'] as String?,
      login: json['login'] as String?,
      password: json['password'] as String?,
      blocked: json['blocked'] as bool?,
      type: $enumDecodeNullable(_$UserTypeRoleByIdEnumMap, json['type_id']),
      description: json['type_name'] as String?,
      dateAdd: json['date_add'] == null
          ? null
          : DateTime.parse(json['date_add'] as String),
      dateBlocked: json['date_blocked'] == null
          ? null
          : DateTime.parse(json['date_blocked'] as String),
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      blockedName: json['blocked_name'] as String?,
      passwordExpire: json['password_expire'] as String?,
      dateChangePassword: json['date_change_password'] == null
          ? null
          : DateTime.parse(json['date_change_password'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.id,
      'name': instance.name,
      'login': instance.login,
      'password': instance.password,
      'blocked': instance.blocked,
      'type_id': _$UserTypeRoleByIdEnumMap[instance.type],
      'type_name': instance.description,
      'date_add': instance.dateAdd?.toIso8601String(),
      'date_blocked': instance.dateBlocked?.toIso8601String(),
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'blocked_name': instance.blockedName,
      'password_expire': instance.passwordExpire,
      'date_change_password': instance.dateChangePassword?.toIso8601String(),
    };

const _$UserTypeRoleByIdEnumMap = {
  UserTypeRoleById.user: 2,
  UserTypeRoleById.admin: 1,
  UserTypeRoleById.userViewer: 4,
};
