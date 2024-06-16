// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_out_server_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutServer _$OutServerFromJson(Map<String, dynamic> json) => OutServer(
      id: json['out_server_id'] as int,
      name: json['server_name'] as String,
    );

Map<String, dynamic> _$OutServerToJson(OutServer instance) => <String, dynamic>{
      'out_server_id': instance.id,
      'server_name': instance.name,
    };
