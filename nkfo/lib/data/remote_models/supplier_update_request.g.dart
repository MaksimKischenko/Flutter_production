// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierUpdateRequest _$SupplierUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    SupplierUpdateRequest(
      name: json['supplier_name'] as String?,
      enabled: json['enabled'] as bool? ?? false,
      address: json['supplier_domicile'] as String?,
      managerPost: json['manager_post'] as String?,
      managerName: json['manager_name'] as String?,
      bookkeeperName: json['bookkeeper_name'] as String?,
      shortName: json['supplier_shortname'] as String?,
      email: json['email'] as String?,
      abonent: json['abonent'] as String?,
      bankId: json['bank_id'] as int?,
      account: json['account'] as String?,
      agentAccount: json['agent_account'] as String?,
      terminalNumber: json['terminal_id'] as String?,
      usePaymentAccaunt: json['use_cabinet'] as bool? ?? false,
      contract: json['contract'] as String?,
      ftpLogin: json['ftp_login'] as String?,
      ftpPassword: json['ftp_password'] as String?,
      ftpServer: json['ftp_server'] as String?,
      ftpPort: json['ftp_port'] as int?,
    );

Map<String, dynamic> _$SupplierUpdateRequestToJson(
    SupplierUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('supplier_name', instance.name);
  val['enabled'] = instance.enabled;
  writeNotNull('supplier_domicile', instance.address);
  writeNotNull('manager_post', instance.managerPost);
  writeNotNull('manager_name', instance.managerName);
  writeNotNull('bookkeeper_name', instance.bookkeeperName);
  writeNotNull('supplier_shortname', instance.shortName);
  writeNotNull('email', instance.email);
  writeNotNull('abonent', instance.abonent);
  writeNotNull('bank_id', instance.bankId);
  writeNotNull('account', instance.account);
  writeNotNull('agent_account', instance.agentAccount);
  writeNotNull('terminal_id', instance.terminalNumber);
  val['use_cabinet'] = instance.usePaymentAccaunt;
  writeNotNull('contract', instance.contract);
  writeNotNull('ftp_login', instance.ftpLogin);
  writeNotNull('ftp_password', instance.ftpPassword);
  writeNotNull('ftp_server', instance.ftpServer);
  writeNotNull('ftp_port', instance.ftpPort);
  return val;
}
