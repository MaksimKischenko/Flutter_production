import 'package:json_annotation/json_annotation.dart';

part 'list_popular_response.g.dart';

@JsonSerializable()
class ListPopularResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Token')
  final String? token;

  @JsonKey(name: 'PayRecord')
  final List<ListPopularResponsePayRecord>? payRecord;

  const ListPopularResponse({
    this.errorCode,
    this.errorText,
    this.token,
    this.payRecord,
  });

  factory ListPopularResponse.fromJson(Map<String, dynamic> json) => _$ListPopularResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListPopularResponseToJson(this);
  
}

@JsonSerializable()
class ListPopularResponsePayRecord {

  @JsonKey(name: '@Code')
  final int? code;

  @JsonKey(name: '@DIType')
  final int? diType;

  @JsonKey(name: '@Name')
  final String? name;

  @JsonKey(name: '@RecordType')
  final int? recordType;

  @JsonKey(name: 'Picture')
  final ServicePicture? picture;

  const ListPopularResponsePayRecord({
    this.code,
    this.diType,
    this.name,
    this.recordType,
    this.picture
  });

  factory ListPopularResponsePayRecord.fromJson(Map<String, dynamic> json) => _$ListPopularResponsePayRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ListPopularResponsePayRecordToJson(this);

}

@JsonSerializable()
class ServicePicture {

  @JsonKey(name: '@URL')
  final String? url;

  const ServicePicture({
    this.url
  });

  factory ServicePicture.fromJson(Map<String, dynamic> json) => _$ServicePictureFromJson(json);

  Map<String, dynamic> toJson() => _$ServicePictureToJson(this);

}