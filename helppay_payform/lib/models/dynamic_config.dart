import 'package:equatable/equatable.dart';

class DynamicConfig extends Equatable {
  final bool isUrlHashStrategy;
  final String urlAppend;
  final String apiUrl;
  final String pictureUrl;
  final int listPopularRequestLoadCount;
  final int allServicesCode;

  const DynamicConfig({
    required this.isUrlHashStrategy,
    required this.urlAppend,
    required this.apiUrl,
    required this.pictureUrl,
    required this.listPopularRequestLoadCount,
    required this.allServicesCode,
  });

  factory DynamicConfig.fromYaml(dynamic map) => DynamicConfig(
    isUrlHashStrategy: (map['isUrlHashStrategy'] as bool?) ?? false,
    urlAppend: (map['urlAppend'] as String?) ?? '',
    apiUrl: map['apiUrl'] as String,
    pictureUrl: (map['pictureUrl'] as String?) ?? '',
    listPopularRequestLoadCount: (map['listPopularRequestLoadCount'] as int?) ?? 20,
    allServicesCode: map['allServicesCode'] as int
  );

  @override
  List<Object> get props => [
    isUrlHashStrategy,
    apiUrl,
    pictureUrl,
    listPopularRequestLoadCount,
    allServicesCode,
  ];
}
