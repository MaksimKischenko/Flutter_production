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
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/multiplatform.dart';
import 'package:web_cabinet_nkfo/utils/request_util.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class OrganizationAddScreen extends StatefulWidget {
  static const pageName = 'Добавление новой организации';

  @override
  _OrganizationAddScreenState createState() => _OrganizationAddScreenState();
}

class _OrganizationAddScreenState extends State<OrganizationAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _focusNodes = List.generate(10, (_) => FocusNode());
  final _parentFieldKeys = List.generate(10, (index) => Key('field $index'));
  final _fieldKeys = List.generate(10, (_) => GlobalKey<FormFieldState>());

  Bank? _selectedBank;

  final _supplier = SupplierInsertRequest();

  final _accountController = TextEditingController();
  final _terminalNumberController = TextEditingController();
  final _agentAccountController = TextEditingController();
  final _accountFormatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[a-zA-Z0-9]') });

  String? _accountHint;
  String saveTerminalNumber = '';
  String saveAgentAccount = '';
  bool isScreenAbsorbed = false; 
  double width = 800;

  @override
  void initState() {
    super.initState();
    _focusNodes.forEachIndexed((node, index)  {
      node.addListener(() async {
        if (!_focusNodes[index].hasFocus) {
          _fieldKeys[index].currentState?.validate();
        }
      });
    });
    // Для ввода только больших букв 
    _accountController.addListener(() {
      if(_accountController.text.contains(RegExp('[a-z]'))) {
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
    _accountController.dispose();
    _terminalNumberController.dispose();
    _agentAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<SupplierInsertBloc, SupplierInsertState>(
        listener: (context, state) {
          if (state is SupplierInsertError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
             setState(() {
              isScreenAbsorbed = false;
            });  
          } else if (state is SupplierInsertSuccess) {
              if(Navigator.of(context).canPop()) {
                Navigator.of(context).pop<Supplier>(state.supplier);
              } else {
                Navigation.toOrganizations();   
              }
            Multiplatform.showMessage(
              context: context,
              title: 'Успешно',
              message: 'Организация id:${state.supplier?.id} добавлена',
              type: DialogType.success
            );
          } else if (state is SupplierInsertLoading) {
            setState(() {
              isScreenAbsorbed = true;
            });     
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonAppBar(
                  title: 'Добавление организации',
                ),
                const Divider(),
                Expanded(
                  child: BlocBuilder<SupplierInsertBloc, SupplierInsertState>(
                    buildWhen: (prev, next) {
                      if (next is SupplierInsertInitial) return true;
                      if (next is SupplierInsertInitLoading) return true;
                      if (next is SupplierInsertInitError) return true;
                      return false;
                    },
                    builder: (context, state) {
                      Widget body = Container();
                      if (state is SupplierInsertInitError) {
                        body = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: double.maxFinite),
                            const Text('Невозможно начать процедуру добавления'),
                            const SizedBox(height: 8),
                            CupertinoButton(
                              onPressed: () => context
                                  .read<SupplierInsertBloc>()
                                  .add(SupplierInsertInit()),
                              child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                            )
                          ],
                        );
                      } else if (state is SupplierInsertInitLoading) {
                        body = const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: double.maxFinite),
                            LoadingIndicator()
                          ],
                        );
                      } else if (state is SupplierInsertInitial) {
                        body = AbsorbPointer(
                          absorbing: isScreenAbsorbed,
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
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: ConnectionStatusPicker(
                                                value: _supplier.enabled,
                                                onTap: (value) {
                                                  setState(() {
                                                    _supplier.enabled = value;
                                                  });
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
                                                key: _parentFieldKeys[0],
                                                fieldKey: _fieldKeys[0],
                                                focusNode: _focusNodes[0],
                                                labelText: 'Код организации (ЕРИП)',
                                                mandatory: true,
                                                maxLength: 20,
                                                onSaved: (value) {
                                                  _supplier.outSupplierCode = value;
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
                                                key: _parentFieldKeys[1],
                                                fieldKey: _fieldKeys[1],
                                                focusNode: _focusNodes[1],
                                                labelText: 'Краткое наименование',
                                                mandatory: true,
                                                maxLength: 100,
                                                onSaved: (value) {
                                                  _supplier.shortName = value;
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
                                                key: _parentFieldKeys[2],
                                                fieldKey: _fieldKeys[2],
                                                focusNode: _focusNodes[2],
                                                labelText: 'УНП',
                                                mandatory: true,
                                                maxLength: 11,
                                                onSaved: (value) {
                                                  _supplier.unp = value;
                                                },
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 12,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                key: _parentFieldKeys[3],
                                                fieldKey: _fieldKeys[3],
                                                focusNode: _focusNodes[3],
                                                labelText: 'Полное наименование',
                                                mandatory: true,
                                                maxLength: 255,
                                                onSaved: (value) {
                                                  _supplier.name = value;
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
                                                labelText: 'Юридический адрес',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  _supplier.address = value;
                                                },
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: EmailTextField(
                                                mandatory: _supplier.usePaymentAccaunt,
                                                key: _parentFieldKeys[4],
                                                fieldKey: _fieldKeys[4],
                                                focusNode: _focusNodes[4],
                                                onSaved: (value) {
                                                  _supplier.email = value;
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
                                                key: _parentFieldKeys[5],
                                                fieldKey: _fieldKeys[5],
                                                focusNode: _focusNodes[5],
                                                labelText: 'Абонент',
                                                mandatory: true,
                                                maxLength: 8,
                                                onSaved: (value) {
                                                  _supplier.abonent = value;
                                                },
                                                validator: (value) {
                                                  if (value.length < 8) {
                                                    return 'Введено меньше 8 символов';
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
                                              child: AttrTextField(
                                                key: _parentFieldKeys[6],
                                                fieldKey: _fieldKeys[6],
                                                focusNode: _focusNodes[6],
                                                labelText: 'Номер договора',
                                                mandatory: true,
                                                maxLength: 50,
                                                onSaved: (value) {
                                                  _supplier.contract = value;
                                                },
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
                                                items: [Bank(id: -1, name: 'Не выбрано', bic: ''),...state.banks],
                                                itemBuilder: (item) => item.name,
                                                selected: _selectedBank ?? Bank(id: -1, name: 'Не выбрано', bic: ''),
                                                onTap: (item) {
                                                  _accountController.clear();
                                                  var mask = '';
                                                  if (item.id == -1) {
                                                    _selectedBank = null;
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
                                                   if(_selectedBank != null) {
                                                    _supplier.bankId = value?.id;
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
                                                  _supplier.account = value.replaceAll(' ', '');
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
                                                value: _supplier.usePaymentAccaunt,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _onChangeTerminalNumber();
                                                    _onChangeAgentAccount();
                                                    _supplier.usePaymentAccaunt = value;
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
                                                key: _parentFieldKeys[8],
                                                fieldKey: _fieldKeys[8],
                                                focusNode: _focusNodes[8],
                                                maxLength: 16,
                                                labelText: 'Номер терминала',
                                                isReadOnly: !_supplier.usePaymentAccaunt,
                                                mandatory: _supplier.usePaymentAccaunt,
                                                onSaved: (value) {

                                                  _supplier.terminalNumber = value;
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
                                                controller: _agentAccountController,
                                                key: _parentFieldKeys[9],
                                                fieldKey: _fieldKeys[9],
                                                focusNode: _focusNodes[9],
                                                maxLength: 28,
                                                labelText: 'Р/счет по выводу ДС',
                                                isReadOnly: !_supplier.usePaymentAccaunt,
                                                mandatory: _supplier.usePaymentAccaunt,
                                                onSaved: (value) {                                                 
                                                  _supplier.agentAccount = value;
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
                                                labelText: 'ФИО руководителя',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  _supplier.managerName = value;
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
                                                labelText: 'Должность руководителя',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  _supplier.managerPost = value;
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
                                                labelText: 'ФИО главного бухгалтера',
                                                maxLength: 128,
                                                onSaved: (value) {
                                                  _supplier.bookkeeperName = value;
                                                },
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
                                                labelText: 'Хост',
                                                maxLength: 15,
                                                onSaved: (value) {
                                                  _supplier.ftpServer = value;
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
                                                labelText: 'Порт',
                                                maxLength: 4,
                                                onSaved: (value) {
                                                  _supplier.ftpPort =
                                                      value.toIntOrNull();
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
                                                labelText: 'Логин',
                                                maxLength: 30,
                                                onSaved: (value) {
                                                  _supplier.ftpLogin = value;
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
                                                labelText: 'Пароль',
                                                maxLength: 30,
                                                onSaved: (value) {
                                                  _supplier.ftpPassword = value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                      UndoButton(onTap: () {
                        if(Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Navigation.toOrganizations();
                          }
                      }),
                      const SizedBox(width: 10),
                      AddSupplierButton(
                        onTap: _onSaveTap,
                      )
                    ],
                  ),
                ),
              ],
            ),
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
  
  void _onChangeTerminalNumber() {
    if(_terminalNumberController.text.isNotEmpty) {
      saveTerminalNumber = _terminalNumberController.text;
      _terminalNumberController.text = '';
    } else {
       _terminalNumberController.text = saveTerminalNumber;
    }
  }

  void _onChangeAgentAccount() {
    if(_agentAccountController.text.isNotEmpty) {
      saveAgentAccount = _agentAccountController.text;
      _agentAccountController.text = '';
    } else {
       _agentAccountController.text = saveAgentAccount;
    }
  }

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<SupplierInsertBloc>().add(SupplierInsertRun(_supplier));
    } 
  }
}
