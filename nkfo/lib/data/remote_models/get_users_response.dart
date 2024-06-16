import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_users_response.g.dart';

@JsonSerializable()
class User {

  @JsonKey(name: 'user_id')
  final int id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'login')
  final String? login;

  @JsonKey(name: 'blocked')
  final bool blocked;

  @JsonKey(name: 'date_add')
  final DateTime? dateAdd;

  @JsonKey(name: 'type_id')
  final int? typeId;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'blocked_name')
  final String? blockedName;

  @JsonKey(name: 'password_expire_name')
  final String? passwordExpireName;

  @JsonKey(name: 'type_name')
  final String? typeName;

  @JsonKey(name: 'type_description')
  final String? typeDescription;

  @JsonKey(name: 'supplier_id')
  final String? supplierId;

  @JsonKey(name: 'supplier_unp')
  final String? supplierUnp;

  @JsonKey(name: 'supplier_name')
  final String? supplierName;

  User({
    required this.id,
    this.name,
    this.login,
    this.blocked = true,
    this.dateAdd,
    this.typeId,
    this.phoneNumber,
    this.email,
    this.blockedName,
    this.passwordExpireName,
    this.typeName,
    this.typeDescription,
    this.supplierId,
    this.supplierUnp,
    this.supplierName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  Color get statusColor => blocked ? CupertinoColors.systemRed : CupertinoColors.systemGreen;
  

  @override
  String toString() => 'User(id: $id)';
}
