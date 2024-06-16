// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_data_source_response.g.dart';

@JsonSerializable()
class DataSource extends Equatable {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'create_date')
  final DateTime? createDate;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'login')
  final String? login;

  @JsonKey(name: 'data_scale')
  final int? dataScale;

  @JsonKey(name: 'enabled')
  final bool? enabled;

  @JsonKey(name: 'blocked')
  final bool? blocked;

  @JsonKey(name: 'password')
  final String? password;

  const DataSource({
    required this.id,
    this.createDate,
    this.caption,
    this.userId,
    this.login,
    this.dataScale,
    this.enabled,
    this.blocked,
    this.password
  });
  
  factory DataSource.empty() =>  const DataSource(id: 0);

  factory DataSource.fromJson(Map<String, dynamic> json) => _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);


  @override
  List<Object?> get props => [
    id, caption, createDate, dataScale,  enabled, blocked, userId, login
  ];

  String dataScalePeriod() {
    var dataScalePeriod = '';
    switch (dataScale) {
      case 1:
        dataScalePeriod = 'День';
        break;
      case 2:
        dataScalePeriod = 'Месяц';
        break;
      case 3:
        dataScalePeriod = 'Год';
        break;                
    }
    return dataScalePeriod;
  }

  int get statusSortIndexBlocked => (blocked ?? false) ? 1 : 0;

  int get statusSortIndexEnabled => (enabled ?? false) ? 1 : 0;

  DataSource copyWith({
    int? id,
    DateTime? createDate,
    String? caption,
    int? userId,
    String? login,
    int? dataScale,
    bool? enabled,
    bool? blocked,
    String? password,
  }) => DataSource(
      id: id ?? this.id,
      createDate: createDate ?? this.createDate,
      caption: caption ?? this.caption,
      userId: userId ?? this.userId,
      login: login ?? this.login,
      dataScale: dataScale ?? this.dataScale,
      enabled: enabled ?? this.enabled,
      blocked: blocked ?? this.blocked,
      password: password ?? this.password,
    );

  @override
  bool get stringify => true;
}
