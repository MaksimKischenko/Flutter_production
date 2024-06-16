import 'package:data_table_2/data_table_2.dart';

enum TasksPartParamSort {
  jobPartParamId, jobPartId, name, isAutoInc, isAutoClearAtNewDay,
  accessType, paramTypeId, paramValue
}

extension TasksPartParamSortExtension on TasksPartParamSort {

  static const Map<TasksPartParamSort, String> _sortToDBFieldName = {
    TasksPartParamSort.jobPartParamId: 'job_part_param_id',
    TasksPartParamSort.jobPartId: 'job_part_id',
    TasksPartParamSort.name: 'param_name',
    TasksPartParamSort.isAutoInc: 'is_auto_inc',
    TasksPartParamSort.isAutoClearAtNewDay: 'is_auto_clear_at_new_day',
    TasksPartParamSort.accessType: 'access_type',
    TasksPartParamSort.paramTypeId: 'param_type_id',
    TasksPartParamSort.paramValue: 'param_value',
  };

   // ignore: non_constant_identifier_names
   String get DBName => _sortToDBFieldName[this]!;

  static TasksPartParamSort fromDBName(String name) => _sortToDBFieldName.entries.singleWhere((e) => e.value == name).key;

  static const Map<TasksPartParamSort, String> _sortToName = {
    TasksPartParamSort.jobPartParamId: 'ID параметра',
    TasksPartParamSort.jobPartId: 'ID части назначенного задания',
    TasksPartParamSort.name: 'Наименование параметра',
    TasksPartParamSort.isAutoInc: 'Увеличение индекса',
    TasksPartParamSort.isAutoClearAtNewDay: 'Автоматический сброс каждый день',
    TasksPartParamSort.accessType: 'Доступ',
    TasksPartParamSort.paramTypeId: 'Тип параметра',
    TasksPartParamSort.paramValue: 'Значение параметра',
  };

  String get name => _sortToName[this]!;

  static const Map<TasksPartParamSort, ColumnSize> _sortToColumnSize = {
    TasksPartParamSort.jobPartParamId: ColumnSize.M,
    TasksPartParamSort.jobPartId: ColumnSize.M,
    TasksPartParamSort.name: ColumnSize.M,
    TasksPartParamSort.isAutoInc: ColumnSize.M,
    TasksPartParamSort.isAutoClearAtNewDay: ColumnSize.M,
    TasksPartParamSort.accessType: ColumnSize.M,
    TasksPartParamSort.paramTypeId: ColumnSize.M,
    TasksPartParamSort.paramValue: ColumnSize.M,
  };

  ColumnSize get columnSize => _sortToColumnSize[this] ?? ColumnSize.M;

}