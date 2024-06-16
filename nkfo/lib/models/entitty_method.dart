import 'package:json_annotation/json_annotation.dart';

enum EntityMethod {
  @JsonValue('GET')
  getM,
  @JsonValue('POST')
  postM,
  @JsonValue('PATCH')
  patchM,
  @JsonValue('DELETE')
  deleteM,
  @JsonValue('unknown')
  unknown,
}
