// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_claim_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOAddClaimRequestWrapper _$PsTpOAddClaimRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOAddClaimRequestWrapper(
      PsTpOAddClaimRequest.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAddClaimRequestWrapperToJson(
        PsTpOAddClaimRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOAddClaimRequest _$PsTpOAddClaimRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOAddClaimRequest(
      AddClaimRequest.fromJson(json['AddClaimRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAddClaimRequestToJson(
        PsTpOAddClaimRequest instance) =>
    <String, dynamic>{
      'AddClaimRequest': instance.request,
    };

AddClaimRequest _$AddClaimRequestFromJson(Map<String, dynamic> json) =>
    AddClaimRequest(
      serviceCode: json['ServiceCode'] as int,
      accNum: json['AccNum'] as String?,
      sum: AddClaimRequestSum.fromJson(json['Sum'] as Map<String, dynamic>),
      device: json['Device'] == null
          ? null
          : Devices.fromJson(json['Device'] as Map<String, dynamic>),
      dueDate: json['DueDate'] as String,
      fio: json['FIO'] == null
          ? null
          : Fio.fromJson(json['FIO'] as Map<String, dynamic>),
      address: json['Address'] == null
          ? null
          : Address.fromJson(json['Address'] as Map<String, dynamic>),
      productCharacter: json['ProductCharacter'] as String?,
      typeNotification: json['Type_Notification'] as int?,
      email: json['Email'] as String?,
      smsPhone: json['SMS_Phone'] as String?,
      token: json['Token'] as String?,
      version: json['Version'] as int?,
      key: json['KeyRequest'] as int?,
    );

Map<String, dynamic> _$AddClaimRequestToJson(AddClaimRequest instance) {
  final val = <String, dynamic>{
    'ServiceCode': instance.serviceCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AccNum', instance.accNum);
  val['Sum'] = instance.sum;
  writeNotNull('Device', instance.device);
  val['DueDate'] = instance.dueDate;
  writeNotNull('FIO', instance.fio);
  writeNotNull('Address', instance.address);
  writeNotNull('ProductCharacter', instance.productCharacter);
  writeNotNull('Type_Notification', instance.typeNotification);
  writeNotNull('Email', instance.email);
  writeNotNull('SMS_Phone', instance.smsPhone);
  writeNotNull('Token', instance.token);
  writeNotNull('Version', instance.version);
  writeNotNull('KeyRequest', instance.key);
  return val;
}

AddClaimRequestSum _$AddClaimRequestSumFromJson(Map<String, dynamic> json) =>
    AddClaimRequestSum(
      evalue: (json['evalue'] as num).toDouble(),
      price: (json['@Price'] as num?)?.toDouble(),
      quantity: json['@Quantity'] as int?,
    );

Map<String, dynamic> _$AddClaimRequestSumToJson(AddClaimRequestSum instance) {
  final val = <String, dynamic>{
    'evalue': instance.evalue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@Price', instance.price);
  writeNotNull('@Quantity', instance.quantity);
  return val;
}
