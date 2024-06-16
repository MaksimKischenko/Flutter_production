import 'package:json_annotation/json_annotation.dart';

part 'user_update_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UserUpdateRequest {

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'blocked')
  bool? blocked;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'email')
  String? email;

  UserUpdateRequest({
    this.name,
    this.blocked,
    this.phoneNumber,
    this.email,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
  
}
