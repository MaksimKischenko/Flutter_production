import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class JobEditScreen extends StatefulWidget {
  static const pageName = 'Редактирование задания';

  @override
  _JobEditScreenState createState() => _JobEditScreenState();
}

class _JobEditScreenState extends State<JobEditScreen> {

  final _formKey = GlobalKey<FormState>();
  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  PeriodStatus _selectedPeriodStatus = PeriodStatus.once;
  final _jobUpdate = JobUpdateRequest();
  Job? _job;
  OutServer? _selectedRequestStatus;
  DateTime? _sendingDate;
  DateTime? _sendingTime;
  DateTime? _fromTime;
  DateTime? _toTime;

  bool interruptTaskOnError = false;
  bool isMoreThanOneJobInQueue = false;
  bool isOn = false;

  final _jobNameController = TextEditingController();
  final _everyNminController = TextEditingController();
  final _everyNweekController = TextEditingController();
  final _everyNController = TextEditingController();
  double width = 1200;

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##########');
  }

  @override
  void dispose() {
    _jobNameController.dispose();
    _everyNminController.dispose();
    _everyNweekController.dispose();
    _everyNController.dispose();
    //Clear validation Lists 
    DaysOfWeekGenerator.daysofWeekValueForValidation.clear();
    DaysOfWeekGenerator.daysValueForValidation.clear();
    DaysOfWeekGenerator.orderDaysForValidation.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            BlocBuilder<JobUpdateBloc, JobUpdateState>(
            buildWhen: (_, next) => next is JobUpdateInitial,
            builder: (context, state) {
              String? jobName;
              if(state is JobUpdateInitial) {
                jobName = state.job?.name;
              }
              return CommonAppBar(
                title: 'Редактирование задания',
                organizationName: jobName,
              );
            },
          ),
          const Divider(),
          Expanded(
            child: BlocConsumer<JobUpdateBloc, JobUpdateState>(
              listener: (context, state) {
                if(state is JobUpdateInitial) {
                  _job = state.job;

                  _jobUpdate
                  ..isBreakJobPart = state.job?.isBreakJobPart
                  ..isOn = state.job?.isOn
                  ..isFromToTime = state.job?.isFromToTime
                  ..isWorkDay = state.job?.isWorkDay
                  ..isLastMonthDay = state.job?.isLastMonthDay
                  ..someDay = state.job?.someDay
                  ..isMoreThanOneJobInQueue = state.job?.isMoreThanOneJobInQueue;

                  _selectedPeriodStatus = _returnStatus(_job);
                  _selectedRequestStatus = state.outServers.firstOrNullWhere((e) => e.id == state.job?.outServerId);
                  _sendingDate = state.job?.startDate;
                  _sendingTime = DateTime(0,0,0,_sendingDate?.hour ?? 0, _sendingDate?.minute ?? 0);
                  _fromTime = state.job?.fromTime;
                  _toTime = state.job?.toTime;
                  _jobNameController.text = state.job?.name ?? '';
                  _everyNminController.text = state.job?.everyNMin?.toString() ?? '';
                  _everyNweekController.text = state.job?.isEveryNWeek?.toString() ?? '';
                  _everyNController.text = state.job?.everyN?.toString() ?? '';
                } else if (state is JobUpdateSuccess) {
                    if(Navigator.of(context).canPop()) {
                      Navigator.of(context).pop<Job>(state.job);
                    } else {
                      Navigation.toJobsManager();     
                    }
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Задание отредактировано',
                    type: DialogType.success
                  );
                } else if (state is JobUpdateError) {
                  RequestUtil.catchNetworkError(
                    context: context,
                    obj: state.error
                  );
                }
              },
              buildWhen:(prev, next) {
                if (next is JobUpdateInitial) return true;
                if (next is JobUpdateInitLoading) return true;
                if (next is JobUpdateInitError) return true;
                return false;
              },
              builder: (context, state) {
                Widget body = Container();
                if(state is JobUpdateInitError) {
                body = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: double.maxFinite),
                    const Text('Невозможно начать процедуру редактирования'),
                    const SizedBox(height: 8),
                    CupertinoButton(
                      onPressed: () => context
                          .read<JobUpdateBloc>()
                          .add(JobUpdateInit()),
                      child: const Text('Попробовать снова'),
                    )
                  ]
                );
                } else if (state is JobUpdateInitLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is JobUpdateInitial) {
                  body = SingleChildScrollView(
                    child: ResponsiveBuilder(
                      builder: (context, sizingInformation) {

                        
                        if (sizingInformation.isMobile || sizingInformation.isTablet) {
                          width = sizingInformation.screenSize.width;
                        }
                        return Center(
                          child: Container(
                            width: width,
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Form(
                              key: _formKey,
                              child: Responsive(
                                runSpacing: 16,
                                children: [
                                  Div(
                                    colL: 6,
                                    colM: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: AttrTextField(
                                        controller: _jobNameController,
                                        labelText: 'Наименование задания',
                                        maxLength: 50,
                                        onSaved: (value) {
                                          if (_job?.name != value) {
                                            _jobUpdate.name = value;
                                          } else {
                                            _jobUpdate.name  = null;
                                          } 
                                        },
                                      ),
                                    ),
                                  ),
                                  Div(
                                    colL: 6,
                                    colM: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFieldDropdownSearch<PeriodStatus>(
                                        title: 'Когда выполнять',
                                        showSearchBox: false,
                                        maxHeight: 250,
                                        items: PeriodStatus.values,
                                        itemBuilder: (item) => item.name,
                                        selected: _selectedPeriodStatus,
                                        onTap: (item) => setState(() => _selectedPeriodStatus = item),
                                        onSaved: (value) {
                                            if(value == PeriodStatus.once) {
                                            _jobUpdate
                                            ..isNvalue = 0
                                            ..everyNMin = 0
                                            ..isEveryNWeek = 0
                                            ..isOnce ='1'
                                            ..isEveryNDay = '0'
                                            ..someDay = ''
                                            ..isMinute = '0'
                                            ..isDay = '0'
                                            ..isWeek = '0'
                                            ..isDayMonth = '0'
                                            ..isWorkDay  = '0'
                                            ..isFromToTime = '0'
                                            ..isLastMonthDay = '0'
                                            ..fromTime = DateTime(1970) //for flag to show that time is not valid 
                                            ..toTime = DateTime(1970);
                                          } else if(value == PeriodStatus.isMinute) {
                                            _jobUpdate
                                            ..isMinute = '1'
                                            ..someDay = ''
                                            ..isOnce ='0'
                                            ..isDay = '0'
                                            ..isEveryNDay = '0'
                                            ..isWeek = '0'
                                            ..isDayMonth = '0';
                                          } else if (value == PeriodStatus.isDay) {
                                              _jobUpdate
                                            ..someDay = ''
                                            ..isDay = '1'
                                            ..isEveryNDay = '1'
                                            ..isOnce ='0'
                                            ..isMinute = '0'
                                            ..isWeek = '0'
                                            ..isDayMonth = '0';
                                          } else if (value == PeriodStatus.isWeek) {
                                            _jobUpdate
                                            ..isWeek = '1'
                                            ..isOnce ='0'
                                            ..isMinute = '0'
                                            ..isDay = '0'
                                            ..isEveryNDay = '0'
                                            ..isDayMonth = '0';
                                          } else if (value == PeriodStatus.isMonth) {
                                            _jobUpdate
                                            ..isDayMonth = '1'
                                            ..isOnce ='0'
                                            ..isMinute = '0'
                                            ..isDay = '0'
                                            ..isEveryNDay = '0'
                                            ..isWeek = '0';
                                            if(_jobUpdate.someDay?.length != 7) {
                                              _jobUpdate.isEveryNWeek = 0;
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Div(
                                    colL: 6,
                                    colM: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFieldDropdownSearch<OutServer>(
                                        title: 'ID сервера обработки запросов',
                                        showSearchBox: false,
                                        items: state.outServers,
                                        itemBuilder: (item) => item.name,
                                        selected: _selectedRequestStatus,
                                        onTap: (item) => setState(() => _selectedRequestStatus = item),
                                        onSaved: (value) {
                                          _jobUpdate.outServerId = value?.id;
                                        },
                                      ),
                                    ),
                                  ),
                                  Div(
                                    colL: 6,
                                    colM: 12,
                                    child:  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: WebDatePicker(
                                              initialDate: _sendingDate,
                                              labelText: 'Дата следующего запуска',
                                              onChange: (value)  {
                                                _sendingDate = value;
                                              },
                                              validator: () {
                                                //Past time validation
                                                if(_selectedPeriodStatus == PeriodStatus.isWeek || _selectedPeriodStatus == PeriodStatus.isMonth) {
                                                  if (_sendingDate!.compareTo(DateTime.now().add(const Duration(days: -1))) < 1) {
                                                  return 'Время следующего запуска \nне может быть в прошлом';
                                                  } 
                                                }
                                                //Interval time validation
                                                if(_selectedPeriodStatus == PeriodStatus.isWeek) {
                                                  if(!DaysOfWeekGenerator.daysofWeekValueForValidation.contains(_sendingDate?.weekday)) {
                                                    return 'Дата следующего запуска \nне входит в промежуток дней';
                                                  }
                                                } else if(_selectedPeriodStatus == PeriodStatus.isMonth) {
                                                  if(DaysOfWeekGenerator.isDayMonth) {
                                                    if(!DaysOfWeekGenerator.daysValueForValidation.contains(_sendingDate?.day)) {
                                                      return 'Дата следующего запуска \nне входит в промежуток дней';
                                                    }
                                                  } else if (DaysOfWeekGenerator.isDayWeek) {
                                                    if(!DaysOfWeekGenerator.daysofWeekValueForValidation.contains(_sendingDate?.weekday)) {
                                                      return 'Дата следующего запуска \nне входит в промежуток дней';
                                                    } 
                                                    if(DaysOfWeekGenerator.orderDaysForValidation.isNotEmpty) {
                                                      var dayNum = _sendingDate?.day;
                                                        var index = 0;
                                                        while(dayNum!>0) {
                                                          dayNum = dayNum -7;
                                                          index++;
                                                        }
                                                        if(!DaysOfWeekGenerator.orderDaysForValidation.contains(index)) {
                                                          return 'Дата следующего запуска \nне входит в промежуток дней';
                                                        }
                                                    }
                                                  }
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            width: 120,
                                            child: AttrTimeSecondary(
                                              labelText: 'Время',
                                              initialValue: _sendingTime?.toStringFormattedHoursOnly() ?? '',
                                              onSaved: (value) {
                                                _sendingTime = value;
                                              },
                                              validator: (value) {
                                                _sendingTime = value?.toDateFormattedOnlyTime();        
                                                if((_sendingTime != null && _fromTime != null) && _toTime != DateTime(1970) && _fromTime != DateTime(1970)) {
                                                  //Past time validation
                                                  //if(_selectedPeriodStatus == PeriodStatus.isWeek || _selectedPeriodStatus == PeriodStatus.isMonth) {
                                                    if (_sendingDate!.day == DateTime.now().day  &&_sendingTime!.hour < DateTime.now().hour) {
                                                      return 'Время \nследующего \nзапуска \nне может \nбыть \nв прошлом';
                                                    } else if (_sendingDate!.day == DateTime.now().day &&_sendingTime!.hour == DateTime.now().hour 
                                                    && _sendingTime!.minute < DateTime.now().minute) {
                                                        return 'Время \nследующего \nзапуска \nне может \nбыть \nв прошлом';
                                                  //} 
                                                  }
                                                  //Interval time validation
                                                  if(_sendingTime!.hour < _fromTime!.hour ||  _sendingTime!.hour > _toTime!.hour) {
                                                      return 'Время не \nнаходится \nв заданном \nпромежутке';
                                                  } else if (_sendingTime!.hour == _fromTime!.hour 
                                                          && _sendingTime!.minute < _fromTime!.minute) {
                                                    return 'Время не \nнаходится \nв заданном \nпромежутке';
                                                  } else if (_sendingTime!.hour == _toTime!.hour 
                                                          && _sendingTime!.minute > _toTime!.minute) {
                                                    return 'Время не \nнаходится \nв заданном \nпромежутке'; 
                                                  }
                                                } 
                                                //Past time validation
                                                //if(_selectedPeriodStatus == PeriodStatus.isWeek || _selectedPeriodStatus == PeriodStatus.isMonth) {
                                                  if (_sendingTime != null && (_fromTime == null && _toTime == null)) {
                                                    if (_sendingDate!.day == DateTime.now().day &&_sendingTime!.hour < DateTime.now().hour) {
                                                      return 'Время \nследующего \nзапуска \nне может \nбыть \nв прошлом';
                                                    } else if (_sendingDate!.day == DateTime.now().day &&_sendingTime!.hour == DateTime.now().hour 
                                                      && _sendingTime!.minute < DateTime.now().minute) {
                                                        return 'Время \nследующего \nзапуска \nне может \nбыть \nв прошлом';
                                                    }  
                                                //}
                                                }
                                                  return null; 
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Div(
                                    colL: 12,
                                    colM: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: AttrLogic(
                                        value: _jobUpdate.isMoreThanOneJobInQueue =='1',
                                        onChanged: (value) {
                                          setState(() {
                                          isMoreThanOneJobInQueue = !isMoreThanOneJobInQueue;
                                          if (value) {
                                            _jobUpdate.isMoreThanOneJobInQueue = '1';
                                          } else {
                                            _jobUpdate.isMoreThanOneJobInQueue = '0';
                                          }
                                          });
                                        },
                                        text: 'Просроченное выполнение',
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                  Div(
                                    colL: 12,
                                    colM: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: AttrLogic(
                                        value: _jobUpdate.isOn =='1',
                                        onChanged: (value) {
                                          setState(() {
                                          isOn = !isOn;
                                          if (value) {
                                            _jobUpdate.isOn = '1';
                                          } else {
                                            _jobUpdate.isOn = '0';
                                          }
                                          });
                                        },
                                        text: 'Вкл/выкл',
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                  Div(
                                    colL: 12,
                                    colM: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: AttrLogic(
                                        value: _jobUpdate.isBreakJobPart =='1',
                                        onChanged: (value) {
                                          setState(() {
                                          interruptTaskOnError = !interruptTaskOnError;
                                            if(value) {
                                              _jobUpdate.isBreakJobPart = '1';
                                            } else {
                                              _jobUpdate.isBreakJobPart = '0';
                                            }
                                        });
                                        },
                                        text: 'Прервать задание при ошибке',
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                  SelectedTimerTab(
                                    status: _selectedPeriodStatus,
                                    jobUpdate: _jobUpdate,
                                    fromTime: _fromTime,
                                    toTime: _toTime,
                                    everyNminController: _everyNminController,
                                    everyNweekController: _everyNweekController,
                                    everyNController: _everyNController,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return body;
              },
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OkButton(onTap: _onSaveTap),
                const SizedBox(width: 10),
                UndoButton(onTap: () {
                  if(Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      Navigation.toJobsManager();
                    }
                }),
              ],
            ),
          ),
        ],
      ),
    ),
  );
      

  PeriodStatus _returnStatus (Job? job) {
    if (job?.isOnce == '1') {
      return PeriodStatus.once;
    } else if (job?.isMinute =='1') {
      return PeriodStatus.isMinute;
    } else if(job?.isDay =='1'){
      return PeriodStatus.isDay;
    } else if(job?.isWeek == '1') {
      return PeriodStatus.isWeek;
    } else if(job?.isDayMonth =='1') {
      return PeriodStatus.isMonth;
    }
    return PeriodStatus.once;
  }
   
  void _onSaveTap() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if(_sendingDate !=null && _sendingTime !=null) {
         _jobUpdate.startDate = DateTime(_sendingDate!.year, _sendingDate!.month, _sendingDate!.day, _sendingTime!.hour, _sendingTime!.minute);
      } else {
        _jobUpdate.startDate = null;
      }
      context.read<JobUpdateBloc>().add(JobUpdateRun(_jobUpdate));
    }
  }
}
