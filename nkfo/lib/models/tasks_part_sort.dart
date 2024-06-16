import 'package:data_table_2/data_table_2.dart';

enum TasksPartSort {
  id, jobId, orderNum, sql, tmpFileName, idFieldName, isForCurPeriod,
  numOfPrevPeriod, periodType, name, isOn, expDir, actionType, impDir,
  afterImpDir, logFileName, isUseDate, copyExpDir, lastStatus,lastExecDate,
  comFile, paramComFile, messageTypeId, maxFileSize, dirInErr
}

extension TasksPartSortExtension on TasksPartSort {

  static const Map<TasksPartSort, String> _sortToDBFieldName = {
    TasksPartSort.id: 'job_part_id',
    TasksPartSort.jobId: 'job_id',
    TasksPartSort.orderNum: 'order_num',
    TasksPartSort.sql: 'sql',
    TasksPartSort.tmpFileName: 'tmp_file_name',
    TasksPartSort.idFieldName: 'id_field_name',
    TasksPartSort.isForCurPeriod: 'is_for_cur_period',
    TasksPartSort.numOfPrevPeriod: 'num_of_prev_period',
    TasksPartSort.periodType: 'period_type',
    TasksPartSort.name: 'job_part_name',
    TasksPartSort.isOn: 'is_on',
    TasksPartSort.expDir: 'exp_dir',
    TasksPartSort.actionType: 'action_type',
    TasksPartSort.impDir: 'imp_dir',
    TasksPartSort.afterImpDir: 'after_imp_dir',
    TasksPartSort.logFileName: 'log_file_name',
    TasksPartSort.isUseDate: 'is_use_date',
    TasksPartSort.copyExpDir: 'copy_exp_dir',
    TasksPartSort.lastStatus: 'last_status',
    TasksPartSort.lastExecDate: 'last_exec_date',
    TasksPartSort.comFile: 'com_file',
    TasksPartSort.paramComFile: 'param_com_file',
    TasksPartSort.messageTypeId: 'message_type_id',
    TasksPartSort.maxFileSize: 'max_file_size',
    TasksPartSort.dirInErr: 'dir_in_err',
  };

   // ignore: non_constant_identifier_names
   String get DBName => _sortToDBFieldName[this]!;

  static TasksPartSort fromDBName(String name) => _sortToDBFieldName.entries.singleWhere((e) => e.value == name).key;

  static const Map<TasksPartSort, String> _sortToName = {
    TasksPartSort.id: 'ID \nчасти \nзадания',
    TasksPartSort.jobId: 'ID задания',
    TasksPartSort.orderNum: 'Порядковый \nномер \nвыполнения',
    TasksPartSort.sql: 'SQL-запрос',
    TasksPartSort.tmpFileName: 'Файл-шаблон',
    TasksPartSort.idFieldName: 'Наименование \nID поля',
    TasksPartSort.isForCurPeriod: 'За текущий \nпериод',
    TasksPartSort.numOfPrevPeriod: 'Кол-во \nпредыдущих \nпериодов',
    TasksPartSort.periodType: 'Тип периода',
    TasksPartSort.name: 'Наименование',
    TasksPartSort.isOn: 'Вкл/выкл',
    TasksPartSort.expDir: 'Директория экспорта',
    TasksPartSort.actionType: 'Тип действия',
    TasksPartSort.impDir: 'Директория импорта',
    TasksPartSort.afterImpDir: 'Директория обработанных файлов',
    TasksPartSort.logFileName: 'Log-файл',
    TasksPartSort.isUseDate: 'Формировать за период',
    TasksPartSort.copyExpDir: 'Директория экспорта копии',
    TasksPartSort.lastStatus: 'Результат последнего выполнения',
    TasksPartSort.lastExecDate: 'Дата последнего выполнения',
    TasksPartSort.comFile: 'Командный файл пос. обработки',
    TasksPartSort.paramComFile: 'Параметры командного файла пос. обработки',
    TasksPartSort.messageTypeId: 'Тип сообщения',
    TasksPartSort.maxFileSize: 'Максимальный размер файла',
    TasksPartSort.dirInErr: 'Директория ошибок',
  };

  String get name => _sortToName[this]!;

  static const Map<TasksPartSort, ColumnSize> _sortToColumnSize = {
    TasksPartSort.id: ColumnSize.M,
    TasksPartSort.jobId: ColumnSize.M,
    TasksPartSort.orderNum: ColumnSize.M,
    TasksPartSort.sql: ColumnSize.L,
    TasksPartSort.tmpFileName: ColumnSize.M,
    TasksPartSort.idFieldName: ColumnSize.M,
    TasksPartSort.isForCurPeriod: ColumnSize.M,
    TasksPartSort.numOfPrevPeriod: ColumnSize.M,
    TasksPartSort.periodType: ColumnSize.M,
    TasksPartSort.name: ColumnSize.M,
    TasksPartSort.isOn: ColumnSize.M,
    TasksPartSort.expDir: ColumnSize.M,
    TasksPartSort.actionType: ColumnSize.M,
    TasksPartSort.impDir: ColumnSize.M,
    TasksPartSort.afterImpDir: ColumnSize.M,
    TasksPartSort.logFileName: ColumnSize.M,
    TasksPartSort.isUseDate: ColumnSize.M,
    TasksPartSort.copyExpDir: ColumnSize.M,
    TasksPartSort.lastStatus: ColumnSize.M,
    TasksPartSort.lastExecDate: ColumnSize.M,
    TasksPartSort.comFile: ColumnSize.M,
    TasksPartSort.paramComFile: ColumnSize.M,
    TasksPartSort.messageTypeId: ColumnSize.M,
    TasksPartSort.maxFileSize: ColumnSize.M,
    TasksPartSort.dirInErr: ColumnSize.M,
  };

  ColumnSize get columnSize => _sortToColumnSize[this] ?? ColumnSize.M;

}