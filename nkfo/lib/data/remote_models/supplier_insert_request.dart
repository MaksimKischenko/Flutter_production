import 'package:json_annotation/json_annotation.dart';

part 'supplier_insert_request.g.dart';

@JsonSerializable()
class SupplierInsertRequest {

  @JsonKey(name: 'supplier_name')
  String? name;

  @JsonKey(name: 'enabled')
  bool enabled;

  @JsonKey(name: 'supplier_domicile')
  String? address;

  @JsonKey(name: 'supplier_unp')
  String? unp;

  @JsonKey(name: 'manager_post')
  String? managerPost;

  @JsonKey(name: 'manager_name')
  String? managerName;

  @JsonKey(name: 'bookkeeper_name')
  String? bookkeeperName;

  @JsonKey(name: 'supplier_shortname')
  String? shortName;

  @JsonKey(name: 'out_supplier_code')
  String? outSupplierCode;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'abonent')
  String? abonent;

  @JsonKey(name: 'bank_id')
  int? bankId;

  @JsonKey(name: 'account')
  String? account;

  @JsonKey(name: 'agent_account')
  String? agentAccount;

  @JsonKey(name: 'terminal_id')
  String? terminalNumber;

  @JsonKey(name: 'use_cabinet')
  bool usePaymentAccaunt;

  @JsonKey(name: 'contract')
  String? contract;

  @JsonKey(name: 'ftp_login')
  String? ftpLogin;

  @JsonKey(name: 'ftp_password')
  String? ftpPassword;

  @JsonKey(name: 'ftp_server')
  String? ftpServer;

  @JsonKey(name: 'ftp_port')
  int? ftpPort;

  SupplierInsertRequest({
    this.name,
    this.enabled = false,
    this.address,
    this.unp,
    this.managerPost,
    this.managerName,
    this.bookkeeperName,
    this.shortName,
    this.outSupplierCode,
    this.email,
    this.abonent,
    this.bankId,
    this.account,
    this.agentAccount,
    this.terminalNumber,
    this.usePaymentAccaunt = false,
    this.contract,
    this.ftpLogin,
    this.ftpPassword,
    this.ftpServer,
    this.ftpPort,
  });

  factory SupplierInsertRequest.fromJson(Map<String, dynamic> json) => _$SupplierInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierInsertRequestToJson(this);
  
}
