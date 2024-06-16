// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOInformationResponseWrapper _$PsTpOInformationResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOInformationResponseWrapper(
      PsTpOInformationResponse.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOInformationResponseWrapperToJson(
        PsTpOInformationResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOInformationResponse _$PsTpOInformationResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOInformationResponse(
      InformationResponse.fromJson(
          json['InformationResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOInformationResponseToJson(
        PsTpOInformationResponse instance) =>
    <String, dynamic>{
      'InformationResponse': instance.response,
    };

InformationResponse _$InformationResponseFromJson(Map<String, dynamic> json) =>
    InformationResponse(
      fullName: json['FullName'] as String?,
      shortName: json['ShortName'] as String?,
      address: json['Address'] as String?,
      mfo: json['MFO'] as String?,
      accNum: json['AccNum'] as String?,
      unp: json['UNP'] as String?,
      fio: json['FIO'] as String?,
      post: json['Post'] as String?,
      basis: json['Basis'] as String?,
      usersCount: json['UsersCount'] as int?,
      confirmStatus: json['ConfirmStatus'] as int,
      pollAvailable: json['PollAvailable'] as int?,
      supplierId: json['SupplierId'] as int?,
      keyRegistration: json['KeyRegistration'] as String?,
      contacts: (json['Contact'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      accountStatement: json['AccountStatement'] == null
          ? null
          : InformationResponseAccountStatement.fromJson(
              json['AccountStatement'] as Map<String, dynamic>),
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$InformationResponseToJson(
        InformationResponse instance) =>
    <String, dynamic>{
      'FullName': instance.fullName,
      'ShortName': instance.shortName,
      'Address': instance.address,
      'MFO': instance.mfo,
      'AccNum': instance.accNum,
      'UNP': instance.unp,
      'FIO': instance.fio,
      'Post': instance.post,
      'Basis': instance.basis,
      'UsersCount': instance.usersCount,
      'ConfirmStatus': instance.confirmStatus,
      'PollAvailable': instance.pollAvailable,
      'SupplierId': instance.supplierId,
      'KeyRegistration': instance.keyRegistration,
      'Contact': instance.contacts,
      'AccountStatement': instance.accountStatement,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      contact: json['Contact'] as String,
      position: json['Position'] as String,
      phone: json['Phone'] as String,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'Contact': instance.contact,
      'Position': instance.position,
      'Phone': instance.phone,
    };

InformationResponseAccountStatement
    _$InformationResponseAccountStatementFromJson(Map<String, dynamic> json) =>
        InformationResponseAccountStatement(
          accounts: (json['Account'] as List<dynamic>?)
              ?.map((e) => InformationResponseAccountStatementAccount.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$InformationResponseAccountStatementToJson(
        InformationResponseAccountStatement instance) =>
    <String, dynamic>{
      'Account': instance.accounts,
    };

InformationResponseAccountStatementAccount
    _$InformationResponseAccountStatementAccountFromJson(
            Map<String, dynamic> json) =>
        InformationResponseAccountStatementAccount(
          evalue: json['evalue'] as String,
          mfo: json['@MFO'] as String,
          name: json['@Name'] as String,
          accountSystem: json['@AccountSystem'] as String,
        );

Map<String, dynamic> _$InformationResponseAccountStatementAccountToJson(
        InformationResponseAccountStatementAccount instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@MFO': instance.mfo,
      '@Name': instance.name,
      '@AccountSystem': instance.accountSystem,
    };
