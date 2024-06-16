import 'dart:async';

import 'package:compute/compute.dart';
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

class AssignedJobsTab extends StatefulWidget {

  final TabController tabController;

  const AssignedJobsTab({
    required this.tabController,
    Key? key,
  }) : super(key: key);

  @override
  _AssignedJobsTabState createState() => _AssignedJobsTabState();
}

class _AssignedJobsTabState extends State<AssignedJobsTab> {

  late final Timer timer;
  int _selectedRow = -1;
  Job? _selectedJob;

  bool _addIsAvaliable = true;
  bool _editIsAvaliable = true;
  bool _deleteIsAvaliable = true;
  bool _jobRunIsAvaliable = true;

  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      context.read<JobsBloc>().add(const JobsInit());
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          context.read<JobsBloc>().add(const JobsInit());
        }
      });
    }
    _newIsolateRefresher();
   
    //Dispose info of tab with index 1 and 2 if we go back to main Tab 
    if(widget.tabController.indexIsChanging && widget.tabController.previousIndex == 2 
    || (widget.tabController.indexIsChanging && widget.tabController.previousIndex == 1)) {
     context.read<JobsPartParamBloc>().add(JobsPartParamCleanInfo());
     context.read<JobsPartBloc>().add(JobsPartCleanInfo());  
    }
  }
 
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobsManagerMenu(),
        const SizedBox(height: 24),
        BlocConsumer<JobsBloc, JobsState>(
          listener: (context, state) {
            //Avoid JWS errors
            if (state is JobsError) {
              if(!state.error.toString().contains('Http status error [401]')) {
                RequestUtil.catchNetworkError(context: context, obj: state.error);
              }
            } else if (state is JobsDeleteJobSuccess) {
              Multiplatform.showMessage(
                context: context,
                title: 'Успешно',
                message: 'Задание ${state.job.name} удалено',
                type: DialogType.success
              );
            } else if (state is JobsRunSuccess) {
              Multiplatform.showMessage(
                context: context,
                title: 'Успешно',
                message: 'Задание ${state.id} запущено',
                type: DialogType.success
              );
            } else if (state is JobGetNotAllow) {
                //_addIsAvaliable = false;
                _editIsAvaliable = false;
                _deleteIsAvaliable = false;
                _jobRunIsAvaliable = false;
            }
          },
          buildWhen: (prev, next) {
            if (next is JobsError) return false;
            if (next is JobsLoading) return false;
            if (next is JobsLoaded) return true;
            return true;
          },
          builder: (context, state) {
            Widget body = Container();
            if (state is JobsLoading) {
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
            } else if (state is JobsLoaded) {
              _addIsAvaliable = state.postIsAvaliableJob;
              _editIsAvaliable = state.patchIsAvaliableJob;
              _deleteIsAvaliable = state.deleteIsAvaliableJob;
              _jobRunIsAvaliable = state.isJobRunIsAvailable;
              body = Expanded(
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                    if (settingsState is SettingsInitial) {
                      return Center(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ActionButton(
                                  onTap: _onAddJobTap
                                ),
                                //Show action buttons only if Job is selected 
                                if(_selectedRow > -1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButton(
                                    name: 'Редактировать',
                                    widthSize: 180,
                                    onTap: () =>_onEditJobTap(_selectedJob!)                    
                                  ),
                                ),
                                if(_selectedRow > -1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButton(
                                    name: 'Удалить',
                                    onTap: () => _onDeleteJobTap(_selectedJob!.id)                                  
                                  ),
                                ),
                                if(_selectedRow > -1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButton(
                                    name: 'Выполнить',
                                    onTap: () => _onRunJobTap(_selectedJob!.id) 
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
                                    dataRowHeight: 60,
                                    columnSpacing: 20,   
                                    sortColumnIndex: settingsState.unassignedTasksItems.indexOf(state.sort) + 1,
                                    sortAscending: state.sortAscending,
                                    showBottomBorder: true,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppStyles.mainColor),
                                    ),
                                    dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return AppStyles.mainColor.withOpacity(0.2); 
                                      } 
                                      return Colors.transparent;  
                                    }),
                                    // headingRowColor: MaterialStateProperty.all(
                                    //   AppStyles.mainColor.withOpacity(0.8)
                                    // ),
                                    headingTextStyle: AppStyles.headingTableTextStyle,
                                 
                                    columns: [
                                      const DataColumn2(
                                        label: Text(''),
                                        numeric: true,
                                        size: ColumnSize.S,
                                      ),
                                      ...settingsState.unassignedTasksItems.map((e) => DataColumn2(
                                        label: Text(e.name),
                                        size: e.columnSize,
                                        onSort: (_, ascending) => _onSortTap(e, ascending, state.jobs.length),
                                      )).toList(),
                                    ],
                                    rows: state.jobs.mapIndexed((e, index) => DataRow(
                                      selected: index == _selectedRow,
                                      cells: [
                                        DataCell(
                                          Center(
                                            child: PopupMenuButton<JobActionType>(
                                            onSelected: (value) {
                                              switch (value) {
                                                case JobActionType.edit:
                                                  _onEditJobTap(e);
                                                  break;
                                                case JobActionType.delete:
                                                  _onDeleteJobTap(e.id);
                                                  break;
                                                case JobActionType.run:
                                                  _onRunJobTap(e.id);
                                                  break;
                                              }
                                            },
                                            itemBuilder: (BuildContext context) => JobActionType.values.
                                            map<PopupMenuItem<JobActionType>>((action) => PopupMenuItem<JobActionType>(
                                              value: action,
                                              child: Text(action.name()),
                                            )).toList(),
                                            child: const Icon(
                                              Icons.more_horiz_rounded,
                                              size: 16,
                                              //color: ExistsGenerator.color(e)
                                            ),
                                          ),
                                        )),
                                        //Every DataCell needs onTap
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[0].name,
                                            child: Center(
                                              child: Text(e.id.toString(),
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ), 
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[1].name,
                                            child: Text(
                                                e.name ?? '',
                                                style: TextStyle(color: ExistsGenerator.color(e))),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[2].name,
                                            child: Center(
                                              child: Text(e.startDate?.toStringFormattedGetOperationHistory() ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[3].name,
                                            child: Center(
                                              child: Text(e.outServerId.toString(),
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[4].name,
                                            child: Center(
                                              child: Text(e.lastExec?.toStringFormattedGetOperationHistory() ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[5].name,
                                            child: Center(
                                              child: Text(e.isOnOffEnum.name,
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[6].name,
                                            child: Center(
                                              child: Text(ExistsGenerator.name(e),
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[7].name,
                                            child: Center(
                                              child: Text(e.isBreakJobPart  == '1' ? 'Да': 'Нет',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[8].name,
                                            child: Center(
                                              child: Text(e.isOnce == '1'? 'Да': 'Нет',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[9].name,
                                            child: Center(
                                              child: Text(e.isMinute =='1'? 'Да': 'Нет',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[10].name,
                                            child: Center(
                                              child: Text(e.isDay =='1'? 'Да': 'Нет',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[11].name,
                                            child: Center(
                                              child: Text(e.isWeek =='1'? 'Да': 'Нет',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[12].name,
                                            child: Center(
                                              child: Text(e.isDayMonth =='1'? 'Да': 'Нет',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[13].name,
                                            child: Center(
                                              child: Text(e.isLastMonthDayName ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[14].name,
                                            child: Center(
                                              child: Text(e.everyN?.toString() ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[15].name,
                                            child: Center(
                                              child: Text(e.isFromToTimeName ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[16].name,
                                            child: Center(
                                              child: Text(e.fromTime?.toStringFormattedHoursOnly() ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[17].name,
                                            child: Center(
                                              child: Text(e.toTime?.toStringFormattedHoursOnly() ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Tooltip(
                                            message: settingsState.unassignedTasksItems[18].name,
                                            child: Center(
                                              child: Text(e.isWorkDayName ?? '',
                                              style: TextStyle(color: ExistsGenerator.color(e))),
                                            ),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedJob = e;    
                                              _selectedRow = index;
                                              _onLoadJobPart(e.id, e.name ?? '');
                                            });
                                           }, 
                                        ),
                                        DataCell(
                                           Tooltip(
                                             message: settingsState.unassignedTasksItems[19].name,
                                             child: Center(
                                                child: Text(e.everyNMin?.toString() ?? '',
                                                style: TextStyle(color: ExistsGenerator.color(e))),
                                             ),
                                           ),
                                           onTap:() {
                                              setState(() {
                                                _selectedJob = e;    
                                                _selectedRow = index;
                                                _onLoadJobPart(e.id, e.name ?? '');
                                              });
                                          }, 
                                        ),
                                      ]
                                    )).toList()
                                  ),
                                ),
                              ) 
                            ),
                            RowCounter(state.jobs.length),
                            const SizedBox(height: 8),
                            BlocBuilder<JobsBloc, JobsState>(
                              builder: (context, state) {
                                Widget body = Container();
                                if (state is JobsLoading) {
                                  body =  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: LoadingIndicator()
                                      ),
                                    ],
                                  );
                                } else if (state is JobsLoaded) {
                                  if(state.isLoadMoreAvaiable) {
                                    body = Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ActionButton(
                                          name: 'Загрузить еще',
                                          widthSize: 170,
                                          onTap: () => context.read<JobsBloc>().add(JobsLoadMore(state.jobs.length)),
                                        ),
                                      ],
                                    );
                                  } else {
                                    body = state.jobs.isNotEmpty ? 
                                     Center(
                                      child: Text(
                                        'Данных больше нет',
                                        style: AppStyles.headingTableTextStyle
                                      ),
                                    ) : Container();
                                  }
                                }
                                return body;
                              },
                            )
                          ],
                        )                       
                      );
                    } else {
                      return Container();
                    }
                  } ,
                 ),
              ) ;
            } else if(state is JobGetNotAllow) {
              body = Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    SizedBox(height: MediaQuery.of(context).size.height/4),
                    const SvgAssets('icon/dialog_error.svg'),
                    Text(state.message ?? '', style: AppStyles.headerTextStyleLess, textAlign: TextAlign.center),
                  ],
                ),
              );
            }
            return body;
          }
        )
      ],
    ),
  );

  void _onSortTap(
    UnassignedTasksSort sort,
    bool sortAscending,
    int loadCount
  ) {
    context.read<JobsBloc>().add(JobsLoad(
      sort: sort,
      sortAscending: sortAscending,
      loadCount: loadCount
    ));
  }

  Future<void> _onAddJobTap() async {
    if(_addIsAvaliable) {
      final newJob = await Navigation.toJobAdd();
      context.read<JobsBloc>().add(JobsNewJob(newJob!));
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.postIsNotAvaliableJob,
        type: DialogType.info
      );       
    }
  }


  Future<void> _onEditJobTap(Job job) async {
    if(_editIsAvaliable) {
      final updateJob = await Navigation.toJobsEdit(job: job);
      if(updateJob != null) {
        context.read<JobsBloc>().add(JobsUpdateJob(job: updateJob));
      }
      _onRefreshJob();
      _selectedJob = updateJob ?? job;
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableJob,
        type: DialogType.info
      );       
    }
  }

  void _onDeleteJobTap(int jobId) {
    if(_deleteIsAvaliable) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<JobsBloc>().add(JobsDeleteJob(jobId)),
        dialogTitle: 'Уверены, что хотите удалить задание?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
      _selectedRow = -1;
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableJob,
        type: DialogType.info
      );          
    }
  }

  //GET req for jobPart
  void _onLoadJobPart(int jobId, String name) {
    context.read<JobsPartBloc>().add(JobsPartLoad(
      jobId: jobId,
      jobName: name
    ));
  }

  void _onRunJobTap(int jobId) {
    if(_jobRunIsAvaliable) {
      final _savedSelectedJob = _selectedJob;
      final _savedSelectedIndex = _selectedRow;
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: ()  {
          context.read<JobsBloc>().add(JobsRunJob(jobId));
          Future.delayed(const Duration(milliseconds: 500), _onRefreshJob);
          _selectedJob = _savedSelectedJob;
          _selectedRow = _savedSelectedIndex; 
        },
        dialogTitle: 'Выполнить задание?',
        buttonTitle: 'Да',
        cancelButtonTitle: 'Нет'
      );
      _selectedRow = -1;
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.runIsNotAvaliableJob,
        type: DialogType.info
      );         
    }
  }

  void _onRefreshJob() {
    context.read<JobsBloc>().add(const JobsInit());
  }

  Future<void> _newIsolateRefresher() async{
    await compute((message) =>  timer = Timer.periodic(const Duration(seconds: AppConfig.refreshTime), (Timer t) => _onRefreshJob()), null);
  }
}

