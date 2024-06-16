import 'package:json_annotation/json_annotation.dart';

part 'ipify_response.g.dart';

@JsonSerializable()
class IpifyResponse {

  @JsonKey(name: 'ip')
  final String ip;

  const IpifyResponse(this.ip);

  factory IpifyResponse.fromJson(Map<String, dynamic> json) => _$IpifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IpifyResponseToJson(this);
  
}