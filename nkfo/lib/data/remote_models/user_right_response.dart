
import 'package:dartx/dartx.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'user_right_response.g.dart';

class UserRightsWrapper {
  final List<UserRight> rights;

  const UserRightsWrapper(this.rights);

  factory UserRightsWrapper.empty() => const UserRightsWrapper([]);

  bool isAvailable(EntityMethod method, EntityName entityName)
      => rights.firstOrNullWhere((e) => e.entityName == entityName && e.methods.contains(method)) != null;
}

@JsonSerializable()
class UserRight {

  @JsonKey(name: 'entity_name', unknownEnumValue: EntityName.unknown)
  final EntityName entityName;

  @JsonKey(name: 'entity_type')
  final String entityType;

  @JsonKey(name: 'methods', unknownEnumValue: EntityMethod.unknown)
  final List<EntityMethod> methods;


  UserRight({
    required this.entityName,
    required this.entityType,
    required this.methods,
  });


  factory UserRight.fromJson(Map<String, dynamic> json) => _$UserRightFromJson(json);

  Map<String, dynamic> toJson() => _$UserRightToJson(this);
  
}
