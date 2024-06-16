// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInsertRequest _$UserInsertRequestFromJson(Map<String, dynamic> json) =>
    UserInsertRequest(
      name: json['name'] as String?,
      login: json['login'] as String?,
      blocked: json['blocked'] as bool? ?? false,
      dateAdd: json['date_add'] as String?,
      typeId: json['type_id'] as int?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      supplierId: json['supplier_id'] as String?,
    );

Map<String, dynamic> _$UserInsertRequestToJson(UserInsertRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'login': instance.login,
      'blocked': instance.blocked,
      'date_add': instance.dateAdd,
      'type_id': instance.typeId,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'supplier_id': instance.supplierId,
    };
