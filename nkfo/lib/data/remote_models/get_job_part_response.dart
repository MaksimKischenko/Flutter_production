import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_job_part_response.g.dart';

@JsonSerializable()
class JobPart extends Equatable {
  @JsonKey(name: 'job_part_id')
  final int jobPartId;

  @JsonKey(name: 'job_id')
  final int jobId;

  @JsonKey(name: 'order_num')
  final int? orderNum;

  @JsonKey(name: 'sql')
  final String? sql;

  @JsonKey(name: 'tmp_file_name')
  final String? tmpFileName;

  @JsonKey(name: 'id_field_name')
  final String? idFieldName;

  @JsonKey(name: 'is_for_cur_period')
  final String? isForCurPeriod;

  @JsonKey(name: 'num_of_prev_period')
  final int? numOfPrevPeriod;

  @JsonKey(name: 'period_type')
  final int? periodType;

  @JsonKey(name: 'job_part_name')
  final String? name;

  @JsonKey(name: 'is_on')
  final String? isOn;

  @JsonKey(name: 'exp_dir')
  final String? expDir;

  @JsonKey(name: 'action_type')
  final int? actionType;

  @JsonKey(name: 'imp_dir')
  final String? impDir;

  @JsonKey(name: 'after_imp_dir')
  final String? afterImpDir;

  @JsonKey(name: 'log_file_name')
  final String? logFileName;

  @JsonKey(name: 'ftp_host')
  final String? ftpHost;

  @JsonKey(name: 'ftp_port')
  final int? ftpPort;

  @JsonKey(name: 'ftp_username')
  final String? ftpUsername;

  @JsonKey(name: 'ftp_password')
  final String? ftpPassword;

  @JsonKey(name: 'proxy_type')
  final int? proxyType;

  @JsonKey(name: 'proxy_host')
  final String? proxyHost;

  @JsonKey(name: 'proxy_port')
  final int? proxyPort;

  @JsonKey(name: 'proxy_username')
  final String? proxyUsername;

  @JsonKey(name: 'proxy_password')
  final String? proxyPassword;

  @JsonKey(name: 'is_ftp')
  final String? isFtp;

  @JsonKey(name: 'is_use_date')
  final String? isUseDate;

  @JsonKey(name: 'copy_exp_dir')
  final String? copyExpDir;

  @JsonKey(name: 'run_as')
  final int? runAs;

  @JsonKey(name: 'user_name_as')
  final String? userNameAs;

  @JsonKey(name: 'password_as')
  final String? passwordAs;

  @JsonKey(name: 'last_status')
  final int? lastStatus;

  @JsonKey(name: 'last_exec_date')
  final DateTime? lastExecDate;

  @JsonKey(name: 'sum_field_name')
  final String? sumFieldName;

  @JsonKey(name: 'ftp_ispassive_mode')
  final String? ftpIspassiveMode;

  @JsonKey(name: 'show_filter_for_log')
  final String? showFilterForLog;

  @JsonKey(name: 'com_file')
  final String? comFile;

  @JsonKey(name: 'param_com_file')
  final String? paramComFile;

  @JsonKey(name: 'is_ftp_n')
  final String? isFtpN;

  @JsonKey(name: 'ftp_host_n')
  final String? ftpHostN;

  @JsonKey(name: 'ftp_port_n')
  final int? ftpPortN;

  @JsonKey(name: 'ftp_username_n')
  final String? ftpUsernameN;

  @JsonKey(name: 'ftp_password_n')
  final String? ftpPasswordN;

  @JsonKey(name: 'ftp_ispassive_mode_n')
  final String? ftpIspassiveModeN;

  @JsonKey(name: 'proxy_type_n')
  final int? proxyTypeN;

  @JsonKey(name: 'proxy_host_n')
  final String? proxyHostN;

  @JsonKey(name: 'proxy_port_n')
  final int? proxyPortN;

  @JsonKey(name: 'proxy_username_n')
  final String? proxyUsernameN;

  @JsonKey(name: 'proxy_password_n')
  final String? proxyPasswordN;

  @JsonKey(name: 'message_type_id')
  final int? messageTypeId;

  @JsonKey(name: 'max_file_size')
  final int? maxFileSize;

  @JsonKey(name: 'use_esign')
  final int? useEsign;

  @JsonKey(name: 'export_type')
  final int? exportType;

  @JsonKey(name: 'report_id')
  final int? reportId;

  @JsonKey(name: 'sid_serial')
  final String? sidSerial;

  @JsonKey(name: 'dir_in_err')
  final String? dirInErr;

  @JsonKey(name: 'base_id')
  final String? baseId;

  @JsonKey(name: 'is_for_cur_period_name')
  final String? isForCurPeriodName;

  @JsonKey(name: 'period_type_name')
  final String? periodTypeName;

  @JsonKey(name: 'is_on_name')
  final String? isOnName;

  @JsonKey(name: 'is_ftp_name')
  final String? isFtpName;

  @JsonKey(name: 'is_use_date_name')
  final String? isUseDateName;

  @JsonKey(name: 'run_as_name')
  final String? runAsName;

  @JsonKey(name: 'last_status_name')
  final String? lastStatusName;

  @JsonKey(name: 'ftp_ispassive_mode_name')
  final String? ftpIsPassiveModeName;

  @JsonKey(name: 'show_filter_for_log_name')
  final String? showFilterForLogName;

  @JsonKey(name: 'is_ftp_n_name')
  final String? isFtpNname;

  @JsonKey(name: 'ftp_ispassive_mode_n_name')
  final String? ftpIspassiveModeNname;

  @JsonKey(name: 'export_type_name')
  final String? exportTypeName;

  @JsonKey(name: 'error_datetime')
  final DateTime? errorDatetime;

  @JsonKey(name: 'error_text')
  final String? errorText;

  @JsonKey(name: 'action_type_name')
  final String? actionTypeName;

  @JsonKey(name: 'st')
  final int? jobPartStatus;

  const JobPart(
      {required this.jobPartId,
      required this.jobId,
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
      this.actionTypeName,
      this.jobPartStatus});

  factory JobPart.fromJson(Map<String, dynamic> json) =>
      _$JobPartFromJson(json);

  Map<String, dynamic> toJson() => _$JobPartToJson(this);

  @override
  String toString() => 'JobPart($jobPartId)';

  JobPart copyWith(
          {int? jobPartId,
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
          int? jobPartStatus}) =>
      JobPart(
          jobPartId: jobPartId ?? this.jobPartId,
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
          ftpIsPassiveModeName:
              ftpIsPassiveModeName ?? this.ftpIsPassiveModeName,
          showFilterForLogName:
              showFilterForLogName ?? this.showFilterForLogName,
          isFtpNname: isFtpNname ?? this.isFtpNname,
          ftpIspassiveModeNname:
              ftpIspassiveModeNname ?? this.ftpIspassiveModeNname,
          exportTypeName: exportTypeName ?? this.exportTypeName,
          errorDatetime: errorDatetime ?? this.errorDatetime,
          errorText: errorText ?? this.errorText,
          actionTypeName: actionTypeName ?? this.actionTypeName,
          jobPartStatus: jobPartStatus ?? this.jobPartStatus);

  @override
  List<Object?> get props => [
        jobPartId,
        jobId,
        orderNum,
        sql,
        tmpFileName,
        idFieldName,
        isForCurPeriod,
        numOfPrevPeriod,
        periodType,
        name,
        isOn,
        expDir,
        actionType,
        impDir,
        afterImpDir,
        logFileName,
        ftpHost,
        ftpPort,
        ftpUsername,
        ftpPassword,
        proxyType,
        proxyHost,
        proxyPort,
        proxyUsername,
        proxyPassword,
        isFtp,
        isUseDate,
        copyExpDir,
        runAs,
        userNameAs,
        passwordAs,
        lastStatus,
        lastExecDate,
        sumFieldName,
        ftpIspassiveMode,
        showFilterForLog,
        comFile,
        paramComFile,
        isFtpN,
        ftpHostN,
        ftpPortN,
        ftpUsernameN,
        ftpPasswordN,
        ftpIspassiveModeN,
        proxyTypeN,
        proxyHostN,
        proxyPortN,
        proxyUsernameN,
        proxyPasswordN,
        messageTypeId,
        maxFileSize,
        useEsign,
        exportType,
        reportId,
        sidSerial,
        dirInErr,
        baseId,
        isForCurPeriodName,
        periodTypeName,
        isOnName,
        isFtpName,
        isUseDateName,
        runAsName,
        lastStatusName,
        ftpIsPassiveModeName,
        showFilterForLogName,
        isFtpNname,
        ftpIspassiveModeNname,
        exportTypeName,
        errorDatetime,
        errorText,
        actionTypeName,
        jobPartStatus
      ];
}
