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
import 'package:web_cabinet_nkfo/screens/organization_edit/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/multiplatform.dart';
import 'package:web_cabinet_nkfo/utils/request_util.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';


class OrganizationEditScreen extends StatefulWidget {
  static const pageName = 'Организации. Редактирование';

  @override
  _OrganizationEditState createState() => _OrganizationEditState();
}

class _OrganizationEditState extends State<OrganizationEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _focusNodes = List.generate(7, (_) => FocusNode());
  final _parentFieldKeys = List.generate(7, (index) => Key('field $index'));
  final _fieldKeys = List.generate(7, (_) => GlobalKey<FormFieldState>());

  Bank? _selectedBank;

  final _shortNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _abonentController = TextEditingController();
  final _contractController = TextEditingController();
  final _accountController = TextEditingController();
  final _terminalNumberController = TextEditingController();
  final _agentAccountController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _managerPostController = TextEditingController();
  final _bookkeeperNameController = TextEditingController();
  final _ftpHostController = TextEditingController();
  final _ftpPortController = TextEditingController();
  final _ftpLoginController = TextEditingController();
  final _ftpPasswordController = TextEditingController();

  final _accountFormatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[a-zA-Z0-9]') });
  String? _accountHint;
  String saveTerminalNumber = '';
  String saveAgentAccount = '';
  bool isScreenAbsorbed = false;
  double width = 800;

  Supplier? _supplier;
  final _supplierUpdate = SupplierUpdateRequest();

  bool get isSaveAvailable {
    if (_supplier == null) return false;
    return _supplier!.enabled != _supplierUpdate.enabled
    || (_supplier!.shortName ?? '') != _shortNameController.text
    || (_supplier!.name ?? '') != _fullNameController.text
    || (_supplier!.address ?? '') != _addressController.text
    || (_supplier!.email ?? '') != _emailController.text
    || (_supplier!.abonent ?? '') != _abonentController.text
    || (_supplier!.contract ?? '') != _contractController.text
    || _supplier!.bankId != _selectedBank?.id
    || (_supplier!.account ?? '') != _accountController.text
    || (_supplier!.terminalNumber ?? '') != _terminalNumberController.text
    || (_supplier!.agentAccount ?? '') != _agentAccountController.text
    || (_supplier!.usePaymentAccaunt) != _supplierUpdate.usePaymentAccaunt
    || (_supplier!.managerName ?? '') != _managerNameController.text
    || (_supplier!.managerPost ?? '') != _managerPostController.text
    || (_supplier!.bookkeeperName ?? '') != _bookkeeperNameController.text
    || (_supplier!.ftpServer ?? '') != _ftpHostController.text
    || (_supplier!.ftpPort ?? '') != _ftpPortController.text
    || (_supplier!.ftpLogin ?? '') != _ftpLoginController.text
    || (_supplier!.ftpPassword ?? '') != _ftpPasswordController.text;
  }

  @override
  void initState() {
    super.initState();
    _focusNodes.forEachIndexed((node, index) {
      node.addListener(() async {
        if (!_focusNodes[index].hasFocus) {
          _fieldKeys[index].currentState?.validate();
        }
      });
    });
    _accountController.addListener(() {
      if(_accountController.text. contains(RegExp('[a-z]'))) {
        setState(() {
         _accountController
         ..text =  _accountController.text.toUpperCase()
         ..selection = TextSelection.fromPosition(TextPosition(offset: _accountController.text.length));
        });
      }
    });    
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    _shortNameController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _abonentController.dispose();
    _contractController.dispose();
    _accountController.dispose();
    _terminalNumberController.dispose();
    _agentAccountController.dispose();
    _managerNameController.dispose();
    _managerPostController.dispose();
    _bookkeeperNameController.dispose();
    _ftpHostController.dispose();
    _ftpPortController.dispose();
    _ftpLoginController.dispose();
    _ftpPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<SupplierUpdateBloc, SupplierUpdateState>(
                  buildWhen: (_, next) => next is SupplierUpdateInitial,
                  builder: (context, state) {
                    String? organizationName;
                    Color? statusColor;
                    String? statusName;
                    List<Widget>? actions;
                    if (state is SupplierUpdateInitial) {
                      organizationName = state.supplier?.shortName;
                      statusColor = state.supplier?.statusColor;
                      statusName = state.supplier?.statusText;
                    }
                    return CommonAppBar(
                      title: 'Редактирование организации',
                      organizationName: organizationName,
                      statusColor: statusColor,
                      statusName: statusName,
                      actions: actions,
                    );
                  },
                ),
                const Divider(),
                Expanded(
                  child: BlocConsumer<SupplierUpdateBloc, SupplierUpdateState>(
                    listener: (context, state) {
                      if (state is SupplierUpdateInitial) {
                        _supplier = state.supplier;

                        _supplierUpdate..enabled = state.supplier?.enabled ?? false
                        ..usePaymentAccaunt = state.supplier?.usePaymentAccaunt ?? false;
                        _selectedBank = state.banks?.firstOrNullWhere((e) => e.id == state.supplier?.bankId);
                        if (_selectedBank != null) {
                          //_accountFormatter.updateMask(mask: 'BY##${_selectedBank?.bic.substring(0, 4)}####################');
                          _accountFormatter.updateMask(mask: '############################');                          
                          _accountController.text = _accountFormatter.maskText(state.supplier?.account ?? '');
                        }
                        _accountController.text = state.supplier?.account ?? '';

                        _shortNameController.text = state.supplier?.shortName ?? '';
                        _fullNameController.text = state.supplier?.name ?? '';
                        _addressController.text = state.supplier?.address ?? '';
                        _emailController.text = state.supplier?.email ?? '';
                        _abonentController.text = state.supplier?.abonent ?? '';
                        _contractController.text = state.supplier?.contract ?? '';
                        _accountController.text = state.supplier?.account ?? '';

                        ///
                        _terminalNumberController.text = state.supplier?.terminalNumber ?? '';
                        saveTerminalNumber = _terminalNumberController.text;
                        _agentAccountController.text = state.supplier?.agentAccount ?? '';
                        saveAgentAccount = _agentAccountController.text;
                        ///
                        _managerNameController.text = state.supplier?.managerName ?? '';
                        _managerPostController.text = state.supplier?.managerPost ?? '';
                        _bookkeeperNameController.text = state.supplier?.bookkeeperName ?? '';
                        _ftpHostController.text = state.supplier?.ftpServer ?? '';
                        _ftpPortController.text = state.supplier?.ftpPort?.toString() ?? '';
                        _ftpLoginController.text = state.supplier?.ftpLogin ?? '';
                        _ftpPasswordController.text = state.supplier?.ftpPassword ?? '';
                      } else if (state is SupplierUpdateSuccess) {
                        context.read<SuppliersBloc>().add(SuppliersUpdateSupplier(state.supplier));
                        if(Navigator.of(context).canPop()) {
                          Navigator.of(context).pop<Supplier>(state.supplier);
                        } else {
                          Navigation.toOrganizations();      
                        }
                        Multiplatform.showMessage(
                          context: context,
                          title: 'Успешно',
                          message: 'Организация отредактирована',
                          type: DialogType.success
                        );
                      } else if (state is SupplierUpdateError) {
                        RequestUtil.catchNetworkError(
                          context: context,
                          obj: state.error
                        );
                          setState(() {
                            isScreenAbsorbed = false;
                          });
                      } else if (state is SupplierUpdateLoading) {
                          setState(() {
                            isScreenAbsorbed = true;
                          });     
                      }
                    },
                    buildWhen: (prev, next) {
                      if (next is SupplierUpdateInitial) return true;
                      if (next is SupplierUpdateInitLoading) return true;
                      if (next is SupplierUpdateInitError) return true;
                      return false;
                    },
                    builder: (context, state) {
                      Widget body = Container();
                      if (state is SupplierUpdateInitError) {
                        body = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: double.maxFinite),
                            const Text('Невозможно просмотреть организацию'),
                            const SizedBox(height: 8),
                            CupertinoButton(
                              onPressed: () => context
                                  .read<SupplierUpdateBloc>()
                                  .add(SupplierUpdateInit()),
                              child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                            )
                          ],
                        );
                      } else if (state is SupplierUpdateInitLoading) {
                        body = const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: double.maxFinite),
                            LoadingIndicator()
                          ],
                        );
                      } else if (state is SupplierUpdateInitial) {
                        body = AbsorbPointer(
                          absorbing: isScreenAbsorbed,
                          child: SingleChildScrollView(
                            child: Center(
                              child: ResponsiveBuilder(
                                builder: (context, sizingInformation) {
                                  if (sizingInformation.isMobile || sizingInformation.isTablet) {
                                    width = sizingInformation.screenSize.width;
                                  }
                                  return Container(
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
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                              child: ConnectionStatusPicker(
                                                value: _supplierUpdate.enabled,
                                                onTap: (value) {
                                                  setState(() {
                                                    _supplierUpdate.enabled = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                              child: AttrTextField(
                                                initialValue: state.supplier?.outSupplierCode,
                                                labelText: 'Код организации (ЕРИП)',
                                                isReadOnly: true,
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                key: _parentFieldKeys[0],
                                                fieldKey: _fieldKeys[0],
                                                focusNode: _focusNodes[0],
                                                controller: _shortNameController,
                                                labelText: 'Краткое наименование',
                                                mandatory: true,
                                                maxLength: 100,
                                                onSaved: (value) {
                                                  if ((_supplier!.shortName ?? '') != value) {
                                                    _supplierUpdate.shortName = value;
                                                  } else {
                                                    _supplierUpdate.shortName = null;
                                                  }
                                                },
                                                onChanged: (_) => setState(() {}),
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child:  Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                initialValue: state.supplier?.unp,
                                                labelText: 'УНП',
                                                isReadOnly: true,
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 12,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                key: _parentFieldKeys[1],
                                                fieldKey: _fieldKeys[1],
                                                focusNode: _focusNodes[1],
                                                controller: _fullNameController,
                                                labelText: 'Полное наименование',
                                                mandatory: true,
                                                maxLength: 255,
                                                onSaved: (value) {
                                                  if ((_supplier!.name ?? '') != value) {
                                                    _supplierUpdate.name = value;
                                                  } else {
                                                    _supplierUpdate.name = null;
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
                                                controller: _addressController,
                                                labelText: 'Юридический адрес',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  if ((_supplier!.address ?? '') != value) {
                                                    _supplierUpdate.address = value;
                                                  } else {
                                                    _supplierUpdate.address = null;
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
                                              child: EmailTextField(
                                                mandatory: _supplierUpdate.usePaymentAccaunt,
                                                key: _parentFieldKeys[2],
                                                fieldKey: _fieldKeys[2],
                                                focusNode: _focusNodes[2],
                                                controller: _emailController,
                                                onSaved: (value) {
                                                  if ((_supplier!.email ?? '') != value) {
                                                    _supplierUpdate.email = value;
                                                  } else {
                                                    _supplierUpdate.email = null;
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
                                                key: _parentFieldKeys[3],
                                                fieldKey: _fieldKeys[3],
                                                focusNode: _focusNodes[3],
                                                controller: _abonentController,
                                                labelText: 'Абонент',
                                                mandatory: true,
                                                maxLength: 8,
                                                onSaved: (value) {
                                                  if ((_supplier!.abonent ?? '') != value) {
                                                    _supplierUpdate.abonent = value;
                                                  } else {
                                                    _supplierUpdate.abonent = null;
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value.length < 8) {
                                                    return 'Введено меньше 8 символов';
                                                  }
                                                  return null;
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
                                                key: _parentFieldKeys[4],
                                                fieldKey: _fieldKeys[4],
                                                focusNode: _focusNodes[4],
                                                controller: _contractController,
                                                labelText: 'Номер договора',
                                                mandatory: true,
                                                maxLength: 50,
                                                onSaved: (value) {
                                                  if ((_supplier!.contract ?? '') != value) {
                                                    _supplierUpdate.contract = value;
                                                  } else {
                                                    _supplierUpdate.contract = null;
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
                                              child: TextFieldDropdownSearch<Bank>(
                                                title: 'Банк',
                                                items: [Bank(id: -1, name: 'Не выбрано', bic: ''),...state.banks ?? []],
                                                itemBuilder: (item) => item.name,
                                                selected: _selectedBank?.id != null? _selectedBank:Bank(id: -1, name: 'Не выбрано', bic: ''),
                                                onTap: (item) {
                                                  _accountController.clear();
                                                  var mask = '';
                                                  if (item.id == -1) {
                                                    _selectedBank = Bank(id: -1, name: 'Не выбрано', bic: '');
                                                  } else {

                                                    final maskHint = 'BY##${item.bic.substring(0, 4)}####################';
                                                    mask = '############################';
                                                    _accountHint = maskHint;
                                                    _selectedBank = item;
                                                  }
                                                  _accountFormatter.updateMask(mask: mask);
                                                  
                                                  setState(() {});
                                                },
                                                onSaved: (value) {
                                                    if (_supplier?.bankId != _selectedBank?.id) {
                                                    _supplierUpdate.bankId = _selectedBank?.id; 
                                                    } else {
                                                      _supplierUpdate.bankId = null;
                                                    }
                                                },
                                                // validator: () {
                                                //   if (_selectedBank == null) {
                                                //     return 'Выберите банк';
                                                //   }
                                                //   if (_selectedBank!.id == -1) {
                                                //     return 'Выберите банк';
                                                //   }
                                                //   return null;
                                                // },
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                controller: _accountController,
                                                formatter: _accountFormatter,
                                                maxLength: 28,
                                                labelText: 'Номер счета',
                                                hint: _accountHint,
                                                isReadOnly: _selectedBank == null,
                                                onSaved: (value) {
                                                  if ((_supplier!.account ?? '') != value) {
                                                    _supplierUpdate.account = value;
                                                  } else {
                                                    _supplierUpdate.account = null;
                                                  }
                                                },
                                                onChanged: (_) => setState(() {}),
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 12,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrLogic(
                                                value: _supplierUpdate.usePaymentAccaunt,
                                                onChanged: (value) {
                                                  setState(() {
                                                    //_onChangeTerminalNumber();
                                                    //_onChangeAgentAccount();
                                                    _supplierUpdate.usePaymentAccaunt = value;
                                                  });
                                                },
                                                text: 'Использование платежного кабинета',
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                controller: _terminalNumberController,
                                                key: _parentFieldKeys[5],
                                                fieldKey: _fieldKeys[5],
                                                focusNode: _focusNodes[5],
                                                maxLength: 16,
                                                labelText: 'Номер терминала',
                                                isReadOnly: !_supplierUpdate.usePaymentAccaunt,
                                                mandatory: _supplierUpdate.usePaymentAccaunt,
                                                onSaved: (value) {
                                                  if((_supplier!.terminalNumber ?? '') != value) {

                                                    if(!_supplierUpdate.usePaymentAccaunt & saveTerminalNumber.isNotEmpty) {
                                                      value = saveTerminalNumber;
                                                    }

                                                    _supplierUpdate.terminalNumber = value;

                                                  } else {
                                                    _supplierUpdate.terminalNumber = null;
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
                                                controller: _agentAccountController,
                                                key: _parentFieldKeys[6],
                                                fieldKey: _fieldKeys[6],
                                                focusNode: _focusNodes[6],
                                                maxLength: 28,
                                                labelText: 'Р/счет по выводу ДС',
                                                isReadOnly: !_supplierUpdate.usePaymentAccaunt,
                                                mandatory: _supplierUpdate.usePaymentAccaunt,
                                                onSaved: (value) {
                                                  if((_supplier!.agentAccount ?? '') != value) {

                                                    if(!_supplierUpdate.usePaymentAccaunt & saveTerminalNumber.isNotEmpty) {
                                                      value = saveAgentAccount;
                                                    }

                                                    _supplierUpdate.agentAccount = value;

                                                  } else {
                                                    _supplierUpdate.agentAccount = null;
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
                                                controller: _managerNameController,
                                                labelText: 'ФИО руководителя',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  if ((_supplier!.managerName ?? '') != value) {
                                                    _supplierUpdate.managerName = value;
                                                  } else {
                                                    _supplierUpdate.managerName = null;
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
                                                controller: _managerPostController,
                                                labelText: 'Должность руководителя',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  if ((_supplier!.managerPost ?? '') != value) {
                                                    _supplierUpdate.managerPost = value;
                                                  } else {
                                                    _supplierUpdate.managerPost = null;
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
                                                controller: _bookkeeperNameController,
                                                labelText: 'ФИО главного бухгалтера',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  if ((_supplier!.bookkeeperName ?? '') != value) {
                                                    _supplierUpdate.bookkeeperName = value;
                                                  } else {
                                                    _supplierUpdate.bookkeeperName = null;
                                                  }
                                                },
                                                onChanged: (_) => setState(() {}),
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 12,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                              child: Text(
                                                'Параметры подключения к FTP',
                                                style: AppStyles.headerTextStyleLess,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                controller: _ftpHostController,
                                                labelText: 'Хост',
                                                maxLength: 15,
                                                onSaved: (value) {
                                                  if ((_supplier!.ftpServer ?? '') != value) {
                                                    _supplierUpdate.ftpServer = value;
                                                  } else {
                                                    _supplierUpdate.ftpServer = null;
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
                                                controller: _ftpPortController,
                                                labelText: 'Порт',
                                                maxLength: 4,
                                                onSaved: (value) {
                                                  if ((_supplier!.ftpPort ?? '') != value) {
                                                    _supplierUpdate.ftpPort = value.toIntOrNull();
                                                  } else {
                                                    _supplierUpdate.ftpPort = null;
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
                                                controller: _ftpLoginController,
                                                labelText: 'Логин',
                                                maxLength: 30,
                                                onSaved: (value) {
                                                  if ((_supplier!.ftpLogin ?? '') != value) {
                                                    _supplierUpdate.ftpLogin = value;
                                                  } else {
                                                    _supplierUpdate.ftpLogin = null;
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
                                                controller: _ftpPasswordController,
                                                labelText: 'Пароль',
                                                maxLength: 30,
                                                onSaved: (value) {
                                                  if ((_supplier!.ftpPassword ?? '') != value) {
                                                    _supplierUpdate.ftpPassword = value;
                                                  } else {
                                                    _supplierUpdate.ftpPassword = null;
                                                  }
                                                },
                                                onChanged: (_) => setState(() {}),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }
                      return body;
                    }
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UndoButton(onTap: () {
                        if(Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Navigation.toOrganizations();
                          }
                      }),
                      const SizedBox(width: 10),
                      SaveSupplierButton(
                        onTap: _onSaveTap,
                        isAvaible: isSaveAvailable
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  // Future<String> getClipboardText() async {
  //   final cdata = await Clipboard.getData(Clipboard.kTextPlain);
  //   final copiedtext = cdata?.text ?? '';
  //   return copiedtext;
  // }

  // void setEmptyClipboardText() {
  //   Clipboard.setData(const ClipboardData(text: ''));
  // }  

  // void _onChangeTerminalNumber() {
  //   if(_terminalNumberController.text.isNotEmpty) {
  //     saveTerminalNumber = _terminalNumberController.text;
  //     _terminalNumberController.text = '';
  //   } else {
  //      _terminalNumberController.text = saveTerminalNumber;
  //   }
  // }

  //   void _onChangeAgentAccount() {
  //   if(_agentAccountController.text.isNotEmpty) {
  //     saveAgentAccount = _agentAccountController.text;
  //     _agentAccountController.text = '';
  //   } else {
  //      _agentAccountController.text = saveAgentAccount;
  //   }
  // }

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      context.read<SupplierUpdateBloc>().add(SupplierUpdateRun(_supplierUpdate));
    }
  }
}