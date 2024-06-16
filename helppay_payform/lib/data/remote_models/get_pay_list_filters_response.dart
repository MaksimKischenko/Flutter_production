import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_pay_list_filters_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetPayListFiltersResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Filters')
  final List<ServiceFilter>? filters;

  const GetPayListFiltersResponse({
    this.errorCode,
    this.errorText,
    this.filters
  });

  factory GetPayListFiltersResponse.fromJson(Map<String, dynamic> json) => _$GetPayListFiltersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPayListFiltersResponseToJson(this);
  
}

@JsonSerializable()
class ServiceFilter extends Equatable {

  @JsonKey(name: 'Code')
  final int code;

  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'Type')
  final String? type;

  @JsonKey(name: 'MinLength')
  final int? minLength;

  @JsonKey(name: 'MaxLength')
  final int? maxLength;

  @JsonKey(name: 'Format')
  final String? format;

  const ServiceFilter({
    required this.code,
    required this.name,
    this.type,
    this.minLength,
    this.maxLength,
    this.format,
  });

  factory ServiceFilter.fromJson(Map<String, dynamic> json) => _$ServiceFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceFilterToJson(this);

  @override
  List<Object?> get props => [code, name, type];

}
