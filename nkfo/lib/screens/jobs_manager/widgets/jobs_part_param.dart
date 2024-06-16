import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_plus/data_table_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class JobsPartParam extends StatefulWidget {


  @override
  _JobsPartParamState createState() => _JobsPartParamState();
}

class _JobsPartParamState extends State<JobsPartParam> {
  String? jobName;
  String? jobPartName;
  int? jobPartId;

  JobPartParam? _selectedJobPartParam;
  int _selectedRow = -1;
  bool _addIsAvaliable = true;
  bool _editIsAvaliable = true;
  bool _deleteIsAvaliable = true;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<JobsPartParamBloc, JobsPartParamState>(
          builder: (context, state) {
            Widget body = Container();
            if(state is JobsPartParamLoaded){
              jobName = state.jobName;
              jobPartName = state.jobPartName;
              jobPartId  = state.jobPartid;
              body  = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Задание: $jobName | Часть:$jobPartName', style: AppStyles.headerTextStyleLess),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ActionButton(
                        onTap: () =>_onAddJobPartParamTap(state.jobPartid ?? -1)
                      ),
                      if(_selectedRow > -1)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ActionButton(
                            name: 'Редактировать',
                            widthSize: 180,
                            onTap: () {
                              _onEditJobPartParamTap(_selectedJobPartParam!);
                            }
                          ),
                        ),
                      if(_selectedRow > -1)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ActionButton(
                            name: 'Удалить',
                            onTap: () {
                              _onDeleteJobPartParamTap(_selectedJobPartParam!.jobPartParamId);
                            }
                          ),
                        ),
                    ],
                  ),
                ],
              );
            }
            return body;
          },
        ),
        BlocConsumer<JobsPartParamBloc, JobsPartParamState>(
          listener: (context, state) {
            if (state is JobsPartParamError) {
              RequestUtil.catchNetworkError(context: context, obj: state.error);
            } else if (state is JobsPartParamDeleteJobPartParamSuccess) {
              Multiplatform.showMessage(
                context: context,
                title: 'Успешно',
                message: 'Параметр запроса ${state.jobPartParam.name} удален',
                type: DialogType.success
              );
            }
          },
          buildWhen: (prev, next) {
            if (next is JobsPartParamError) return false;
            if (next is JobsPartParamLoading) return false;
            if (next is JobsPartParamLoaded) return true;
            return true;
          },
          builder: (context, state) {
          Widget body = Container();
          if (state is JobsPartParamNoInfo) {
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
          } if (state is JobsPartLoading) {
            body = Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, size: 48, color: AppStyles.mainColor.withOpacity(0.8)),
                    Text('Данных нет', style: AppStyles.headerTextStyleLess)
                  ],
                )
              )
            );
          } else if (state is JobsPartParamLoaded) {

            _addIsAvaliable = state.postIsAvaliableJobPartParam;
            _editIsAvaliable = state.patchIsAvaliableJobPartParam;
            _deleteIsAvaliable = state.deleteIsAvaliableJobPartParam; 

            body = Expanded(
              child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
                if (settingsState is SettingsInitial) {
                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTablePlus(
                          sortColumnIndex: settingsState.tasksPartParamItems.indexOf(state.sort) + 1,
                          sortAscending: state.sortAscending,
                          // headingRowColor: MaterialStateProperty.all(
                          //   AppStyles.mainColor.withOpacity(0.2)
                          // ),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppStyles.mainColor),
                          ),
                          headingTextStyle: AppStyles.headingTableTextStyle,
                          showBottomBorder: true,
                          dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppStyles.mainColor.withOpacity(0.2); 
                            }
                            return Colors.transparent;  
                          }),
                          columnSpacing: state.jobsPartParam.isEmpty? 80:60,
                            columns: [
                              const DataColumn2(
                                label: Text(''),
                                numeric: true,
                                size: ColumnSize.M,
                              ),
                              ...settingsState.tasksPartParamItems
                              .map((e) => DataColumn2(
                                  label: Text(e.name),
                                  size: e.columnSize,
                                  onSort: (_,ascending) {
                                    _onSortTap(e, ascending, state.jobsPartParam.length,
                                      state.jobPartid ?? -1, state.jobName ?? '', 
                                      state.jobPartName ?? '');
                                  } 
                              )).toList(),
                            ],
                            rows: state.jobsPartParam
                            .mapIndexed((e, index) => DataRow(
                              selected: index == _selectedRow,
                              cells: [
                                  DataCell(
                                    Center(
                                      child: PopupMenuButton<JobPartParamActionType>(
                                          onSelected: (value) {
                                            switch (value) {
                                              case JobPartParamActionType.edit:
                                                _onEditJobPartParamTap(e);
                                                break;
                                              case JobPartParamActionType.delete:
                                                _onDeleteJobPartParamTap(
                                                  e.jobPartParamId);
                                                break;
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>JobPartParamActionType.values
                                            .map<PopupMenuItem<JobPartParamActionType>>(
                                              (action) =>PopupMenuItem<JobPartParamActionType>(
                                                      value: action,
                                                      child: Text(action.name()),
                                              )
                                            ).toList(),
                                          child: const Icon(
                                            Icons.more_horiz_rounded,
                                            size: 16,
                                          )
                                      ),
                                    )
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[0].name,
                                      child: Center(
                                        child: Text(e.jobPartParamId.toString()),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[1].name,
                                      child: Center(
                                        child: Text(e.jobPartId.toString()),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[2].name,
                                      child: Center(
                                        child: Text(e.name ?? ''),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[3].name,
                                      child: Center(
                                        child: Text(e.isAutoIncName ?? ''),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[4].name,
                                      child: Center(
                                        child: Text(e.isAutoClearAtNewDayName ?? ''),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[5].name,
                                      child: Center(
                                        child: Text(e.accessTypeName ?? ''),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[6].name,
                                      child: Center(
                                        child: Text(e.paramTypeName ?? ''),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                                  DataCell(
                                    Tooltip(
                                      message: settingsState.tasksPartParamItems[7].name,
                                      child: Center(
                                        child: Text(e.paramValue ?? ''),
                                      ),
                                    ),
                                    onTap:() {
                                      setState(() {
                                        _selectedJobPartParam = e;
                                        _selectedRow = index;
                                      });
                                    }, 
                                  ),
                            ])).toList()),
                      ),
                      RowCounter(state.jobsPartParam.length),
                      const SizedBox(height: 8),
                      BlocBuilder<JobsPartParamBloc, JobsPartParamState>(
                        builder: (context, state) {
                          Widget body = Container();
                          if (state is JobsPartParamLoading) {
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
                          } else if (state is JobsPartParamLoaded) {
                              if (!state.isLoadMoreAvaiable) {
                                body = state.jobsPartParam.isNotEmpty ? 
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

  void _onSortTap(
    TasksPartParamSort sort,
    bool sortAscending,
    int loadCount,
    int jobPartId,
    String jobName,
    String jobPartName
  ) {
    context.read<JobsPartParamBloc>().add(JobsPartParamLoad(
      sort: sort,
      sortAscending: sortAscending,
      loadCount: loadCount,
      jobPartId: jobPartId,
      jobName: jobName,
      jobPartName: jobPartName
    ));
  }


 Future<void> _onAddJobPartParamTap(int jobPartId) async {
    if(_addIsAvaliable) {
      final newJobPartParam = await Navigation.toJobsPartParamAdd(jobPartId);
      context.read<JobsPartParamBloc>().add(JobsPartParamNewJobPartParam(newJobPartParam!));
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.postIsNotAvaliableJobPartParam,
        type: DialogType.info
      );             
    }
 }


  Future<void> _onEditJobPartParamTap(JobPartParam jobPartParam) async {
    if(_editIsAvaliable) {
      final updatedJobPartParam = await Navigation.toJobsPartParamEdit(jobPartParam: jobPartParam);
      if (updatedJobPartParam != null) {
        context.read<JobsPartParamBloc>().add(JobsPartParamUpdateJobPartParam(updatedJobPartParam));
        _selectedRow = -1;
      }
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableJobPartParam,
        type: DialogType.info
      );       
    }
  }

  void _onDeleteJobPartParamTap(int jobPartParamId) {
    if(_deleteIsAvaliable) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<JobsPartParamBloc>().
        add(JobsPartParamDeleteJobPartParam(jobPartParamId)),
        dialogTitle: 'Уверены, что хотите удалить часть задания?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
      _selectedRow = -1;
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableJobPartParam,
        type: DialogType.info
      );       
    }
  }

  // void _onRefreshJobsPartParam() {
  //   context.read<JobsPartParamBloc>().add(JobsPartParamLoad(jobPartId: jobPartId ?? -1, jobName: jobName ?? '', 
  //   jobPartName: jobPartName ?? ''));
  // }
}
