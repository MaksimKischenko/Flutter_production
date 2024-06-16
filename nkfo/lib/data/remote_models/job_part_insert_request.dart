import 'package:json_annotation/json_annotation.dart';

part 'job_part_insert_request.g.dart';

@JsonSerializable()
class JobPartInsertRequest {

  @JsonKey(name: 'job_id')
  int? jobId;

  @JsonKey(name: 'order_num')
  int? orderNum;

  @JsonKey(name: 'sql')
  String? sql;

  @JsonKey(name: 'tmp_file_name')
  String? tmpFileName;

  @JsonKey(name: 'id_field_name')
  String? idFieldName;

  @JsonKey(name: 'is_for_cur_period')
  String? isForCurPeriod;

  @JsonKey(name: 'num_of_prev_period')
  int? numOfPrevPeriod;

  @JsonKey(name: 'period_type')
  int? periodType;

  @JsonKey(name: 'job_part_name')
  String? name;

  @JsonKey(name: 'is_on')
  String? isOn;

  @JsonKey(name: 'exp_dir')
  String? expDir;

  @JsonKey(name: 'action_type')
  int? actionType;

  @JsonKey(name: 'imp_dir')
  String? impDir;

  @JsonKey(name: 'after_imp_dir')
  String? afterImpDir;

  @JsonKey(name: 'log_file_name')
  String? logFileName;

  @JsonKey(name: 'ftp_host')
  String? ftpHost;

  @JsonKey(name: 'ftp_port')
  int? ftpPort;

  @JsonKey(name: 'ftp_username')
  String? ftpUsername;

  @JsonKey(name: 'ftp_password')
  String? ftpPassword;

  @JsonKey(name: 'proxy_type')
  int? proxyType;

  @JsonKey(name: 'proxy_host')
  String? proxyHost;

  @JsonKey(name: 'proxy_port')
  int? proxyPort;

  @JsonKey(name: 'proxy_username')
  String? proxyUsername;

  @JsonKey(name: 'proxy_password')
  String? proxyPassword;

  @JsonKey(name: 'is_ftp')
  String? isFtp;

  @JsonKey(name: 'is_use_date')
  String? isUseDate;

  @JsonKey(name: 'copy_exp_dir')
  String? copyExpDir;

  @JsonKey(name: 'run_as')
  int? runAs;

  @JsonKey(name: 'user_name_as')
  String? userNameAs;

  @JsonKey(name: 'password_as')
  String? passwordAs;

  @JsonKey(name: 'last_status')
  int? lastStatus;

  @JsonKey(name: 'last_exec_date')
  DateTime? lastExecDate;

  @JsonKey(name: 'sum_field_name')
  String? sumFieldName;

  @JsonKey(name: 'ftp_ispassive_mode')
  String? ftpIspassiveMode;

  @JsonKey(name: 'show_filter_for_log')
  String? showFilterForLog;

  @JsonKey(name: 'com_file')
  String? comFile;

  @JsonKey(name: 'param_com_file')
  String? paramComFile;

  @JsonKey(name: 'is_ftp_n')
  String? isFtpN;

  @JsonKey(name: 'ftp_host_n')
  String? ftpHostN;

  @JsonKey(name: 'ftp_port_n')
  int? ftpPortN;

  @JsonKey(name: 'ftp_username_n')
  String? ftpUsernameN;

  @JsonKey(name: 'ftp_password_n')
  String? ftpPasswordN;

  @JsonKey(name: 'ftp_ispassive_mode_n')
  String? ftpIspassiveModeN;

  @JsonKey(name: 'proxy_type_n')
  int? proxyTypeN;

  @JsonKey(name: 'proxy_host_n')
  String? proxyHostN;

  @JsonKey(name: 'proxy_port_n')
  int? proxyPortN;

  @JsonKey(name: 'proxy_username_n')
  String? proxyUsernameN;

  @JsonKey(name: 'proxy_password_n')
  String? proxyPasswordN;

  @JsonKey(name: 'message_type_id')
  int? messageTypeId;

  @JsonKey(name: 'max_file_size')
  int? maxFileSize;

  @JsonKey(name: 'use_esign')
  int? useEsign;

  @JsonKey(name: 'export_type')
  int? exportType;

  @JsonKey(name: 'report_id')
  int? reportId;

  @JsonKey(name: 'sid_serial')
  String? sidSerial;

  @JsonKey(name: 'dir_in_err')
  String? dirInErr;

  @JsonKey(name: 'base_id')
  String? baseId;

  @JsonKey(name: 'is_for_cur_period_name')
  String? isForCurPeriodName;

  @JsonKey(name: 'period_type_name')
  String? periodTypeName;

  @JsonKey(name: 'is_on_name')
  String? isOnName;

  @JsonKey(name: 'is_ftp_name')
  String? isFtpName;

  @JsonKey(name: 'is_use_date_name')
  String? isUseDateName;

  @JsonKey(name: 'run_as_name')
  String? runAsName;

  @JsonKey(name: 'last_status_name')
  String? lastStatusName;

  @JsonKey(name: 'ftp_ispassive_mode_name')
  String? ftpIsPassiveModeName;

  @JsonKey(name: 'show_filter_for_log_name')
  String? showFilterForLogName;

  @JsonKey(name: 'is_ftp_n_name')
  String? isFtpNname;

  @JsonKey(name: 'ftp_ispassive_mode_n_name')
  String? ftpIspassiveModeNname;

  @JsonKey(name: 'export_type_name')
  String? exportTypeName;

  @JsonKey(name: 'error_datetime')
  DateTime? errorDatetime;

  @JsonKey(name: 'error_text')
  String? errorText;

  @JsonKey(name: 'action_type_name')
  String? actionTypeName;

  factory JobPartInsertRequest.fromJson(Map<String, dynamic> json) => _$JobPartInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JobPartInsertRequestToJson(this);


  JobPartInsertRequest({
    this.jobId,
    this.orderNum,
    this.sql,
    this.tmpFileName,
    this.idFieldName,
    this.isForCurPeriod,
    this.numOfPrevPeriod,
    this.periodType,
    this.name,
    this.isOn,
    this.expDir,
    this.actionType,
    this.impDir,
    this.afterImpDir,
    this.logFileName,
    this.ftpHost,
    this.ftpPort,
    this.ftpUsername,
    this.ftpPassword,
    this.proxyType,
    this.proxyHost,
    this.proxyPort,
    this.proxyUsername,
    this.proxyPassword,
    this.isFtp,
    this.isUseDate,
    this.copyExpDir,
    this.runAs,
    this.userNameAs,
    this.passwordAs,
    this.lastStatus,
    this.lastExecDate,
    this.sumFieldName,
    this.ftpIspassiveMode,
    this.showFilterForLog,
    this.comFile,
    this.paramComFile,
    this.isFtpN,
    this.ftpHostN,
    this.ftpPortN,
    this.ftpUsernameN,
    this.ftpPasswordN,
    this.ftpIspassiveModeN,
    this.proxyTypeN,
    this.proxyHostN,
    this.proxyPortN,
    this.proxyUsernameN,
    this.proxyPasswordN,
    this.messageTypeId,
    this.maxFileSize,
    this.useEsign,
    this.exportType,
    this.reportId,
    this.sidSerial,
    this.dirInErr,
    this.baseId,
    this.isForCurPeriodName,
    this.periodTypeName,
    this.isOnName,
    this.isFtpName,
    this.isUseDateName,
    this.runAsName,
    this.lastStatusName,
    this.ftpIsPassiveModeName,
    this.showFilterForLogName,
    this.isFtpNname,
    this.ftpIspassiveModeNname,
    this.exportTypeName,
    this.errorDatetime,
    this.errorText,
    this.actionTypeName
  });



  

  JobPartInsertRequest copyWith({
    int? jobId,
    int? orderNum,
    String? sql,
    String? tmpFileName,
    String? idFieldName,
    String? isForCurPeriod,
    int? numOfPrevPeriod,
    int? periodType,
    String? name,
    String? isOn,
    String? expDir,
    int? actionType,
    String? impDir,
    String? afterImpDir,
    String? logFileName,
    String? ftpHost,
    int? ftpPort,
    String? ftpUsername,
    String? ftpPassword,
    int? proxyType,
    String? proxyHost,
    int? proxyPort,
    String? proxyUsername,
    String? proxyPassword,
    String? isFtp,
    String? isUseDate,
    String? copyExpDir,
    int? runAs,
    String? userNameAs,
    String? passwordAs,
    int? lastStatus,
    DateTime? lastExecDate,
    String? sumFieldName,
    String? ftpIspassiveMode,
    String? showFilterForLog,
    String? comFile,
    String? paramComFile,
    String? isFtpN,
    String? ftpHostN,
    int? ftpPortN,
    String? ftpUsernameN,
    String? ftpPasswordN,
    String? ftpIspassiveModeN,
    int? proxyTypeN,
    String? proxyHostN,
    int? proxyPortN,
    String? proxyUsernameN,
    String? proxyPasswordN,
    int? messageTypeId,
    int? maxFileSize,
    int? useEsign,
    int? exportType,
    int? reportId,
    String? sidSerial,
    String? dirInErr,
    String? baseId,
    String? isForCurPeriodName,
    String? periodTypeName,
    String? isOnName,
    String? isFtpName,
    String? isUseDateName,
    String? runAsName,
    String? lastStatusName,
    String? ftpIsPassiveModeName,
    String? showFilterForLogName,
    String? isFtpNname,
    String? ftpIspassiveModeNname,
    String? exportTypeName,
    DateTime? errorDatetime,
    String? errorText,
    String? actionTypeName,
  }) => JobPartInsertRequest(
      jobId: jobId ?? this.jobId,
      orderNum: orderNum ?? this.orderNum,
      sql: sql ?? this.sql,
      tmpFileName: tmpFileName ?? this.tmpFileName,
      idFieldName: idFieldName ?? this.idFieldName,
      isForCurPeriod: isForCurPeriod ?? this.isForCurPeriod,
      numOfPrevPeriod: numOfPrevPeriod ?? this.numOfPrevPeriod,
      periodType: periodType ?? this.periodType,
      name: name ?? this.name,
      isOn: isOn ?? this.isOn,
      expDir: expDir ?? this.expDir,
      actionType: actionType ?? this.actionType,
      impDir: impDir ?? this.impDir,
      afterImpDir: afterImpDir ?? this.afterImpDir,
      logFileName: logFileName ?? this.logFileName,
      ftpHost: ftpHost ?? this.ftpHost,
      ftpPort: ftpPort ?? this.ftpPort,
      ftpUsername: ftpUsername ?? this.ftpUsername,
      ftpPassword: ftpPassword ?? this.ftpPassword,
      proxyType: proxyType ?? this.proxyType,
      proxyHost: proxyHost ?? this.proxyHost,
      proxyPort: proxyPort ?? this.proxyPort,
      proxyUsername: proxyUsername ?? this.proxyUsername,
      proxyPassword: proxyPassword ?? this.proxyPassword,
      isFtp: isFtp ?? this.isFtp,
      isUseDate: isUseDate ?? this.isUseDate,
      copyExpDir: copyExpDir ?? this.copyExpDir,
      runAs: runAs ?? this.runAs,
      userNameAs: userNameAs ?? this.userNameAs,
      passwordAs: passwordAs ?? this.passwordAs,
      lastStatus: lastStatus ?? this.lastStatus,
      lastExecDate: lastExecDate ?? this.lastExecDate,
      sumFieldName: sumFieldName ?? this.sumFieldName,
      ftpIspassiveMode: ftpIspassiveMode ?? this.ftpIspassiveMode,
      showFilterForLog: showFilterForLog ?? this.showFilterForLog,
      comFile: comFile ?? this.comFile,
      paramComFile: paramComFile ?? this.paramComFile,
      isFtpN: isFtpN ?? this.isFtpN,
      ftpHostN: ftpHostN ?? this.ftpHostN,
      ftpPortN: ftpPortN ?? this.ftpPortN,
      ftpUsernameN: ftpUsernameN ?? this.ftpUsernameN,
      ftpPasswordN: ftpPasswordN ?? this.ftpPasswordN,
      ftpIspassiveModeN: ftpIspassiveModeN ?? this.ftpIspassiveModeN,
      proxyTypeN: proxyTypeN ?? this.proxyTypeN,
      proxyHostN: proxyHostN ?? this.proxyHostN,
      proxyPortN: proxyPortN ?? this.proxyPortN,
      proxyUsernameN: proxyUsernameN ?? this.proxyUsernameN,
      proxyPasswordN: proxyPasswordN ?? this.proxyPasswordN,
      messageTypeId: messageTypeId ?? this.messageTypeId,
      maxFileSize: maxFileSize ?? this.maxFileSize,
      useEsign: useEsign ?? this.useEsign,
      exportType: exportType ?? this.exportType,
      reportId: reportId ?? this.reportId,
      sidSerial: sidSerial ?? this.sidSerial,
      dirInErr: dirInErr ?? this.dirInErr,
      baseId: baseId ?? this.baseId,
      isForCurPeriodName: isForCurPeriodName ?? this.isForCurPeriodName,
      periodTypeName: periodTypeName ?? this.periodTypeName,
      isOnName: isOnName ?? this.isOnName,
      isFtpName: isFtpName ?? this.isFtpName,
      isUseDateName: isUseDateName ?? this.isUseDateName,
      runAsName: runAsName ?? this.runAsName,
      lastStatusName: lastStatusName ?? this.lastStatusName,
      ftpIsPassiveModeName: ftpIsPassiveModeName ?? this.ftpIsPassiveModeName,
      showFilterForLogName: showFilterForLogName ?? this.showFilterForLogName,
      isFtpNname: isFtpNname ?? this.isFtpNname,
      ftpIspassiveModeNname: ftpIspassiveModeNname ?? this.ftpIspassiveModeNname,
      exportTypeName: exportTypeName ?? this.exportTypeName,
      errorDatetime: errorDatetime ?? this.errorDatetime,
      errorText: errorText ?? this.errorText,
      actionTypeName: actionTypeName ?? this.actionTypeName,
    );
}
