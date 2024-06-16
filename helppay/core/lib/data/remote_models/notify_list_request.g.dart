// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntNotifyListRequestWrapper _$MdomTpIntNotifyListRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyListRequestWrapper(
      MdomTpIntNotifyListRequest.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyListRequestWrapperToJson(
        MdomTpIntNotifyListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntNotifyListRequest _$MdomTpIntNotifyListRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyListRequest(
      NotificationListRequest.fromJson(
          json['NotificationListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyListRequestToJson(
        MdomTpIntNotifyListRequest instance) =>
    <String, dynamic>{
      'NotificationListRequest': instance.request,
    };

NotificationListRequest _$NotificationListRequestFromJson(
        Map<String, dynamic> json) =>
    NotificationListRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      supplierId: json['SupplierId'] as int?,
      rowCount: json['RowCount'] == null
          ? null
          : NotifyListRequestRowCount.fromJson(
              json['RowCount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationListRequestToJson(
    NotificationListRequest instance) {
  final val = <String, dynamic>{
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'KeyRequest': instance.keyRequest,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['Token'] = instance.token;
  writeNotNull('SupplierId', instance.supplierId);
  writeNotNull('RowCount', instance.rowCount);
  return val;
}

NotifyListRequestRowCount _$NotifyListRequestRowCountFromJson(
        Map<String, dynamic> json) =>
    NotifyListRequestRowCount(
      value: json['value'] as int,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$NotifyListRequestRowCountToJson(
    NotifyListRequestRowCount instance) {
  final val = <String, dynamic>{
    'value': instance.value,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
