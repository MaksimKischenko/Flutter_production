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

class JobPartParamAddScreen extends StatefulWidget {
  static const pageName = 'Добавление параметра';

  @override
  _JobPartParamAddScreenState createState() => _JobPartParamAddScreenState();
}

class _JobPartParamAddScreenState extends State<JobPartParamAddScreen> {

  AccessTypeStatus _selectedAccessType = AccessTypeStatus.onlyEdit;
  ParamTypeStatus _selectedParamType = ParamTypeStatus.string;

  bool isAutoIncIndex = false;
  bool isAutoClear = false;
  bool paramValueIsOn = false;
  double width = 1200;
  DateTime? _paramDate;
  DateTime? _paramTime;

  final _formKey = GlobalKey<FormState>();
  final _formatterInts = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]')});
  final _formatterDoubles = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[.0-9]')});
  
  final _jobPartParam = JobPartParamInsertRequest();

  @override
  void initState() {
    super.initState();
    _formatterInts.updateMask(mask: '#####################');
    _formatterDoubles.updateMask(mask: '#####################');
  }


  @override
  Widget build(BuildContext context) => BlocListener<JobPartParamInsertBloc, JobPartParamInsertState>(
   listener: (context, state) {
     if(state is JobPartParamInsertError) {
       RequestUtil.catchNetworkError(context: context, obj: state.error);
     } else if (state is JobPartParamInsertSuccess) {
          if(Navigator.of(context).canPop()) {
            Navigator.of(context).pop<JobPartParam>(state.jobPartParam);     
          } else {
            Navigation.toJobsManager();      
          }
        Multiplatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Параметр задания id:${state.jobPartParam?.jobPartParamId} добавленa',
          type: DialogType.success
        );
      }
   },
   child: Scaffold(
     body: SafeArea(
       child: Column(
         children: [
           const CommonAppBar(
              title: 'Добавление параметра',
            ),
            const Divider(),
            Expanded(
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
                                    labelText: 'Наименование параметра запроса',
                                    maxLength: 20,
                                    onSaved: (value) {
                                      _jobPartParam.name = value;
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
                                      _jobPartParam.accessType = _selectedAccessType.inJson;
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
                                      _jobPartParam.paramTypeId = _selectedParamType.inJson;
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
                                    value: isAutoIncIndex,
                                    onChanged: (value) {
                                      setState(() {
                                      isAutoIncIndex = !isAutoIncIndex;
                                      if (value) {
                                        _jobPartParam.isAutoInc = '1';
                                      } else {
                                        _jobPartParam.isAutoInc = '0';
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
                                    value: isAutoClear,
                                    onChanged: (value) {
                                      setState(() {
                                        isAutoClear = !isAutoClear;
                                        if (value) {
                                          _jobPartParam.isAutoClearAtNewDay = '1';
                                        } else {
                                          _jobPartParam.isAutoClearAtNewDay = '0';
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
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AddJobPartParamButton(
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
       )),
   ),
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
              labelText: 'Значение параметра',
              maxLength: 100,
              onSaved: (value) {
                _jobPartParam.paramValue = value;
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
              labelText: 'Значение',
              maxLength: 20,
              onSaved: (value) {
                _jobPartParam.paramValue = value;          
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
              labelText: 'Значение',
              maxLength: 20,
              onChanged: (value) {
                _jobPartParam.paramValue = value;                        
              },
            ),
          ),
        );
      } else if(_selectedParamType == ParamTypeStatus.logical) {
        return Div(
          colL: 12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16),
            child: AttrLogic(
              editable: _selectedAccessType  != AccessTypeStatus.onlyRead,
              value: paramValueIsOn,
              onChanged: (value) {
                setState(() {
                  paramValueIsOn = !paramValueIsOn;
                  if (value) {
                    _jobPartParam.paramValue = '1';  
                  } else {
                    _jobPartParam.paramValue = '0'; 
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
        _jobPartParam.paramValue = DateTime(
          _paramDate!.year, _paramDate!.month, _paramDate!.day, 
          _paramTime!.hour, _paramTime!.minute
        ).toStringFormattedGetOperationHistory();
      }

      context.read<JobPartParamInsertBloc>().add(JobPartParamInsertRun(_jobPartParam));
    }
  }
}