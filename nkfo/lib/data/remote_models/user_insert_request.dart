import 'package:json_annotation/json_annotation.dart';

part 'user_insert_request.g.dart';

@JsonSerializable()
class UserInsertRequest {

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'login')
  String? login;

  @JsonKey(name: 'blocked')
  bool blocked;

  @JsonKey(name: 'date_add')
  String? dateAdd;

  @JsonKey(name: 'type_id')
  int? typeId;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'supplier_id')
  String? supplierId;

  UserInsertRequest({
    this.name,
    this.login,
    this.blocked = false,
    this.dateAdd,
    this.typeId,
    this.phoneNumber,
    this.email,
    this.supplierId
  });

  factory UserInsertRequest.fromJson(Map<String, dynamic> json) => _$UserInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInsertRequestToJson(this);
  

  UserInsertRequest copyWith({
    String? name,
    String? login,
    bool? blocked,
    String? dateAdd,
    int? typeId,
    String? phoneNumber,
    String? email,
    String? supplierId,
  }) => UserInsertRequest(
    name: name ?? this.name,
    login: login ?? this.login,
    blocked: blocked ?? this.blocked,
    dateAdd: dateAdd ?? this.dateAdd,
    typeId: typeId ?? this.typeId,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,
    supplierId: supplierId ?? this.supplierId,
  );
}
