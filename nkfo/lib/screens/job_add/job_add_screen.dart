
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
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class JobAddScreen extends StatefulWidget {
  static const pageName = 'Добавление задания';

  @override
  _JobAddScreenState createState() => _JobAddScreenState();
}

class _JobAddScreenState extends State<JobAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool interruptTaskOnError = false;
  bool isMoreThanOneJobInQueue = false;
  bool onOff = false;
  bool fromToTime = false;
  bool onWorkDays = false;
  PeriodStatus _selectedPeriodStatus = PeriodStatus.once;
  double width = 1200;  
  final _job = JobInsertRequest();

  OutServer? _selectedRequestStatus;
  DateTime? _sendingDate = DateTime.now();
  DateTime? _sendingTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##########');
  }


  @override
  Widget build(BuildContext context) =>
      BlocListener<JobInsertBloc, JobInsertState>(
        listener: (context, state) {
          if (state is JobInsertError) {
            Navigator.of(context).pop();
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is JobInsertSuccess) {
              if(Navigator.of(context).canPop()) {
                Navigator.of(context).pop<Job>(state.job); 
              } else {
                Navigation.toJobsManager();      
              }
            Multiplatform.showMessage(
              context: context,
              title: 'Успешно',
              message: 'Задание id:${state.job?.id} добавлено',
              type: DialogType.success
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonAppBar(
                  title: 'Добавление задания',
                ),
                const Divider(),
                Expanded(
                  child: BlocBuilder<JobInsertBloc, JobInsertState>(
                    buildWhen:(prev, next) {
                      if (next is JobInsertInitial) return true;
                      if (next is JobInsertInitLoading) return true;
                      if (next is JobInsertInitError) return true;
                      return false;
                    },
                    builder: (context, state) {
                      Widget body = Container();
                      if(state is JobInsertInitError) {
                      body = Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: double.maxFinite),
                                const Text('Невозможно начать процедуру создания'),
                                const SizedBox(height: 8),
                                CupertinoButton(
                                  onPressed: () => context
                                      .read<JobInsertBloc>()
                                      .add(JobInsertInit()),
                                  child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                                )
                              ]
                      );
                      } else if (state is JobInsertInitLoading) {
                        body = const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: double.maxFinite),
                            LoadingIndicator()
                          ],
                        );
                      } else if (state is JobInsertInitial) {
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
                                              labelText: 'Наименование задания',
                                              maxLength: 50,
                                              onSaved: (value) {
                                                _job.name = value;
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
                                                  _job.isOnce = '1';
                                                } else if(value == PeriodStatus.isMinute) {
                                                  _job.isMinute = '1';
                                                } else if (value == PeriodStatus.isDay) {
                                                  _job
                                                  ..isDay = '1'
                                                  ..isEveryNDay = '1';
                                                } else if (value == PeriodStatus.isWeek) {
                                                  _job.isWeek = '1';
                                                } else if (value == PeriodStatus.isMonth) {
                                                  _job.isDayMonth = '1';
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
                                              title: 'ID сервера обработки запросов*',
                                              showSearchBox: false,
                                              items: state.outServers,
                                              itemBuilder: (item) => item.name,
                                              selected: _selectedRequestStatus,
                                              onTap: (item) => setState(() => _selectedRequestStatus = item),
                                              onSaved: (value) {
                                                _job.outServerId = value?.id;
                                              },
                                              validator: () {
                                              if (_selectedRequestStatus == null) {
                                                return 'Выберите сервер обработки запросов';
                                              }
                                              if (_selectedRequestStatus!.id == -1) {
                                                return 'Выберите сервер обработки запросов';
                                              }
                                              return null;
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
                                                    labelText: 'Дата следующего запуска*',
                                                    initialValue: _sendingDate?.toStringFormatted() ?? '',
                                                    onChange: (value) => _sendingDate = value,
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
                                                      //Past time validation
                                                      if(_selectedPeriodStatus == PeriodStatus.isWeek || _selectedPeriodStatus == PeriodStatus.isMonth) {
                                                        if (_sendingDate!.day == DateTime.now().day 
                                                        &&_sendingTime!.hour < DateTime.now().hour) {
                                                          return 'Время \nследующего \nзапуска \nне может \nбыть \nв прошлом';
                                                        } else if (_sendingDate!.day == DateTime.now().day
                                                        &&_sendingTime!.hour == DateTime.now().hour 
                                                        && _sendingTime!.minute < DateTime.now().minute) {
                                                          return 'Время \nследующего \nзапуска \nне может \nбыть \nв прошлом';
                                                        }
                                                      } 
                                                      //Interval time validation
                                                      if(_sendingTime != null && _job.fromTime != null) {
                                                        if(_sendingTime!.hour < _job.fromTime!.hour || 
                                                        _sendingTime!.hour > _job.toTime!.hour) {
                                                          return 'Время не \nнаходится \nв заданном \nпромежутке';
                                                        } else if (_sendingTime!.hour == _job.fromTime!.hour 
                                                                && _sendingTime!.minute < _job.fromTime!.minute) {
                                                          return 'Время не \nнаходится \nв заданном \nпромежутке';
                                                        } else if (_sendingTime!.hour == _job.toTime!.hour 
                                                                && _sendingTime!.minute > _job.toTime!.minute) {
                                                          return 'Время не \nнаходится \nв заданном \nпромежутке'; 
                                                        }
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
                                              value: isMoreThanOneJobInQueue,
                                              onChanged: (value) {
                                                setState(() {
                                                isMoreThanOneJobInQueue = !isMoreThanOneJobInQueue;
                                                 if(value) {
                                                   _job.isMoreThanOneJobInQueue = '1';
                                                 } else {
                                                   _job.isMoreThanOneJobInQueue = '0';
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
                                              value: onOff,
                                              onChanged: (value) {
                                                setState(() {
                                                  onOff = !onOff;
                                                  if (value) {
                                                  _job.isOn = '1';
                                                } else {
                                                  _job.isOn = '0';
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
                                              value: interruptTaskOnError,
                                              onChanged: (value) {
                                                setState(() {
                                                interruptTaskOnError = !interruptTaskOnError;
                                                 if(value) {
                                                   _job.isBreakJobPart = '1';
                                                 } else {
                                                   _job.isBreakJobPart = '0';
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
                                          job: _job,
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
                      AddJobButton(
                        onTap: _onSaveTap,
                      ),
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
        ),
      );


  void _onSaveTap() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if(_sendingDate !=null && _sendingTime !=null) {
        _job.startDate = DateTime(_sendingDate!.year, _sendingDate!.month, _sendingDate!.day, _sendingTime!.hour, _sendingTime!.minute);
      } else {
        _job.startDate = DateTime.now();
      }
      context.read<JobInsertBloc>().add(JobInsertRun(_job));
    }
  }
}
