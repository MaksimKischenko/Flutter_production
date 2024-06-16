import 'package:json_annotation/json_annotation.dart';

part 'list_popular_request.g.dart';

@JsonSerializable()
class PsEripListPopularRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripListPopularRequest psErip;

  const PsEripListPopularRequestWrapper(this.psErip);

  factory PsEripListPopularRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripListPopularRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripListPopularRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripListPopularRequest {

  @JsonKey(name: 'ListPopularRequest')
  final ListPopularRequest request;

  const PsEripListPopularRequest(this.request);

  factory PsEripListPopularRequest.fromJson(Map<String, dynamic> json) => _$PsEripListPopularRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripListPopularRequestToJson(this);
  
}

@JsonSerializable()
class ListPopularRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalId;

  @JsonKey(name: 'Version')
  final int version;

  // @JsonKey(name: 'Token')
  // final String? token;

  @JsonKey(name: 'Filter')
  final ListPopularRequestFilter filter;

  const ListPopularRequest({
    required this.terminalId,
    required this.version,
    // required this.token,
    required this.filter,
  });

  factory ListPopularRequest.fromJson(Map<String, dynamic> json) => _$ListPopularRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListPopularRequestToJson(this);
  
}

@JsonSerializable()
class ListPopularRequestFilter {

  /// 1 - популярные на терминале
  /// 2 - популярные в банке
  @JsonKey(name: '@Type')
  final int type;

  @JsonKey(name: '@Value')
  final String? value;

  @JsonKey(name: '@Count')
  final int count;

  const ListPopularRequestFilter({
    required this.type,
    required this.count,
    this.value,
  });

  factory ListPopularRequestFilter.fromJson(Map<String, dynamic> json) => _$ListPopularRequestFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ListPopularRequestFilterToJson(this);
  
}