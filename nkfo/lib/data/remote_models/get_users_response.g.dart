// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['user_id'] as int,
      name: json['name'] as String?,
      login: json['login'] as String?,
      blocked: json['blocked'] as bool? ?? true,
      dateAdd: json['date_add'] == null
          ? null
          : DateTime.parse(json['date_add'] as String),
      typeId: json['type_id'] as int?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      blockedName: json['blocked_name'] as String?,
      passwordExpireName: json['password_expire_name'] as String?,
      typeName: json['type_name'] as String?,
      typeDescription: json['type_description'] as String?,
      supplierId: json['supplier_id'] as String?,
      supplierUnp: json['supplier_unp'] as String?,
      supplierName: json['supplier_name'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.id,
      'name': instance.name,
      'login': instance.login,
      'blocked': instance.blocked,
      'date_add': instance.dateAdd?.toIso8601String(),
      'type_id': instance.typeId,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'blocked_name': instance.blockedName,
      'password_expire_name': instance.passwordExpireName,
      'type_name': instance.typeName,
      'type_description': instance.typeDescription,
      'supplier_id': instance.supplierId,
      'supplier_unp': instance.supplierUnp,
      'supplier_name': instance.supplierName,
    };
