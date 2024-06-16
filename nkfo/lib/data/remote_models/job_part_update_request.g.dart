// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_part_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPartUpdateRequest _$JobPartUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    JobPartUpdateRequest(
      jobId: json['job_id'] as int?,
      orderNum: json['order_num'] as int?,
      sql: json['sql'] as String?,
      tmpFileName: json['tmp_file_name'] as String?,
      idFieldName: json['id_field_name'] as String?,
      isForCurPeriod: json['is_for_cur_period'] as String?,
      numOfPrevPeriod: json['num_of_prev_period'] as int?,
      periodType: json['period_type'] as int?,
      name: json['job_part_name'] as String?,
      isOn: json['is_on'] as String?,
      expDir: json['exp_dir'] as String?,
      actionType: json['action_type'] as int?,
      impDir: json['imp_dir'] as String?,
      afterImpDir: json['after_imp_dir'] as String?,
      logFileName: json['log_file_name'] as String?,
      ftpHost: json['ftp_host'] as String?,
      ftpPort: json['ftp_port'] as int?,
      ftpUsername: json['ftp_username'] as String?,
      ftpPassword: json['ftp_password'] as String?,
      proxyType: json['proxy_type'] as int?,
      proxyHost: json['proxy_host'] as String?,
      proxyPort: json['proxy_port'] as int?,
      proxyUsername: json['proxy_username'] as String?,
      proxyPassword: json['proxy_password'] as String?,
      isFtp: json['is_ftp'] as String?,
      isUseDate: json['is_use_date'] as String?,
      copyExpDir: json['copy_exp_dir'] as String?,
      runAs: json['run_as'] as int?,
      userNameAs: json['user_name_as'] as String?,
      passwordAs: json['password_as'] as String?,
      lastStatus: json['last_status'] as int?,
      lastExecDate: json['last_exec_date'] == null
          ? null
          : DateTime.parse(json['last_exec_date'] as String),
      sumFieldName: json['sum_field_name'] as String?,
      ftpIspassiveMode: json['ftp_ispassive_mode'] as String?,
      showFilterForLog: json['show_filter_for_log'] as String?,
      comFile: json['com_file'] as String?,
      paramComFile: json['param_com_file'] as String?,
      isFtpN: json['is_ftp_n'] as String?,
      ftpHostN: json['ftp_host_n'] as String?,
      ftpPortN: json['ftp_port_n'] as int?,
      ftpUsernameN: json['ftp_username_n'] as String?,
      ftpPasswordN: json['ftp_password_n'] as String?,
      ftpIspassiveModeN: json['ftp_ispassive_mode_n'] as String?,
      proxyTypeN: json['proxy_type_n'] as int?,
      proxyHostN: json['proxy_host_n'] as String?,
      proxyPortN: json['proxy_port_n'] as int?,
      proxyUsernameN: json['proxy_username_n'] as String?,
      proxyPasswordN: json['proxy_password_n'] as String?,
      messageTypeId: json['message_type_id'] as int?,
      maxFileSize: json['max_file_size'] as int?,
      useEsign: json['use_esign'] as int?,
      exportType: json['export_type'] as int?,
      reportId: json['report_id'] as int?,
      sidSerial: json['sid_serial'] as String?,
      dirInErr: json['dir_in_err'] as String?,
      baseId: json['base_id'] as String?,
      isForCurPeriodName: json['is_for_cur_period_name'] as String?,
      periodTypeName: json['period_type_name'] as String?,
      isOnName: json['is_on_name'] as String?,
      isFtpName: json['is_ftp_name'] as String?,
      isUseDateName: json['is_use_date_name'] as String?,
      runAsName: json['run_as_name'] as String?,
      lastStatusName: json['last_status_name'] as String?,
      ftpIsPassiveModeName: json['ftp_ispassive_mode_name'] as String?,
      showFilterForLogName: json['show_filter_for_log_name'] as String?,
      isFtpNname: json['is_ftp_n_name'] as String?,
      ftpIspassiveModeNname: json['ftp_ispassive_mode_n_name'] as String?,
      exportTypeName: json['export_type_name'] as String?,
      errorDatetime: json['error_datetime'] == null
          ? null
          : DateTime.parse(json['error_datetime'] as String),
      errorText: json['error_text'] as String?,
      actionTypeName: json['action_type_name'] as String?,
    );

Map<String, dynamic> _$JobPartUpdateRequestToJson(
    JobPartUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_id', instance.jobId);
  writeNotNull('order_num', instance.orderNum);
  writeNotNull('sql', instance.sql);
  writeNotNull('tmp_file_name', instance.tmpFileName);
  writeNotNull('id_field_name', instance.idFieldName);
  writeNotNull('is_for_cur_period', instance.isForCurPeriod);
  writeNotNull('num_of_prev_period', instance.numOfPrevPeriod);
  writeNotNull('period_type', instance.periodType);
  writeNotNull('job_part_name', instance.name);
  writeNotNull('is_on', instance.isOn);
  writeNotNull('exp_dir', instance.expDir);
  writeNotNull('action_type', instance.actionType);
  writeNotNull('imp_dir', instance.impDir);
  writeNotNull('after_imp_dir', instance.afterImpDir);
  writeNotNull('log_file_name', instance.logFileName);
  writeNotNull('ftp_host', instance.ftpHost);
  writeNotNull('ftp_port', instance.ftpPort);
  writeNotNull('ftp_username', instance.ftpUsername);
  writeNotNull('ftp_password', instance.ftpPassword);
  writeNotNull('proxy_type', instance.proxyType);
  writeNotNull('proxy_host', instance.proxyHost);
  writeNotNull('proxy_port', instance.proxyPort);
  writeNotNull('proxy_username', instance.proxyUsername);
  writeNotNull('proxy_password', instance.proxyPassword);
  writeNotNull('is_ftp', instance.isFtp);
  writeNotNull('is_use_date', instance.isUseDate);
  writeNotNull('copy_exp_dir', instance.copyExpDir);
  writeNotNull('run_as', instance.runAs);
  writeNotNull('user_name_as', instance.userNameAs);
  writeNotNull('password_as', instance.passwordAs);
  writeNotNull('last_status', instance.lastStatus);
  writeNotNull('last_exec_date', instance.lastExecDate?.toIso8601String());
  writeNotNull('sum_field_name', instance.sumFieldName);
  writeNotNull('ftp_ispassive_mode', instance.ftpIspassiveMode);
  writeNotNull('show_filter_for_log', instance.showFilterForLog);
  writeNotNull('com_file', instance.comFile);
  writeNotNull('param_com_file', instance.paramComFile);
  writeNotNull('is_ftp_n', instance.isFtpN);
  writeNotNull('ftp_host_n', instance.ftpHostN);
  writeNotNull('ftp_port_n', instance.ftpPortN);
  writeNotNull('ftp_username_n', instance.ftpUsernameN);
  writeNotNull('ftp_password_n', instance.ftpPasswordN);
  writeNotNull('ftp_ispassive_mode_n', instance.ftpIspassiveModeN);
  writeNotNull('proxy_type_n', instance.proxyTypeN);
  writeNotNull('proxy_host_n', instance.proxyHostN);
  writeNotNull('proxy_port_n', instance.proxyPortN);
  writeNotNull('proxy_username_n', instance.proxyUsernameN);
  writeNotNull('proxy_password_n', instance.proxyPasswordN);
  writeNotNull('message_type_id', instance.messageTypeId);
  writeNotNull('max_file_size', instance.maxFileSize);
  writeNotNull('use_esign', instance.useEsign);
  writeNotNull('export_type', instance.exportType);
  writeNotNull('report_id', instance.reportId);
  writeNotNull('sid_serial', instance.sidSerial);
  writeNotNull('dir_in_err', instance.dirInErr);
  writeNotNull('base_id', instance.baseId);
  writeNotNull('is_for_cur_period_name', instance.isForCurPeriodName);
  writeNotNull('period_type_name', instance.periodTypeName);
  writeNotNull('is_on_name', instance.isOnName);
  writeNotNull('is_ftp_name', instance.isFtpName);
  writeNotNull('is_use_date_name', instance.isUseDateName);
  writeNotNull('run_as_name', instance.runAsName);
  writeNotNull('last_status_name', instance.lastStatusName);
  writeNotNull('ftp_ispassive_mode_name', instance.ftpIsPassiveModeName);
  writeNotNull('show_filter_for_log_name', instance.showFilterForLogName);
  writeNotNull('is_ftp_n_name', instance.isFtpNname);
  writeNotNull('ftp_ispassive_mode_n_name', instance.ftpIspassiveModeNname);
  writeNotNull('export_type_name', instance.exportTypeName);
  writeNotNull('error_datetime', instance.errorDatetime?.toIso8601String());
  writeNotNull('error_text', instance.errorText);
  writeNotNull('action_type_name', instance.actionTypeName);
  return val;
}
