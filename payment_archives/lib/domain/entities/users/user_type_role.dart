import 'package:json_annotation/json_annotation.dart';

enum UserTypeRoleById {
  @JsonValue(2)
  user('Пользователь', 2),

  @JsonValue(1)
  admin('Администратор', 1),

  @JsonValue(4)
  userViewer('Просмотр пользователей', 4);

  const UserTypeRoleById(this.name, this.id);
  final String name;
  final int id;
}
