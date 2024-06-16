import 'package:json_annotation/json_annotation.dart';

part 'get_out_server_response.g.dart';

@JsonSerializable()
class OutServer {

  @JsonKey(name: 'out_server_id')
  int id;

  @JsonKey(name: 'server_name')
  String name;
  
  OutServer({
    required this.id,
    required this.name,
  });


  factory OutServer.fromJson(Map<String, dynamic> json) => _$OutServerFromJson(json);

  Map<String, dynamic> toJson() => _$OutServerToJson(this);
}
