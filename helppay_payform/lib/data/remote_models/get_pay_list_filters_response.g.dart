// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pay_list_filters_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPayListFiltersResponse _$GetPayListFiltersResponseFromJson(
        Map<String, dynamic> json) =>
    GetPayListFiltersResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      filters: (json['Filters'] as List<dynamic>?)
          ?.map((e) => ServiceFilter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPayListFiltersResponseToJson(
    GetPayListFiltersResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('Filters', instance.filters);
  return val;
}

ServiceFilter _$ServiceFilterFromJson(Map<String, dynamic> json) =>
    ServiceFilter(
      code: json['Code'] as int,
      name: json['Name'] as String,
      type: json['Type'] as String?,
      minLength: json['MinLength'] as int?,
      maxLength: json['MaxLength'] as int?,
      format: json['Format'] as String?,
    );

Map<String, dynamic> _$ServiceFilterToJson(ServiceFilter instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Name': instance.name,
      'Type': instance.type,
      'MinLength': instance.minLength,
      'MaxLength': instance.maxLength,
      'Format': instance.format,
    };
