// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOClaimsListResponseWrapper _$PsTpOClaimsListResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOClaimsListResponseWrapper(
      PsTpOClaimsListResponse.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOClaimsListResponseWrapperToJson(
        PsTpOClaimsListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOClaimsListResponse _$PsTpOClaimsListResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOClaimsListResponse(
      ClaimsListResponse.fromJson(
          json['ClaimsListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOClaimsListResponseToJson(
        PsTpOClaimsListResponse instance) =>
    <String, dynamic>{
      'ClaimsListResponse': instance.response,
    };

ClaimsListResponse _$ClaimsListResponseFromJson(Map<String, dynamic> json) =>
    ClaimsListResponse(
      rowCount: json['RowCount'] as int?,
      claims: (json['Claim'] as List<dynamic>?)
          ?.map((e) => Claim.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$ClaimsListResponseToJson(ClaimsListResponse instance) =>
    <String, dynamic>{
      'RowCount': instance.rowCount,
      'Claim': instance.claims,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

Claim _$ClaimFromJson(Map<String, dynamic> json) => Claim(
      id: json['ClaimId'] as int,
      accNum: json['AccNum'] as String,
      invoiceDate: json['InvoiceDate'] as String,
      dueDate: json['DueDate'] as String,
      status: json['Status'] as int,
      fio: Fio.fromJson(json['FIO'] as Map<String, dynamic>),
      productCharacter: json['ProductCharacter'] as String?,
      address: json['Address'] == null
          ? null
          : Address.fromJson(json['Address'] as Map<String, dynamic>),
      device: json['Device'] == null
          ? null
          : Devices.fromJson(json['Device'] as Map<String, dynamic>),
      sum: (json['Sum'] as num).toDouble(),
      paymentSum: (json['PaymentSum'] as num).toDouble(),
      typeNotification: json['Type_Notification'] as int?,
      email: json['Email'] as String?,
      smsPhone: json['Sms_Phone'] as String?,
    );

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'ClaimId': instance.id,
      'AccNum': instance.accNum,
      'InvoiceDate': instance.invoiceDate,
      'DueDate': instance.dueDate,
      'Status': instance.status,
      'FIO': instance.fio,
      'ProductCharacter': instance.productCharacter,
      'Address': instance.address,
      'Device': instance.device,
      'Sum': instance.sum,
      'PaymentSum': instance.paymentSum,
      'Type_Notification': instance.typeNotification,
      'Email': instance.email,
      'Sms_Phone': instance.smsPhone,
    };

Fio _$FioFromJson(Map<String, dynamic> json) => Fio(
      evalue: json['evalue'] as String?,
      surname: json['@Surname'] as String?,
      firstName: json['@Firstname'] as String?,
      patronic: json['@Patronic'] as String?,
    );

Map<String, dynamic> _$FioToJson(Fio instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@Surname': instance.surname,
      '@Firstname': instance.firstName,
      '@Patronic': instance.patronic,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      evalue: json['evalue'] as String?,
      place: json['@Place'] as String?,
      street: json['@Street'] as String?,
      building: json['@Building'] as String?,
      buildingPart: json['@BuildingPart'] as String?,
      flat: json['@Flat'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@Place': instance.place,
      '@Street': instance.street,
      '@Building': instance.building,
      '@BuildingPart': instance.buildingPart,
      '@Flat': instance.flat,
    };

Devices _$DevicesFromJson(Map<String, dynamic> json) => Devices(
      count: json['@Count'] as int,
      lastReg: (json['LastReg'] as List<dynamic>?)
          ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DevicesToJson(Devices instance) => <String, dynamic>{
      '@Count': instance.count,
      'LastReg': instance.lastReg,
    };

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      evalue: (json['evalue'] as num).toDouble(),
      idx: json['@Idx'] as int,
      algorithmId: json['@Algorithm_Id'] as int,
      algorithmName: json['algorithmName'] as String?,
      nameDevice: json['@NameDevice'] as String,
      itemUnit: json['@ItemUnit'] as String,
      counterWidth: json['@CounterWidth'] as int,
      tariff: (json['@Tariff'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@Idx': instance.idx,
      '@Algorithm_Id': instance.algorithmId,
      'algorithmName': instance.algorithmName,
      '@NameDevice': instance.nameDevice,
      '@ItemUnit': instance.itemUnit,
      '@CounterWidth': instance.counterWidth,
      '@Tariff': instance.tariff,
    };
