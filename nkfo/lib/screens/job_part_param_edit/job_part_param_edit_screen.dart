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


class JobPartParamEditScreen extends StatefulWidget {
  static const pageName = 'Редактирование параметра';

  @override
  _JobPartParamEditScreenState createState() => _JobPartParamEditScreenState();
}

class _JobPartParamEditScreenState extends State<JobPartParamEditScreen> {

  final _formKey = GlobalKey<FormState>();
  final _formatterInts = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]')});
  final _formatterDoubles = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[.0-9]')});
  
  final _jobPartParamUpdate = JobPartParamUpdateRequest();
  JobPartParam? _jobPartParam;

  AccessTypeStatus _selectedAccessType = AccessTypeStatus.onlyEdit;
  ParamTypeStatus _selectedParamType = ParamTypeStatus.string;

  bool isAutoIncIndex = false;
  bool isAutoClear = false;
  bool paramValueIsOn = false;
  double width = 1200;
  DateTime? _paramDate;
  DateTime? _paramTime;

  final _jobPartParamNameController = TextEditingController();
  final _jobPartParamValueController  = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formatterInts.updateMask(mask: '#####################');
    _formatterDoubles.updateMask(mask: '#####################');
  }
  
  @override
  void dispose() {
    _jobPartParamNameController.dispose();
    _jobPartParamValueController.dispose();
    super.dispose();
  }
   

  @override
  Widget build(BuildContext context) => Scaffold(
     body: SafeArea(
       child: Column(
         children: [
             BlocBuilder<JobPartParamUpdateBloc, JobPartParamUpdateState>(
             buildWhen: (_, next) => next is JobPartParamUpdateInitial,
             builder: (context, state) {
               String? jobPartParamName;
               if(state is JobPartParamUpdateInitial) {
                 jobPartParamName = state.jobPartParam?.name;
               }
               return CommonAppBar(
                title: 'Редактирование параметра',
                organizationName:jobPartParamName ,
              );
             },
           ),
            const Divider(),
            BlocConsumer<JobPartParamUpdateBloc, JobPartParamUpdateState>(
              listener: (context, state) {
                if (state is JobPartParamUpdateInitial) {
                  _jobPartParam = state.jobPartParam;

                  _jobPartParamUpdate
                  ..isAutoInc = state.jobPartParam?.isAutoInc
                  ..isAutoClearAtNewDay  = state.jobPartParam?.isAutoClearAtNewDay;

                  _selectedAccessType = state.jobPartParam?.accessTypeEnum ?? AccessTypeStatus.onlyEdit;
                  _selectedParamType = state.jobPartParam?.paramTypeEnum ?? ParamTypeStatus.string;

                  _jobPartParamNameController.text = state.jobPartParam?.name ?? '';
                  _jobPartParamValueController.text = state.jobPartParam?.paramValue ?? '';

                  _paramDate = state.jobPartParam?.paramValue?.toDateFormattedWithTime();
                  _paramTime = DateTime(0,0,0,_paramDate?.hour ?? 0, _paramDate?.minute ?? 0); 
          
                } else if (state is JobPartParamUpdateSuccess) {
                    if(Navigator.of(context).canPop()) {
                      Navigator.of(context).pop<JobPartParam>(state.jobPartParam);
                    } else {
                      Navigation.toJobsManager();     
                    }
                    Multiplatform.showMessage(
                      context: context,
                      title: 'Успешно',
                      message: 'Параметр отредактирован',
                      type: DialogType.success
                    );
                } else if (state is JobPartParamUpdateError) {
                  RequestUtil.catchNetworkError(
                    context: context,
                    obj: state.error
                  );
                }
              },
              buildWhen:(prev, next) {
                if (next is JobPartParamUpdateInitial) return true;
                if (next is JobPartParamUpdateInitLoading) return true;
                if (next is JobPartParamUpdateInitError) return true;
                return false;
              },
              builder: (context, state) {
                Widget body = Container();
                if(state is JobPartParamUpdateInitError) {
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
                        child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                      )
                    ]
                  );
                } else if (state is JobPartParamUpdateInitLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is JobPartParamUpdateInitial) {
                  body = Expanded(
                    child: SingleChildScrollView(
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
                                          controller: _jobPartParamNameController,
                                          labelText: 'Наименование параметра',
                                          maxLength: 20,
                                          onSaved: (value) {
                                            if ((_jobPartParam!.name ?? '') != value) {
                                              _jobPartParamUpdate.name = value;
                                            } else {
                                              _jobPartParamUpdate.name  = null;
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
                                        child: TextFieldDropdownSearch<AccessTypeStatus>(
                                          title: 'Доступ',
                                          showSearchBox: false,
                                          maxHeight: 100,
                                          items: AccessTypeStatus.values,
                                          itemBuilder: (item) => item.name ?? '',
                                          selected: _selectedAccessType,
                                          onTap: (item) {
                                            setState(() {
                                              _selectedAccessType = item;
                                            });
                                          },
                                          onSaved: (value) {
                                            _jobPartParamUpdate.accessType = _selectedAccessType.inJson;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: TextFieldDropdownSearch<ParamTypeStatus>(
                                          title: 'Тип параметра',
                                          showSearchBox: false,
                                          maxHeight: 290,
                                          items: ParamTypeStatus.values,
                                          itemBuilder: (item) => item.name,
                                          selected: _selectedParamType,
                                          onTap: (item) {
                                            setState(() {
                                              _selectedParamType = item;
                                            });
                                          },
                                          onSaved: (value) {
                                            _jobPartParamUpdate.paramTypeId = _selectedParamType.inJson;
                                          },
                                        ),
                                      ),
                                    ),
                                    _paramTypeFields(),
                                    if (_selectedParamType != ParamTypeStatus.data && _selectedParamType != ParamTypeStatus.logical) Div(
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrLogic(
                                          value: _jobPartParamUpdate.isAutoInc == '1',
                                          onChanged: (value) {
                                            setState(() {
                                              isAutoIncIndex = !isAutoIncIndex;
                                              if (value) {
                                                _jobPartParamUpdate.isAutoInc = '1';
                                              } else {
                                                _jobPartParamUpdate.isAutoInc = '0';
                                              }
                                            });
                                          },
                                          text: 'Увеличение индекса',
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ) else Container(),
                                    if (_selectedParamType != ParamTypeStatus.data && _selectedParamType != ParamTypeStatus.logical) Div(
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrLogic(
                                          value: _jobPartParamUpdate.isAutoClearAtNewDay == '1',
                                          onChanged: (value) {
                                            setState(() {
                                              isAutoClear = !isAutoClear;
                                                if (value) {
                                                _jobPartParamUpdate.isAutoClearAtNewDay = '1';
                                                } else {
                                                  _jobPartParamUpdate.isAutoClearAtNewDay = '0';
                                                }
                                            });
                                          },
                                          text: 'Автоматический сброс каждый день',
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ) else Container(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  );
                }
                return body;
              },
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
       )),
   );

   Widget _paramTypeFields () {
      if(_selectedParamType == ParamTypeStatus.string || _selectedParamType == ParamTypeStatus.list) {
        return Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              isReadOnly: _selectedAccessType  == AccessTypeStatus.onlyRead,
              controller: _jobPartParamValueController,
              labelText: 'Значение параметра',
              maxLength: 100,
              onSaved: (value) {
                if ((_jobPartParam!.paramValue ?? '') != value) {
                  _jobPartParamUpdate.paramValue = value;
                } else {
                  _jobPartParamUpdate.paramValue  = null;
                }
              },
            ),
          ),
        );
      } else if (_selectedParamType == ParamTypeStatus.number) {
        return Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16),
            child: AttrTextField(
              isReadOnly: _selectedAccessType  == AccessTypeStatus.onlyRead,
              formatter: _formatterInts,
              controller: _jobPartParamValueController,
              labelText: 'Значение',
              maxLength: 20,
              onSaved: (value) {
                if ((_jobPartParam!.paramValue ?? '') != value) {
                _jobPartParamUpdate.paramValue = value;
                } else {
                  _jobPartParamUpdate.paramValue  = null;
                }          
              },
            ),
          ),
        );
      } else if (_selectedParamType == ParamTypeStatus.doubleNum) {
        return Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16),
            child: AttrTextField(
              isReadOnly: _selectedAccessType  == AccessTypeStatus.onlyRead,
              formatter: _formatterDoubles,
              controller: _jobPartParamValueController,
              labelText: 'Значение',
              maxLength: 20,
              onChanged: (value) {
                if ((_jobPartParam!.paramValue ?? '') != value) {
                _jobPartParamUpdate.paramValue = value;
                } else {
                  _jobPartParamUpdate.paramValue  = null;
                }                            
              },
            ),
          ),
        );
      } else if(_selectedParamType == ParamTypeStatus.logical) {
       return  Div(
          colL: 12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrLogic(
              editable: _selectedAccessType  != AccessTypeStatus.onlyRead,
              value: _jobPartParam?.paramValue == '1'?
                !paramValueIsOn:paramValueIsOn,
              onChanged: (value) {
                setState(() {
                paramValueIsOn = !paramValueIsOn;
                  if (value) {
                    _jobPartParamUpdate.paramValue = '1';
                  } else {
                    _jobPartParamUpdate.paramValue = '0';
                  }
                });
              },
              text: 'Да/Нет',
              padding: EdgeInsets.zero,
            ),
          ),
       );
      } else if(_selectedParamType == ParamTypeStatus.data) {
        return Div(
          colL: 4,
          colM: 12,
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: WebDatePicker(
                    editable: _selectedAccessType  != AccessTypeStatus.onlyRead,
                    initialDate: _paramDate,
                    labelText: 'Дата',
                    onChange: (value)  {
                      _paramDate = value;
                    }    
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: AttrTimePrimary(
                    editable: _selectedAccessType  != AccessTypeStatus.onlyRead,
                    initialValue: _paramTime?.toStringFormattedHoursOnly() ?? '',
                    labelText: 'Время',
                    onSaved: (value) {
                      _paramTime = value;
                    },
                    onChangeDate: (value) {
                      _paramTime = value;
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }
    return const Text('');
  }

  void _onSaveTap() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if(_selectedParamType == ParamTypeStatus.data) {
        _jobPartParamUpdate.paramValue = DateTime(
          _paramDate!.year, _paramDate!.month, _paramDate!.day, 
          _paramTime!.hour, _paramTime!.minute
        ).toStringFormattedGetOperationHistory();
      }
      context.read<JobPartParamUpdateBloc>().add(JobPartParamUpdateRun(_jobPartParamUpdate));
    }
  }
}