
import 'package:json_annotation/json_annotation.dart';

part 'user_update_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UserUpdateRequest {

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'login')
  final String? login;

  @JsonKey(name: 'blocked')
  final bool? blocked;

  @JsonKey(name: 'password')
  final String? password;

  const UserUpdateRequest({
    this.name,
    this.login,
    this.blocked,
    this.password,
  });

  factory UserUpdateRequest.empty() =>  const UserUpdateRequest();

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);

  UserUpdateRequest copyWith({
    String? name,
    String? login,
    bool? blocked,
    String? password,
  }) => UserUpdateRequest(
      name: name ?? this.name,
      login: login ?? this.login,
      blocked: blocked ?? this.blocked,
      password: password ?? this.password,
    );
}
