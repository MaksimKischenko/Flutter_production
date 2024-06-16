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
import 'package:web_cabinet_nkfo/screens/job_part_edit/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class JobPartEditScreen extends StatefulWidget {
  static const pageName = 'Редактирование части задания';

  @override
  _JobPartEditScreenState createState() => _JobPartEditScreenState();
}

class _JobPartEditScreenState extends State<JobPartEditScreen> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });
  
  final _formKey = GlobalKey<FormState>();
  final _jobPartUpdate = JobPartUpdateRequest();
  JobPart? _jobPart;

  ActionType? _selectedActionType;
  PeriodType? _selectedPeriodType;
  MessageType? _selectedMessageType;
  ProxyTypeStatus _selectedProxyStatus = ProxyTypeStatus.none;
  ProxyTypeStatus _selectedProxyStatusN = ProxyTypeStatus.none;
  List<PeriodType>? _periodTypes;
  List<MessageType>? _messageTypes;
  bool isOn = false;
  double width = 1200; 
  final _jobPartNameController = TextEditingController();
  final _jobPartOrderNumController = TextEditingController();
  final _jobPartImportDirController  = TextEditingController();
  final _jobPartExportDirController  = TextEditingController();
  final _jobPartTempFileNameController  = TextEditingController();
  final _jobPartSqlTextController  = TextEditingController();
  final _jobPartAfterImportDirController  = TextEditingController();
  final _jobPartErrorDirController  = TextEditingController();
  final _jobPartCopyExportDirController  = TextEditingController();
  final _jobPartNumOfPrevPeriodController  = TextEditingController();
  final _jobPartIdFieldNameController = TextEditingController();
  final _jobPartSumFieldNameController = TextEditingController();
  final _jobPartComandFileController = TextEditingController();
  final _jobPartParamComandFileController = TextEditingController();
  final _jobPartMaxFileSizeController = TextEditingController();

  //FTP
  final _ftpHostController = TextEditingController();
  final _ftpHostControllerN = TextEditingController();
  final _ftpPortController = TextEditingController();
  final _ftpPortControllerN = TextEditingController();
  final _ftpLoginController = TextEditingController();
  final _ftpLoginControllerN = TextEditingController();
  final _ftpPasswordController = TextEditingController();
  final _ftpPasswordControllerN = TextEditingController();
  final _proxyHostController = TextEditingController();
  final _proxyPortController = TextEditingController();
  final _proxyLoginController = TextEditingController();
  final _proxyPasswordController = TextEditingController();
  final _proxyHostControllerN = TextEditingController();
  final _proxyPortControllerN = TextEditingController();
  final _proxyLoginControllerN = TextEditingController();
  final _proxyPasswordControllerN = TextEditingController();



  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##########');
  }

  @override
  void dispose() {
   _jobPartNameController.dispose();
   _jobPartOrderNumController.dispose();
   _jobPartImportDirController.dispose();
   _jobPartExportDirController.dispose();
   _jobPartTempFileNameController.dispose();
   _jobPartSqlTextController.dispose();
   _jobPartAfterImportDirController.dispose();
   _jobPartErrorDirController.dispose();
   _jobPartCopyExportDirController.dispose();
   _jobPartNumOfPrevPeriodController.dispose();
   _jobPartIdFieldNameController.dispose();
   _jobPartSumFieldNameController.dispose();
   _jobPartComandFileController.dispose();
   _jobPartParamComandFileController.dispose();
   _jobPartMaxFileSizeController.dispose();
   _ftpHostController.dispose();
   _ftpHostControllerN.dispose();
   _ftpPortController.dispose();
   _ftpPortControllerN.dispose();
   _ftpLoginController.dispose();
   _ftpLoginControllerN.dispose();
   _ftpPasswordController.dispose();
   _ftpPasswordControllerN.dispose();
   _proxyHostController.dispose();
   _proxyPortController.dispose();
   _proxyLoginController.dispose();
   _proxyPasswordController.dispose();
   _proxyHostControllerN.dispose();
   _proxyPortControllerN.dispose();
   _proxyLoginControllerN.dispose();
   _proxyPasswordControllerN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
     body: SafeArea(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           BlocBuilder<JobPartUpdateBloc, JobPartUpdateState>(
            buildWhen: (_, next) => next is JobPartUpdateInitial,
            builder: (context, state) {
              String? jobPartName;
              if(state is JobPartUpdateInitial) {
                jobPartName = state.jobPart?.name;
              }
               return CommonAppBar(
                 title: 'Редактирование части задания',
                 organizationName: jobPartName,
              );
             },
           ),
            const Divider(),
            Expanded(
              child: BlocConsumer<JobPartUpdateBloc, JobPartUpdateState>(
                listener: (context, state) {
                 if(state is JobPartUpdateInitial) {
                   _jobPart = state.jobPart;

                   _jobPartUpdate
                   ..isOn = state.jobPart?.isOn
                   ..isUseDate = state.jobPart?.isUseDate
                   ..isForCurPeriod = state.jobPart?.isForCurPeriod
                   ..isFtp = state.jobPart?.isFtp
                   ..isFtpN = state.jobPart?.isFtpN
                   ..ftpIspassiveMode = state.jobPart?.ftpIspassiveMode
                   ..ftpIspassiveModeN = state.jobPart?.ftpIspassiveModeN
                   ..useEsign = state.jobPart?.useEsign;
                   //..ftpI

                   _selectedProxyStatus = _returnStatus(_jobPart);
                   _selectedProxyStatusN = _returnStatusN(_jobPart);

                   _selectedActionType = state.types.firstOrNullWhere((e) => e.name == state.jobPart?.actionTypeName);
                   _selectedPeriodType  = state.periodTypes.firstOrNullWhere((e) => e.name == state.jobPart?.periodTypeName);
                   _selectedMessageType = state.messageTypes.firstOrNullWhere((e) => e.id == state.jobPart?.messageTypeId);
                   _periodTypes = state.periodTypes;
                   _messageTypes = state.messageTypes;
                   _jobPartNameController.text = state.jobPart?.name ?? '';
                   _jobPartOrderNumController.text = state.jobPart?.orderNum.toString() ?? '';
                   _jobPartImportDirController.text = state.jobPart?.impDir ?? '';
                   _jobPartExportDirController.text = state.jobPart?.expDir ?? '';
                   _jobPartTempFileNameController.text = state.jobPart?.tmpFileName ?? '';
                   _jobPartSqlTextController.text = state.jobPart?.sql ?? '';
                   _jobPartAfterImportDirController.text = state.jobPart?.afterImpDir ?? '';
                   _jobPartErrorDirController.text = state.jobPart?.dirInErr ?? '';
                   _jobPartCopyExportDirController.text = state.jobPart?.copyExpDir ?? '';
                   _jobPartNumOfPrevPeriodController.text = state.jobPart?.numOfPrevPeriod.toString() ?? '';
                   _jobPartIdFieldNameController.text = state.jobPart?.idFieldName ?? '';
                   _jobPartSumFieldNameController.text = state.jobPart?.sumFieldName ?? '';
                   _jobPartComandFileController.text = state.jobPart?.comFile ?? '';
                   _jobPartParamComandFileController.text = state.jobPart?.paramComFile ?? '';
                   _jobPartMaxFileSizeController.text = state.jobPart?.maxFileSize.toString() ?? '';

                   //FTP
                   _ftpHostController.text = state.jobPart?.ftpHost ?? '';
                   _ftpHostControllerN.text = state.jobPart?.ftpHostN ?? '';
                   _ftpPortController.text = state.jobPart?.ftpPort.toString() ?? '';
                   _ftpPortControllerN.text = state.jobPart?.ftpPortN.toString() ?? '';
                   _ftpLoginController.text = state.jobPart?.ftpUsername ?? '';
                   _ftpLoginControllerN.text = state.jobPart?.ftpUsernameN ?? '';
                   _ftpPasswordController.text = state.jobPart?.ftpPassword ?? '';
                   _ftpPasswordControllerN.text = state.jobPart?.ftpPasswordN ?? '';

                   _proxyHostController.text = state.jobPart?.proxyHost ?? '';
                   _proxyPortController.text = state.jobPart?.proxyPort.toString() ?? '';
                   _proxyLoginController.text = state.jobPart?.proxyUsername ?? '';
                   _proxyPasswordController.text = state.jobPart?.proxyPassword ?? '';
                   _proxyHostControllerN.text = state.jobPart?.proxyHostN ?? '';
                   _proxyPortControllerN.text = state.jobPart?.proxyPortN.toString() ?? '';
                   _proxyLoginControllerN.text = state.jobPart?.proxyUsernameN ?? '';
                   _proxyPasswordControllerN.text = state.jobPart?.proxyPasswordN.toString() ?? '';
                 } else if (state is JobPartUpdateError) {
                  RequestUtil.catchNetworkError(
                    context: context,
                    obj: state.error
                  );
                } else if (state is JobPartUpdateSuccess) {
                    if(Navigator.of(context).canPop()) {
                      Navigator.of(context).pop<JobPart>(state.jobPart);
                    } else {
                      Navigation.toJobsManager();          
                    }
                    Multiplatform.showMessage(
                      context: context,
                      title: 'Успешно',
                      message: 'Часть задания отредактирована',
                      type: DialogType.success
                    );
                }
                },
                buildWhen:(prev, next) {
                  if (next is JobPartUpdateInitial) return true;
                  if (next is JobPartUpdateInitLoading) return true;
                  if (next is JobPartUpdateInitError) return true;
                  return false;
                },
                builder: (context, state) {
                  Widget body = Container();
                  if(state is JobPartUpdateInitError) {
                    body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const Text('Невозможно начать процедуру редактирования'),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          onPressed: () => context
                              .read<JobPartUpdateBloc>()
                              .add(JobPartUpdateInit()),
                          child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                        )
                      ],
                    );
                  } else if (state is JobPartUpdateInitLoading) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  } else if (state is JobPartUpdateInitial) {
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
                                          controller: _jobPartNameController,
                                          labelText: 'Наименование части задания',
                                          maxLength: 100,
                                          onSaved: (value) {
                                            if ((_jobPart?.name ?? '') != value) {
                                              _jobPartUpdate.name = value;
                                            } else {
                                              _jobPartUpdate.name  = null;
                                            }
                                          },
                                          onChanged: (_) => setState(() {}),
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
                                          controller: _jobPartOrderNumController,
                                          labelText: 'Порядковый номер выполнения',
                                          maxLength: 10,
                                          onSaved: (value) {
                                            if ((_jobPart?.orderNum ?? '') != value) {
                                              _jobPartUpdate.orderNum = int.tryParse(value) ?? 0;
                                            } 
                                          },
                                          onChanged: (_) => setState(() {}),
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: TextFieldDropdownSearch<ActionType>(
                                          title: 'Тип действия',
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
                                            if(_jobPart?.actionType != _selectedActionType?.id) {
                                              _jobPartUpdate
                                              ..actionType = _selectedActionType?.id
                                              ..actionTypeName = _selectedActionType?.name;
                                            } else {
                                              _jobPartUpdate.actionType  = null;
                                            }  
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrLogic(
                                          value: _jobPartUpdate.isOn =='1',
                                          onChanged: (value) {
                                            setState(() {
                                              isOn = !isOn;
                                            });
                                            if (value) {
                                              _jobPartUpdate.isOn = '1';
                                            } else {
                                              _jobPartUpdate.isOn = '0';
                                            }                                          
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

   ProxyTypeStatus _returnStatus (JobPart? jobPart) {
    if (jobPart?.proxyType == -1) {
      return ProxyTypeStatus.none;
    } else if (jobPart?.proxyType == 0) {
      return ProxyTypeStatus.httpWithFtp;
    } else if(jobPart?.proxyType == 1){
      return ProxyTypeStatus.open;
    } else if(jobPart?.proxyType == 2) {
      return ProxyTypeStatus.site;
    } else if(jobPart?.proxyType == 3) {
      return ProxyTypeStatus.tranparent;
    } else if(jobPart?.proxyType == 4) {
      return ProxyTypeStatus.userPass;
    } else if(jobPart?.proxyType == 5) {
      return ProxyTypeStatus.userSite;
    }
    return ProxyTypeStatus.none;
  }

   ProxyTypeStatus _returnStatusN (JobPart? jobPart) {
    if (jobPart?.proxyTypeN == -1) {
      return ProxyTypeStatus.none;
    } else if (jobPart?.proxyTypeN == 0) {
      return ProxyTypeStatus.httpWithFtp;
    } else if(jobPart?.proxyTypeN == 1){
      return ProxyTypeStatus.open;
    } else if(jobPart?.proxyTypeN == 2) {
      return ProxyTypeStatus.site;
    } else if(jobPart?.proxyTypeN == 3) {
      return ProxyTypeStatus.tranparent;
    } else if(jobPart?.proxyTypeN == 4) {
      return ProxyTypeStatus.userPass;
    } else if(jobPart?.proxyTypeN == 5) {
      return ProxyTypeStatus.userSite;
    }
    return ProxyTypeStatus.none;
  }


  Widget _selectionActionTypeTab(ActionType? selectedActionType) {
    if(selectedActionType?.id == 13) {
    return ElDigSignTab(
      request: _jobPartUpdate,
      jobPart: _jobPart,
      jobPartExportDirController: _jobPartExportDirController,
      jobPartImportDirController: _jobPartImportDirController,
      jobPartTempFileNameController: _jobPartTempFileNameController,
     );
    } else if (selectedActionType?.id == 3) {
    return ImOffLineMesTab(
      request: _jobPartUpdate,
      jobPart: _jobPart,
      jobPartSqlTextController: _jobPartSqlTextController,
      jobPartExportDirController: _jobPartExportDirController,
      jobPartImportDirController: _jobPartImportDirController,
      jobPartTempFileNameController: _jobPartTempFileNameController,
      jobPartAfterImportDirController: _jobPartAfterImportDirController,
      jobPartCopyExportDirController: _jobPartCopyExportDirController,
      jobPartErrorDirController: _jobPartErrorDirController,
      ftpHostController: _ftpHostController,
      ftpPortController: _ftpPortController,
      ftpLoginController: _ftpLoginController,
      ftpPasswordController: _ftpPasswordController,
      selectedProxyStatus: _selectedProxyStatus,
      proxyHostController: _proxyHostController,
      proxyPortController: _proxyPortController,
      proxyLoginController: _proxyLoginController,
      proxyPasswordController: _proxyPasswordController,
    );
  } else if (selectedActionType?.id == 5) {
    return ProcReqTab(
      request: _jobPartUpdate,
      jobPart: _jobPart,
      periodTypes: _periodTypes,
      selectedPeriodType: _selectedPeriodType,
      jobPartSqlTextController: _jobPartSqlTextController,
      jobPartNumOfPrevPeriodController: _jobPartNumOfPrevPeriodController,
      jobPartIdFieldNameController: _jobPartIdFieldNameController,
      jobPartSumFieldNameController: _jobPartSumFieldNameController,
     );
    } else if (selectedActionType?.id == 8) {
    return ExpOfflineMesTab(
      request: _jobPartUpdate,
      jobPart: _jobPart,
      periodTypes: _periodTypes,
      selectedPeriodType: _selectedPeriodType,
      selectedProxyStatus: _selectedProxyStatus,
      jobPartSqlTextController: _jobPartSqlTextController,
      jobPartExportDirController: _jobPartExportDirController,
      jobPartCopyExportDirController: _jobPartCopyExportDirController,
      jobPartComandFileController: _jobPartComandFileController,
      jobPartParamComandFileController: _jobPartParamComandFileController,
      jobPartNumOfPrevPeriodController: _jobPartNumOfPrevPeriodController,
      ftpHostController: _ftpHostController,
      ftpPortController: _ftpPortController,
      ftpLoginController: _ftpLoginController,
      ftpPasswordController: _ftpPasswordController,
      proxyHostController: _proxyHostController,
      proxyPortController: _proxyPortController,
      proxyLoginController: _proxyLoginController,
      proxyPasswordController: _proxyPasswordController,
     );
    } else if (selectedActionType?.id == 10) {
    return ExOfflineMesAbonTab(
      request: _jobPartUpdate,
      jobPart: _jobPart,
      jobPartSqlTextController: _jobPartSqlTextController,
     );
    } else if (selectedActionType?.id == 11) {
    return ImOfflineMesAbonTab(
      messageTypes: _messageTypes,
      selectedMessageType: _selectedMessageType,
      request: _jobPartUpdate, 
      jobPart: _jobPart, 
      jobPartSqlTextController: _jobPartSqlTextController, 
      jobPartTempFileNameController: _jobPartTempFileNameController, 
      jobPartMaxFileSizeController: _jobPartMaxFileSizeController
     );
    } else if (selectedActionType?.id == 12) {
    return ComFileTab(
      request: _jobPartUpdate,
      jobPart: _jobPart,
      jobPartComandFileController: _jobPartComandFileController,
      jobPartParamComandFileController: _jobPartParamComandFileController,
     );
    } else if (selectedActionType?.id == 1) {
      return ExTrpTemplateEditTab(
        request: _jobPartUpdate, 
        jobPart: _jobPart, 
        periodTypes: _periodTypes, 
        selectedPeriodType: _selectedPeriodType, 
        selectedProxyStatus: _selectedProxyStatus, 
        jobPartTempFileNameController: _jobPartTempFileNameController, 
        jobPartIdFieldNameController: _jobPartIdFieldNameController, 
        jobPartSumFieldNameController: _jobPartSumFieldNameController, 
        jobPartExportDirController: _jobPartExportDirController, 
        jobPartExportDirCopyController: _jobPartCopyExportDirController, 
        jobPartNumOfPrevPeriodController: _jobPartNumOfPrevPeriodController, 
        ftpHostController: _ftpHostController, 
        ftpPortController: _ftpPortController, 
        ftpLoginController: _ftpLoginController, 
        ftpPasswordController: _ftpPasswordController,
        proxyHostController: _proxyHostController,
        proxyPortController: _proxyPortController,
        proxyLoginController: _proxyLoginController,
        proxyPasswordController: _proxyPasswordController,
      );
    } else if (selectedActionType?.id == 14) {
     return CopyFileTab(
      request: _jobPartUpdate,
      jobPart: _jobPart,
      selectedProxyStatus: _selectedProxyStatus,
      selectedProxyStatusN: _selectedProxyStatusN,
      jobPartExportDirController: _jobPartExportDirController,
      jobPartImportDirController: _jobPartImportDirController,
      jobPartTempFileNameController: _jobPartTempFileNameController,
      ftpHostController: _ftpHostController, 
      ftpPortController: _ftpPortController, 
      ftpLoginController: _ftpLoginController, 
      ftpPasswordController: _ftpPasswordController,
      ftpHostControllerN: _ftpHostControllerN, 
      ftpPortControllerN: _ftpPortControllerN, 
      ftpLoginControllerN: _ftpLoginControllerN, 
      ftpPasswordControllerN: _ftpPasswordControllerN,
      proxyHostController: _proxyHostController,
      proxyPortController: _proxyPortController,
      proxyLoginController: _proxyLoginController,
      proxyPasswordController: _proxyPasswordController,
      proxyHostControllerN: _proxyHostControllerN,
      proxyPortControllerN: _proxyPortControllerN,
      proxyLoginControllerN: _proxyLoginControllerN,
      proxyPasswordControllerN: _proxyPasswordControllerN,
     );
    }
    return Container();
  }
  void _onSaveTap() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<JobPartUpdateBloc>().add(JobPartUpdateRun(_jobPartUpdate));
    }
  }
}