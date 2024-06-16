// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_suppliers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supplier _$SupplierFromJson(Map<String, dynamic> json) => Supplier(
      id: json['supplier_id'] as int,
      name: json['supplier_name'] as String?,
      enabled: json['enabled'] as bool? ?? false,
      address: json['supplier_domicile'] as String?,
      unp: json['supplier_unp'] as String?,
      managerPost: json['manager_post'] as String?,
      managerName: json['manager_name'] as String?,
      bookkeeperName: json['bookkeeper_name'] as String?,
      shortName: json['supplier_shortname'] as String?,
      outSupplierCode: json['out_supplier_code'] as String?,
      email: json['email'] as String?,
      abonent: json['abonent'] as String?,
      agentAccount: json['agent_account'] as String?,
      bankId: json['bank_id'] as int?,
      bankBic: json['bank_bic'] as String?,
      account: json['account'] as String?,
      terminalNumber: json['terminal_id'] as String?,
      usePaymentAccaunt: json['use_cabinet'] as bool? ?? false,
      contract: json['contract'] as String?,
      ftpLogin: json['ftp_login'] as String?,
      ftpPassword: json['ftp_password'] as String?,
      ftpServer: json['ftp_server'] as String?,
      ftpPort: json['ftp_port'] as int?,
    );

Map<String, dynamic> _$SupplierToJson(Supplier instance) => <String, dynamic>{
      'supplier_id': instance.id,
      'supplier_name': instance.name,
      'enabled': instance.enabled,
      'supplier_domicile': instance.address,
      'supplier_unp': instance.unp,
      'manager_post': instance.managerPost,
      'manager_name': instance.managerName,
      'bookkeeper_name': instance.bookkeeperName,
      'supplier_shortname': instance.shortName,
      'out_supplier_code': instance.outSupplierCode,
      'email': instance.email,
      'abonent': instance.abonent,
      'agent_account': instance.agentAccount,
      'bank_id': instance.bankId,
      'bank_bic': instance.bankBic,
      'account': instance.account,
      'terminal_id': instance.terminalNumber,
      'use_cabinet': instance.usePaymentAccaunt,
      'contract': instance.contract,
      'ftp_login': instance.ftpLogin,
      'ftp_password': instance.ftpPassword,
      'ftp_server': instance.ftpServer,
      'ftp_port': instance.ftpPort,
    };
