import 'package:data_table_2/data_table_2.dart';

enum UnassignedTasksSort {
  id, name, startDate, outServerId, lastExec, isOn, existsResult, 
  isBreakJobPart, isOnce, isMinute, isDay, isWeek, isDayMonth, 
  isLastMonthDay, everyN, isFromToTime, fromTime, toTime, isWorkDay, everyNMin
}

extension UnassignedTasksSortExtension on UnassignedTasksSort {

  static const Map<UnassignedTasksSort, String> _sortToDBFieldName = {
    UnassignedTasksSort.id: 'job_id',
    UnassignedTasksSort.name: 'job_name',
    UnassignedTasksSort.startDate: 'start_date',
    UnassignedTasksSort.outServerId: 'out_server_id',
    UnassignedTasksSort.lastExec: 'last_exec',
    UnassignedTasksSort.isOn: 'is_on',
    UnassignedTasksSort.existsResult: 'st', 
    UnassignedTasksSort.isBreakJobPart: 'is_break_job_part',
    UnassignedTasksSort.isOnce: 'is_once_name',
    UnassignedTasksSort.isMinute: 'is_minute_name',
    UnassignedTasksSort.isDay: 'is_work_day_name',
    UnassignedTasksSort.isWeek: 'is_week_name',
    UnassignedTasksSort.isDayMonth: 'is_daymonth_name',
    UnassignedTasksSort.isLastMonthDay: 'is_last_month_day_name',
    UnassignedTasksSort.everyN: 'num',
    UnassignedTasksSort.isFromToTime: 'is_from_to_time_name',
    UnassignedTasksSort.fromTime: 'min_time_from', 
    UnassignedTasksSort.toTime: 'min_time_to',
    UnassignedTasksSort.isWorkDay: 'is_work_day_name',
    UnassignedTasksSort.everyNMin: 'minute_num'
  };

   // ignore: non_constant_identifier_names
   String get DBName => _sortToDBFieldName[this]!;

  static UnassignedTasksSort fromDBName(String name) => _sortToDBFieldName.entries.singleWhere((e) => e.value == name).key;

  static const Map<UnassignedTasksSort, String> _sortToName = {
    UnassignedTasksSort.id: 'ID задания',
    UnassignedTasksSort.name: 'Наименование задания',
    UnassignedTasksSort.startDate: 'Время следующего запуска',
    UnassignedTasksSort.outServerId: 'ID сервера обработки \nзапросов',
    UnassignedTasksSort.lastExec: 'Время последнего \nвыполнения',
    UnassignedTasksSort.isOn: 'Вкл/выкл',
    UnassignedTasksSort.existsResult: 'Результат выполнения',
    UnassignedTasksSort.isBreakJobPart: 'Прервать \nзадание \nпри ошибке',
    UnassignedTasksSort.isOnce: 'Однократно',
    UnassignedTasksSort.isMinute: 'Ежеминутно',
    UnassignedTasksSort.isDay: 'Ежедневно',
    UnassignedTasksSort.isWeek: 'Еженедельно',
    UnassignedTasksSort.isDayMonth: 'Ежемесячно',
    UnassignedTasksSort.isLastMonthDay: 'Последний \nдень месяца',
    UnassignedTasksSort.everyN: 'Каждые N',
    UnassignedTasksSort.isFromToTime: 'Только с* \nи по * время',
    UnassignedTasksSort.fromTime: 'С * времени', 
    UnassignedTasksSort.toTime: 'По * время',
    UnassignedTasksSort.isWorkDay: 'По рабочим \nдням',
    UnassignedTasksSort.everyNMin: 'Каждые N \nминут'
  };

  String get name => _sortToName[this]!;

  static const Map<UnassignedTasksSort, ColumnSize> _sortToColumnSize = {
    UnassignedTasksSort.id: ColumnSize.M,
    UnassignedTasksSort.name: ColumnSize.M,
    UnassignedTasksSort.startDate: ColumnSize.M,
    UnassignedTasksSort.outServerId: ColumnSize.M,
    UnassignedTasksSort.lastExec: ColumnSize.M,
    UnassignedTasksSort.isOn: ColumnSize.M,
    UnassignedTasksSort.existsResult: ColumnSize.M,
    UnassignedTasksSort.isBreakJobPart: ColumnSize.M,
    UnassignedTasksSort.isOnce: ColumnSize.M,
    UnassignedTasksSort.isMinute: ColumnSize.M,
    UnassignedTasksSort.isDay: ColumnSize.M,
    UnassignedTasksSort.isWeek: ColumnSize.M,
    UnassignedTasksSort.isDayMonth: ColumnSize.M,
    UnassignedTasksSort.isLastMonthDay: ColumnSize.M,
    UnassignedTasksSort.everyN: ColumnSize.M,
    UnassignedTasksSort.isFromToTime: ColumnSize.M,
    UnassignedTasksSort.fromTime: ColumnSize.M,
    UnassignedTasksSort.toTime: ColumnSize.M,
    UnassignedTasksSort.isWorkDay: ColumnSize.M,
    UnassignedTasksSort.everyNMin: ColumnSize.M,
  };

  ColumnSize get columnSize => _sortToColumnSize[this] ?? ColumnSize.M;

}