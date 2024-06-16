import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_plus/data_table_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/screens/jobs_manager/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class JobsPart extends StatefulWidget {
  @override
  _JobsPartState createState() => _JobsPartState();
}

class _JobsPartState extends State<JobsPart> {
  int _selectedRow = -1;
  String? jobName;
  String? jobPartName;
  int? jobId;
  JobPart? _selectedJobPart;
  bool _addIsAvaliable = true;
  bool _editIsAvaliable = true;
  bool _deleteIsAvaliable = true;
  bool _jobPartRunIsAvaliable = true;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<JobsPartBloc, JobsPartState>(
              builder: (context, state) {
                Widget body = Container();
                if (state is JobsPartLoaded) {
                  jobName = state.jobName;
                  jobId = state.jobId;
                  body = Text(
                    'Задание: $jobName',
                    style: AppStyles.headerTextStyleLess
                  );
                }
                return body;
              },
            ),
            BlocConsumer<JobsPartBloc, JobsPartState>(
              listener: (context, state) {
                if (state is JobsPartError) {
                  RequestUtil.catchNetworkError(
                      context: context, obj: state.error);
                } else if (state is JobsPartDeleteJobPartSuccess) {
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Часть задания ${state.jobPart.name} удалена',
                    type: DialogType.success
                  );
                }
              }, 
              buildWhen: (prev, next) {
                if (next is JobsPartError) return false;
                if (next is JobsPartLoading) return false;
                if (next is JobsPartLoaded) return true;
                return true;
              }, 
             builder: (context, state) {
              Widget body = Container();
              if (state is JobsPartNoInfo) {
                body = Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        SizedBox(height: MediaQuery.of(context).size.height/4),
                        if (state.jobIsAvialable) const SvgAssets('icon/dialog_info.svg') else const SvgAssets('icon/dialog_error.svg'),
                        Text(state.message, style: AppStyles.headerTextStyleLess, textAlign: TextAlign.center),
                      ],
                    ),
                  );
              } else if(state is JobsPartLoading) {
              body = Center(
                child: Column(
                    children:  [
                      SizedBox(height: MediaQuery.of(context).size.height/4),
                      const LoadingIndicator(
                        indicatorsSize: 80,
                      ),
                    ],
                  ),
                );                
              } else if (state is JobsPartLoaded) {
                _addIsAvaliable = state.postIsAvaliableJobPart;
                _editIsAvaliable = state.patchIsAvaliableJobPart;
                _deleteIsAvaliable = state.deleteIsAvaliableJobPart;
                _jobPartRunIsAvaliable = state.isJobPartRunIsAvailable; 

                body = Expanded(child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                    if (settingsState is SettingsInitial) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          JobsManagerMenu(),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                                ActionButton(
                                  onTap: () => _onAddJobPartTap(state.jobId ?? -1)
                                ),                              
                              if (_selectedRow > -1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButton(
                                    name: 'Редактировать',
                                    widthSize: 180,
                                    onTap: () => _onEditJobPartTap(_selectedJobPart!)
                                  ),
                                ),
                              if (_selectedRow > -1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButton(
                                    name: 'Удалить',
                                    onTap: () => _onDeleteJobPartTap(_selectedJobPart!.jobId, _selectedJobPart!.jobPartId)                                     
                                  ),
                                ),
                              if (_selectedRow > -1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButton(
                                    name: 'Выполнить',
                                    onTap: () => _onRunInitJobPartTap(_selectedJobPart!)                                   
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                child: DataTablePlus(
                                    sortColumnIndex: settingsState.tasksPartItems.indexOf(state.sort) + 1,
                                    sortAscending: state.sortAscending,
                                    dataRowHeight: 70,
                                    showBottomBorder: true,
                                    dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return AppStyles.mainColor.withOpacity(0.2); 
                                      }
                                      return Colors.transparent;
                                    }),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppStyles.mainColor),
                                    ),
                                    //headingRowColor: MaterialStateProperty.all(AppStyles.mainColor.withOpacity(0.2)),
                                    headingTextStyle: AppStyles.headingTableTextStyle,
                                    columnSpacing: 10,
                                    columns: [
                                      const DataColumn2(
                                        label: Text(''),
                                        numeric: true,
                                        size: ColumnSize.S,
                                      ),
                                      ...settingsState.tasksPartItems.map((e) => DataColumn2(
                                              label: Text(e.name),
                                              size: e.columnSize,
                                              onSort: (_, ascending) {
                                                _onSortTap(
                                                  e,
                                                  ascending,
                                                  state.jobsPart.length,
                                                  state.jobId ?? -1,
                                                  state.jobName ?? ''
                                                );
                                              }
                                      )).toList(),
                                    ],
                                    rows: state.jobsPart.mapIndexed((e, index) => DataRow(
                                              selected: index == _selectedRow, 
                                              cells: [
                                              DataCell(
                                                Center(
                                                child: PopupMenuButton<JobActionType>(
                                                  onSelected: (value) {
                                                    switch (value) {
                                                      case JobActionType.edit:
                                                        _onEditJobPartTap(e);
                                                        break;
                                                      case JobActionType.delete:
                                                        _onDeleteJobPartTap(e.jobId, e.jobPartId);
                                                        break;
                                                      case JobActionType.run:
                                                        _onRunInitJobPartTap(e);
                                                        break;
                                                    }
                                                  },
                                                  itemBuilder: (BuildContext context) => JobActionType.values.map<PopupMenuItem<JobActionType>>((action) =>
                                                     PopupMenuItem<JobActionType>(
                                                      value:action, 
                                                      child: Text(action.name())
                                                    )).toList(),
                                                  child: const Icon(
                                                    Icons.more_horiz_rounded,
                                                    size: 16,
                                                    //color: ExistsGenerator.colorJobPart(e),
                                                  ),
                                                ),
                                              )),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[0].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.jobPartId.toString(),
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e))
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[1].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.jobId.toString(),
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e))),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[2].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.orderNum?.toString() ??'', 
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e))),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[3].name,
                                                  child: SizedBox(
                                                    width: 500,
                                                    child: SelectableText(
                                                      e.sql ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index; 
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[4].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.tmpFileName ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[5].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.idFieldName ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[6].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.isForCurPeriod == '1'? 'Да': 'Нет',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[7].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.numOfPrevPeriod?.toString() ??'',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[8].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.periodTypeName ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[9].name,
                                                  child: Text(
                                                    e.name ?? '',
                                                    style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[10].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.isOn == '1'? 'Включено': 'Выключено',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[11].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.expDir ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[12].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.actionTypeName ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[13].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.impDir ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)), 
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[14].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.afterImpDir ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[15].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.logFileName ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[16].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.isUseDateName ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[17].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.copyExpDir ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[18].name,
                                                  child: Center(
                                                    child: Text(
                                                      ExistsGenerator.nameJobPart(e),
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[19].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.lastExecDate?.toStringFormattedGetOperationHistory() ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[20].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.comFile ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[21].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.paramComFile ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[22].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.messageTypeId?.toString() ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[23].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.maxFileSize?.toString() ?? '',
                                                      style: TextStyle(fontSize: 12, color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                              DataCell(
                                                Tooltip(
                                                  message: settingsState.tasksPartItems[24].name,
                                                  child: Center(
                                                    child: Text(
                                                      e.dirInErr ?? '',
                                                      style: TextStyle(fontSize: 12,color: ExistsGenerator.colorJobPart(e)),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedJobPart = e;
                                                    _selectedRow = index;
                                                    _onLoadJobPartParamTap(
                                                      e.jobPartId,
                                                      state.jobName ?? '',
                                                      e.name ?? ''
                                                    );
                                                  });
                                                },
                                              ),
                                            ])).toList()),
                              ),
                            ),
                          ),
                          RowCounter(state.jobsPart.length),
                          const SizedBox(height: 8),
                          BlocBuilder<JobsPartBloc, JobsPartState>(
                            builder: (context, state) {
                              Widget body = Container();
                              if (state is JobsPartLoading) {
                                body = const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: LoadingIndicator()
                                    ),
                                  ],
                                );
                              } else if (state is JobsPartLoaded) {
                                if (!state.isLoadMoreAvaiable) {
                                  body = state.jobsPart.isNotEmpty ? 
                                    Center(
                                      child: Text(
                                        'Данных больше нет',
                                        style: AppStyles.headingTableTextStyle
                                      ),
                                    ): Container();
                                }
                              }
                              return body;
                            },
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ));
              }
              return body;
            })
          ],
        ),
      );

  void _onSortTap(TasksPartSort sort, bool sortAscending, int loadCount, int jobId, String jobName) {
    context.read<JobsPartBloc>().add(JobsPartLoad(
        sort: sort,
        sortAscending: sortAscending,
        loadCount: loadCount,
        jobId: jobId,
        jobName: jobName
      )
    );
  }

  void _onLoadJobPartParamTap(int jobPartId, String jobName, String jobPartName) {
    context.read<JobsPartParamBloc>().add(JobsPartParamLoad(
    jobPartId: jobPartId, jobName: jobName, jobPartName: jobPartName));
  }


  Future<void> _onEditJobPartTap(JobPart jobPart) async {
    if(_editIsAvaliable) {
      final updateJobPart = await Navigation.toJobsPartEdit(jobPart: jobPart);
      if (updateJobPart != null) {
        context.read<JobsPartBloc>().add(JobsPartUpdateJob(updateJobPart));
      }
      _onRefreshJobsPart();
      _selectedJobPart = updateJobPart ?? jobPart;
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableJobPart,
        type: DialogType.info
      );          
    }
  }

  void _onDeleteJobPartTap(int jobId, int jobPartId) {
    if(_deleteIsAvaliable) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '', 
        action: () => context
          .read<JobsPartBloc>()
          .add(JobsPartDeleteJob(jobId, jobPartId)),
        dialogTitle: 'Уверены, что хотите удалить часть задания?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
      _onCleanInfoJobsPartParam();
      _selectedRow = -1;
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableJobPart,
        type: DialogType.info
      );               
    }
  }


  Future<void> _onRunInitJobPartTap(JobPart jobPart) async {
    if(_jobPartRunIsAvaliable) {
      await Navigation.toJobsPartRun(jobPart: jobPart);
      Future.delayed(const Duration(seconds: 1), _onRefreshJobsPart);
      Future.delayed(const Duration(seconds: 30), _onRefreshJobsPart);
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.runIsNotAvaliableJobPart,
        type: DialogType.info
      );              
    }
  }


  Future<void> _onAddJobPartTap(int jobId) async {
    if(_addIsAvaliable) {
      final newJobPart = await Navigation.toJobsPartAdd(jobId);
      context.read<JobsPartBloc>().add(JobsPartNewJobPart(newJobPart!));
      _onRefreshJobsPart();
      _onCleanInfoJobsPartParam();
      _selectedRow = -1;
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.postIsNotAvaliableJobPart,
        type: DialogType.info
      );           
    }
  }

  //Refresh functions
  void _onRefreshJobsPart() {
    context.read<JobsPartBloc>().add(JobsPartLoad(jobId: jobId ?? -1, jobName: jobName ?? ''));
  }

  void _onCleanInfoJobsPartParam() {
    context.read<JobsPartParamBloc>().add(JobsPartParamCleanInfo());
  }
}
