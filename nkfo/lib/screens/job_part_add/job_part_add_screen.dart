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
import 'package:web_cabinet_nkfo/screens/job_part_add/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class JobPartAddScreen extends StatefulWidget {
  static const pageName = 'Добавление части задания';

  @override
  _JobPartAddScreenState createState() => _JobPartAddScreenState();
}

class _JobPartAddScreenState extends State<JobPartAddScreen> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  ActionType? _selectedActionType;
  final _formKey = GlobalKey<FormState>();
  final _jobPart = JobPartInsertRequest();
  bool onOff = false;
  List<PeriodType>? periodTypes;
  List<MessageType>? messageTypes;
  double width = 1200;
  
  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##########');
  }


  @override
  Widget build(BuildContext context) => BlocListener<JobPartInsertBloc, JobPartInsertState>(
   listener: (context, state) {
     if(state is JobPartInsertError) {
       RequestUtil.catchNetworkError(context: context, obj: state.error);
     } else if (state is JobPartInsertSuccess) {
        if(Navigator.of(context).canPop()) {
          Navigator.of(context).pop<JobPart>(state.jobPart);      
        } else {
          Navigation.toJobsManager();       
        }
        Multiplatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Часть задания id:${state.jobPart?.jobPartId} добавленa',
          type: DialogType.success
        );
      }
   },
   child: Scaffold(
     body: SafeArea(
       child: Column(
         children: [
           const CommonAppBar(
              title: 'Создание части задания',
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<JobPartInsertBloc, JobPartInsertState>(
                buildWhen:(prev, next) {
                  if (next is JobPartInsertInitial) return true;
                  if (next is JobPartInsertInitLoading) return true;
                  if (next is JobPartInsertInitError) return true;
                  return false;
                },
                builder: (context, state) {
                  Widget body = Container();
                  if(state is JobPartInsertInitError) {
                    body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const Text('Невозможно начать процедуру создания'),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          onPressed: () => context
                              .read<JobPartInsertBloc>()
                              .add(JobPartInsertInit()),
                          child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                        )
                      ],
                    );
                  } else if (state is JobPartInsertInitLoading) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  } else if (state is JobPartInsertInitial) {
                    periodTypes = state.periodTypes;
                    messageTypes = state.messageTypes;
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
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          labelText: 'Наименование части задания',
                                          maxLength: 100,
                                          onSaved: (value) {
                                            _jobPart.name = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          formatter: _formatter,
                                          labelText: 'Порядковый номер выполнения',
                                          maxLength: 10,
                                          onSaved: (value) {
                                            _jobPart.orderNum = int.tryParse(value) ?? 0;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: TextFieldDropdownSearch<ActionType>(
                                          title: 'Тип действия *',
                                          showSearchBox: false,
                                          maxHeight: 450,
                                          items: state.types,
                                          itemBuilder: (item) => item.name,
                                          selected: _selectedActionType,
                                          onTap: (item) {
                                            setState(() {
                                             _selectedActionType = item;
                                            });
                                          },
                                          onSaved: (value) {
                                            _jobPart
                                            ..actionType = value?.id
                                            ..actionTypeName = value?.name;
                                          },
                                          validator: () {
                                            if (_selectedActionType == null) {
                                              return 'Выберите тип действия';
                                            }
                                            if (_selectedActionType!.id == -1) {
                                              return 'Выберите тип действия';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrLogic(
                                          value: onOff,
                                          onChanged: (value) {
                                            setState(() {
                                              onOff = !onOff;
                                              if (value) {
                                              _jobPart.isOn = '1';
                                              } else {
                                                _jobPart.isOn = '0';
                                              }
                                            });
                                          },
                                          text: 'Вкл/выкл',
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                    _selectionActionTypeTab(_selectedActionType)
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
                   AddJobPartButton(
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
       )
    ),
   ),
  );

  Widget _selectionActionTypeTab(ActionType? selectedActionType) {
    if(selectedActionType?.id == 13) {
      return ElDigSignTab(
        request: _jobPart,
     );
    } else if (selectedActionType?.id == 3) {
      return ImOffLineMesTab(
        request: _jobPart,
     );
    } else if (selectedActionType?.id == 5) {
      return ProcReqTab(
        request: _jobPart,
        periodTypes: periodTypes ?? [],
     );
    } else if (selectedActionType?.id == 8) {
      return ExpOfflineMesTab(
        request: _jobPart,
        periodTypes: periodTypes ?? [],
     );
    } 
    else if (selectedActionType?.id == 10) {
      return ExOfflineMesAbonTab(
        request: _jobPart,
     );
    } else if (selectedActionType?.id == 11) {
       return ImOfflineMesAbonTab(
      request:_jobPart,
      messageTypes: messageTypes,
     );
    } else if (selectedActionType?.id == 12) {
       return ComFileTab(
        request: _jobPart,
     );
    } else if(selectedActionType?.id == 1) {
      return ExTrpTemplateTab(
        request: _jobPart, 
        periodTypes: periodTypes ?? [],
      );
    } else if (selectedActionType?.id == 14) {
       return CopyFileTab(
        request: _jobPart
      );
    }
    return Container();
  }

  void _onSaveTap() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<JobPartInsertBloc>().add(JobPartInsertRun(_jobPart));
    }
  }
}