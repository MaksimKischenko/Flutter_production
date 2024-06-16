import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_plus/data_table_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

class JobPartRunParamsScreen extends StatefulWidget {
  static const pageName = 'Ввод параметров';

  @override
  _JobPartRunParamsScreenState createState() => _JobPartRunParamsScreenState();
}

class _JobPartRunParamsScreenState extends State<JobPartRunParamsScreen> {

  final _formKey = GlobalKey<FormState>();
  final _formatterInts = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]')});
  final _formatterDoubles = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[.0-9]')});
  final _jobPartParamNameController = TextEditingController();

  
  JobPartRunParam? _selectedParam;

  bool noValue = false;


  int _selectedRow = -1;

  DateTime? _paramDate;
  DateTime? _paramTime;
  int? jobId;
  int? jobPartId;
  double width = 1200;

  List<JobPartRunParam> params = [];
  List<TextEditingController> valueControllers = [];

  @override
  void initState() {
    super.initState();
     valueControllers = List.generate(10, (index) => TextEditingController());
    _formatterInts.updateMask(mask: '#####################');
    _formatterDoubles.updateMask(mask: '#####################');
  }

  @override
  void dispose() {
    _jobPartParamNameController.dispose();
    for (final element in valueControllers) {element.dispose();}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const CommonAppBar(
            title: 'Ввод параметров',
          ),
          const Divider(),
          BlocConsumer<JobPartRunBloc, JobPartRunState>(
            listener: (context, state) {
              if (state is JobPartRunInitialError) {
                Navigator.of(context).pop();
                Multiplatform.showMessage(
                  context: context, 
                  title: 'Ошибка', 
                  message: state.error.toString(),
                  type: DialogType.error
                );
              } else if(state is JobPartRunError) {
                RequestUtil.catchNetworkError(context: context, obj: state.error);
              } else if(state is JobPartRunSuccess) {
                  if(Navigator.of(context).canPop()) {
                    Navigator.of(context).pop<String>(state.message);  
                  } else {
                    Navigation.toJobsManager();      
                  }
                Multiplatform.showMessage(
                  context: context,
                  title: 'Успешно',
                  message: 'Часть задания id:${state.id} запущена',
                  type: DialogType.success
                );
              }                     
            },
            builder: (context, state) {
              Widget body = Container();
              if (state is JobPartRunLoading) {
                body = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: double.maxFinite),
                    Text(
                      'Идет обработка запущенной части задания',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: AppStyles.mainColor
                      ),
                    ),
                    const SizedBox(height: 12),
                    const LoadingIndicator(),
                  ],
                );
              } else if (state is JobPartRunInitial) {
                jobId = state.jobId;
                jobPartId = state.jobPartid;
                params = state.jobsPartRunParam;
                body = ResponsiveBuilder(
                    builder: (context, sizingInformation) {

                  if (sizingInformation.isMobile ||
                      sizingInformation.isTablet) {
                    width = sizingInformation.screenSize.width;
                  }
                  return Center(
                    child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Form(
                          key: _formKey,
                          child: Responsive(runSpacing: 16,
                            children: [
                              const SizedBox(height: 16),
                              Div(
                                colL: 12,
                                colM: 12,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTablePlus(
                                      showBottomBorder: true,
                                      headingTextStyle: AppStyles.headerTextStyleLess,
                                      headingRowColor: MaterialStateProperty.all(AppStyles.mainColor.withOpacity(0.2)),
                                      dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                        if (states.contains(MaterialState.selected)) {
                                          return AppStyles.mainColor.withOpacity(0.2);
                                        }
                                        return Colors.transparent;  
                                      }),            
                                      columnSpacing: 250,
                                      columns: const [
                                        DataColumn2(
                                          label: Text('Параметр'),
                                          size: ColumnSize.M
                                        ),
                                        DataColumn2(
                                          label: Text('Значение параметра'),
                                          size: ColumnSize.M
                                        ),
                                        DataColumn2(
                                          label: Text('Тип параметра'),
                                          size: ColumnSize.M
                                        ),
                                      ],
                                      rows: state.jobsPartRunParam.mapIndexed((e, index) => DataRow( 
                                        selected: index == _selectedRow,
                                        cells: [
                                        DataCell(
                                          Center(
                                            child: Text(e.name ?? ''),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedRow = index; 
                                              _selectedParam  = params[index];
                                              _jobPartParamNameController.text = _selectedParam?.name ?? '';  
                                              valueControllers[_selectedRow].text = _selectedParam?.paramValue ?? '';  

                                              if(_selectedParam?.paramType == 5) {
                                                _paramDate = _selectedParam?.paramValue?.toDateFormattedWithTime();
                                                _paramTime = DateTime(0,0,0,_paramDate?.hour ?? 0, _paramDate?.minute ?? 0); 
                                              }
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Center(child: Text(e.paramValue ?? ''),
                                          ),
                                          onTap:() {
                                            setState(() {
                                              _selectedRow = index;
                                              _selectedParam  = params[index];

                                              _jobPartParamNameController.text = _selectedParam?.name ?? '';  
                                              valueControllers[_selectedRow].text = _selectedParam?.paramValue ?? '';

                                              if(_selectedParam?.paramType == 5) {
                                                _paramDate = _selectedParam?.paramValue?.toDateFormattedWithTime();
                                                _paramTime = DateTime(0,0,0,_paramDate?.hour ?? 0, _paramDate?.minute ?? 0); 
                                              }          
                                            });
                                          }, 
                                        ),
                                        DataCell(
                                          Text(_paramTypeNames(e)),
                                          onTap:() {
                                            setState(() {
                                              _selectedRow = index;
                                              _selectedParam  = params[index];

                                              _jobPartParamNameController.text = _selectedParam?.name ?? '';  
                                              valueControllers[_selectedRow].text = _selectedParam?.paramValue ?? '';

                                              if(_selectedParam?.paramType == 5) {
                                                _paramDate = _selectedParam?.paramValue?.toDateFormatted();
                                                _paramTime = DateTime(0,0,0,_paramDate?.hour ?? 0, _paramDate?.minute ?? 0); 
                                              }         
                                            });
                                          }, 
                                        ),
                                      ])).toList()
                                    ),
                                  ),
                                ),
                              ),
                              Div(
                                child: const SizedBox(height: 100)
                              ),
                              Div(
                                colL: 4,
                                colM: 12,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: AttrTextField(
                                    isReadOnly: true,
                                    controller: _jobPartParamNameController,
                                    labelText: 'Параметр',
                                    maxLength: 100,
                                  ),
                                ),
                              ),
                              _paramTypeFields(_selectedParam),
                              Div(
                                colL: 2,
                                colM: 12,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: AttrLogic(
                                    editable: _selectedParam?.accessType == 0,
                                    value: noValue,
                                    onChanged: (value) {
                                      setState(() {
                                        noValue = !noValue;
                                        if (value) {
                                          valueControllers[_selectedRow].text = '';
                                          _selectedParam?.paramValue = null;
                                          params[_selectedRow]  = _selectedParam!;
                                        } else {}
                                      });
                                    },
                                    text: 'Нет значения',
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),       
                            ]
                          ),
                        )),
                  );
                });
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

  String _paramTypeNames (JobPartRunParam param) {
    if(param.paramType == 1) {
      return 'Строка';
    } else if(param.paramType == 2) {
      return 'Целое число';
    } else if(param.paramType == 3) {
      return 'Дробное число';
    } else if(param.paramType == 4) {
      return 'Логический';
    } else if(param.paramType == 5) {
      return 'Дата';
    } else if(param.paramType == 6) {
      return 'Список';
    } return '';
  }

  Widget _paramTypeFields (JobPartRunParam? param) {
    if(param?.paramType == 1 || param?.paramType == 6) {
      return Div(
        colL: 4,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16),
          child: 
          AttrTextField(
            isReadOnly: _selectedParam?.accessType ==1,
            controller: valueControllers[_selectedRow],
            labelText: 'Значение',
            maxLength: 20,
            onChanged: (value) {
              if(_selectedParam?.paramValue != value) {
                _selectedParam?.paramValue = value;
                params[_selectedRow]  = _selectedParam!;   
              }                         
            }
          ),
        ),
      );
    } else if (param?.paramType == 2) {
      return Div(
        colL: 4,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16),
          child: AttrTextField(
            isReadOnly: _selectedParam?.accessType ==1,
            formatter: _formatterInts,
            controller:valueControllers[_selectedRow],
            labelText: 'Значение',
            maxLength: 20,
            onChanged: (value) {
              if(_selectedParam?.paramValue != value) {
                _selectedParam?.paramValue = value;
                params[_selectedRow]  = _selectedParam!;
              }                          
            },
          ),
        ),
      );
    } else if (param?.paramType == 3) {
      return Div(
        colL: 4,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16),
          child: AttrTextField(
            isReadOnly: _selectedParam?.accessType == 1,
            formatter: _formatterDoubles,
            controller:valueControllers[_selectedRow],
            labelText: 'Значение',
            maxLength: 20,
            onChanged: (value) {
              if(_selectedParam?.paramValue != value) {
                _selectedParam?.paramValue = value;
                params[_selectedRow]  = _selectedParam!;
              }                          
            },
          ),
        ),
      );
    } else if(param?.paramType == 4) {
      return Div(
        colL: 2,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16),
          child: AttrLogic(
            editable: _selectedParam?.accessType == 1,
            value: _selectedParam?.paramValue == '1',
            onChanged: (value) {
              setState(() {
                if (value) {
                  _selectedParam?.paramValue = '1';
                  params[_selectedRow]  = _selectedParam!;
                } else {
                  _selectedParam?.paramValue = '0';
                  params[_selectedRow]  = _selectedParam!;
                }
              });
            },
            text: 'Да',
            padding: EdgeInsets.zero,
          ),
        ),
      ); 
    } else if(param?.paramType == 5) {
      return Div(
        colL: 4,
        colM: 12,
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: WebDatePicker(
                  editable: _selectedParam?.accessType == 0,
                  labelText: 'Дата',
                  initialDate: _paramDate,
                  onChange: (value)  {
                    _paramDate = value;
                  }    
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 120,
                child: AttrTimePrimary(
                  editable:_selectedParam?.accessType == 0,
                  labelText: 'Время',
                  initialValue: _paramTime?.toStringFormattedHoursOnly()?? '',
                  onChangeDate: (value) {
                    _paramTime = value;
                  },
                  onSaved: (value) {
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
      if(_selectedParam?.paramType == 5) {
        _selectedParam?.paramValue = DateTime(_paramDate!.year, _paramDate!.month, _paramDate!.day, _paramTime!.hour, _paramTime!.minute).toStringFormattedGetOperationHistory();
        params[_selectedRow]  = _selectedParam!;
      }
      context.read<JobPartRunBloc>().add(JobPartRunJobPart(
        jobId: jobId, 
        jobPartId: jobPartId, 
        params: params 
      ));
    }
  }
}
