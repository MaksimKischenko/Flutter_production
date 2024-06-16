// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_insert_request.g.dart';

  // "date_blocked": "string",
  // "date_add": "string",
  // "phone_number": "string",
  // "failed_login": 0,
  // "email": "string",
  // "password_expire": true,
  // "date_change_password": "2023-03-02",
  // "type_name": "string"

@JsonSerializable()
class UserInsertRequest {


  @JsonKey(name: 'date_add')
  final DateTime? createDate;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'login')
  final String? login;

  @JsonKey(name: 'type_id')
  final int? typeId;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'blocked')
  final bool? blocked;

  const UserInsertRequest({
    this.createDate,
    this.name,
    this.login,
    this.typeId,
    this.password,
    this.blocked = false,
  });


  factory UserInsertRequest.empty() =>  const UserInsertRequest();

  factory UserInsertRequest.fromJson(Map<String, dynamic> json) => _$UserInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInsertRequestToJson(this);
  

  UserInsertRequest copyWith({
    DateTime? createDate,
    String? name,
    String? login,
    int? typeId,
    String? password,
    bool? blocked,
  }) => UserInsertRequest(
      createDate: createDate ?? this.createDate,
      name: name ?? this.name,
      login: login ?? this.login,
      typeId: typeId ?? this.typeId,
      password: password ?? this.password,
      blocked: blocked ?? this.blocked,
    );
}
