// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_popular_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripListPopularRequestWrapper _$PsEripListPopularRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripListPopularRequestWrapper(
      PsEripListPopularRequest.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripListPopularRequestWrapperToJson(
        PsEripListPopularRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripListPopularRequest _$PsEripListPopularRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripListPopularRequest(
      ListPopularRequest.fromJson(
          json['ListPopularRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripListPopularRequestToJson(
        PsEripListPopularRequest instance) =>
    <String, dynamic>{
      'ListPopularRequest': instance.request,
    };

ListPopularRequest _$ListPopularRequestFromJson(Map<String, dynamic> json) =>
    ListPopularRequest(
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      filter: ListPopularRequestFilter.fromJson(
          json['Filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListPopularRequestToJson(ListPopularRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalId,
      'Version': instance.version,
      'Filter': instance.filter,
    };

ListPopularRequestFilter _$ListPopularRequestFilterFromJson(
        Map<String, dynamic> json) =>
    ListPopularRequestFilter(
      type: json['@Type'] as int,
      count: json['@Count'] as int,
      value: json['@Value'] as String?,
    );

Map<String, dynamic> _$ListPopularRequestFilterToJson(
        ListPopularRequestFilter instance) =>
    <String, dynamic>{
      '@Type': instance.type,
      '@Value': instance.value,
      '@Count': instance.count,
    };
