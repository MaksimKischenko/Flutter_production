// ignore_for_file: always_put_required_named_parameters_first

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'claims_list_response.g.dart';

@JsonSerializable()
class PsTpOClaimsListResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOClaimsListResponse psTpO;

  PsTpOClaimsListResponseWrapper(this.psTpO);

  factory PsTpOClaimsListResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOClaimsListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOClaimsListResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpOClaimsListResponse {

  @JsonKey(name: 'ClaimsListResponse')
  final ClaimsListResponse response;

  PsTpOClaimsListResponse(this.response);

  factory PsTpOClaimsListResponse.fromJson(Map<String, dynamic> json) => _$PsTpOClaimsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOClaimsListResponseToJson(this);
}

@JsonSerializable()
class ClaimsListResponse {

  @JsonKey(name: 'RowCount')
  final int? rowCount;

  @JsonKey(name: 'Claim')
  final List<Claim>? claims;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  ClaimsListResponse({
    required this.rowCount,
    this.claims,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory ClaimsListResponse.fromJson(Map<String, dynamic> json) => _$ClaimsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsListResponseToJson(this);
  
}

@JsonSerializable()
class Claim {

  @JsonKey(name: 'ClaimId')
  final int id;

  @JsonKey(name: 'AccNum')
  final String accNum;

  @JsonKey(name: 'InvoiceDate')
  final String invoiceDate;

  @JsonKey(name: 'DueDate')
  final String dueDate;

  /// 1 - Подготовлено, 2 - Оплачено, 3 - Частично оплачено, 4 - Просрочено
  @JsonKey(name: 'Status')
  final int status;

  @JsonKey(name: 'FIO')
  final Fio fio;

  @JsonKey(name: 'ProductCharacter')
  final String? productCharacter;

  @JsonKey(name: 'Address')
  final Address? address;

  @JsonKey(name: 'Device')
  final Devices? device;

  @JsonKey(name: 'Sum')
  final double sum;

  @JsonKey(name: 'PaymentSum')
  final double paymentSum;

  @JsonKey(name: 'Type_Notification')
  final int? typeNotification;

  @JsonKey(name: 'Email')
  final String? email;

  @JsonKey(name: 'Sms_Phone')
  final String? smsPhone;

  Claim({
    required this.id,
    required this.accNum,
    required this.invoiceDate,
    required this.dueDate,
    required this.status,
    required this.fio,
    this.productCharacter,
    this.address,
    this.device,
    required this.sum,
    required this.paymentSum,
    this.typeNotification,
    this.email,
    this.smsPhone,
  });

  static const Map<int, String> statusesText = {
    1: 'Подготовлено',
    2: 'Полностью оплачено',
    3: 'Частично оплачено',
    4: 'Просрочено',
  };

  /// get text status of claim
  String get statusText => statusesText[status] ?? 'Неизвестно';

  static const Map<int, Color> statusesColor = {
    1: Color(0xffDDE1E9),
    2: Color(0xff56C58A),
    3: Color(0xffF8D147),
    4: Color(0xffEC5B5B),
  };

  /// get status color of claim
  Color statusColor() => statusesColor[status] ?? const Color(0xffDDE1E9);
  
  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);

}

@JsonSerializable()
class Fio {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@Surname')
  final String? surname;

  @JsonKey(name: '@Firstname')
  final String? firstName;

  @JsonKey(name: '@Patronic')
  final String? patronic;

  Fio({this.evalue, this.surname, this.firstName, this.patronic});
  
  factory Fio.fromJson(Map<String, dynamic> json) => _$FioFromJson(json);

  Map<String, dynamic> toJson() => _$FioToJson(this);

}

@JsonSerializable()
class Address {

  @JsonKey(name: 'evalue')
  final String? evalue;

  @JsonKey(name: '@Place')
  final String? place;

  @JsonKey(name: '@Street')
  final String? street;

  @JsonKey(name: '@Building')
  final String? building;

  @JsonKey(name: '@BuildingPart')
  final String? buildingPart;

  @JsonKey(name: '@Flat')
  final String? flat;

  Address({
    this.evalue,
    this.place,
    this.street,
    this.building,
    this.buildingPart,
    this.flat,
  });
  
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

}

@JsonSerializable()
class Devices {

  @JsonKey(name: '@Count')
  final int count;

  @JsonKey(name: 'LastReg')
  final List<Device>? lastReg;

  Devices({
    required this.count,
    this.lastReg,
  });

  factory Devices.fromJson(Map<String, dynamic> json) => _$DevicesFromJson(json);

  Map<String, dynamic> toJson() => _$DevicesToJson(this);
  
}

@JsonSerializable()
class Device {

  @JsonKey(name: 'evalue')
  final double evalue;

  @JsonKey(name: '@Idx')
  final int idx;

  @JsonKey(name: '@Algorithm_Id')
  final int algorithmId;

  //only for DevicesAdapter
  String? algorithmName;

  @JsonKey(name: '@NameDevice')
  final String nameDevice;

  @JsonKey(name: '@ItemUnit')
  final String itemUnit;

  @JsonKey(name: '@CounterWidth')
  final int counterWidth;

  @JsonKey(name: '@Tariff')
  final double? tariff;

  Device({
    required this.evalue,
    required this.idx,
    required this.algorithmId,
    this.algorithmName,
    required this.nameDevice,
    required this.itemUnit,
    required this.counterWidth,
    this.tariff
  });

  Device copy({
    double? evalue,
    int? idx,
    int? algorithmId,
    String? algorithmName,
    String? nameDevice,
    String? itemUnit,
    int? counterWidth,
    double? tariff,
  }) => Device(
    evalue: evalue ?? this.evalue,
    idx: idx ?? this.idx,
    algorithmId: algorithmId ?? this.algorithmId,
    algorithmName: algorithmName ?? this.algorithmName,
    nameDevice: nameDevice ?? this.nameDevice,
    itemUnit: itemUnit ?? this.itemUnit,
    counterWidth: counterWidth ?? this.counterWidth,
    tariff: tariff ?? this.tariff,
  );

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
  
}
