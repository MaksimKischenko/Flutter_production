import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/blocs/service_insert/service_insert_bloc.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/multiplatform.dart';
import 'package:web_cabinet_nkfo/utils/request_util.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class ServiceAddScreen extends StatefulWidget {
  static const pageName = 'Добавить услугу';

  @override
  _ServiceAddScreenState createState() => _ServiceAddScreenState();
}

class _ServiceAddScreenState extends State<ServiceAddScreen> {

  DateTime? _dateStart;
  DateTime? _dateEnd;

  PersonalAccountValueType _selectedAccountType= PersonalAccountValueType.none;
  PersonalAccountStornoMode _selectedAccountStornoMode = PersonalAccountStornoMode.beforePayment;

  final _formKey = GlobalKey<FormState>();
  final _focusNodes = List.generate(4, (_) => FocusNode());
  final _parentFieldKeys = List.generate(4, (index) => Key('field $index'));
  final _fieldKeys = List.generate(4, (_) => GlobalKey<FormFieldState>());

  Bank? _selectedBank;
  ServiceScenario? _selectedScenario;

  final _account = SupplierAccountInsertRequest();

  final _accountController = TextEditingController();
  final _accountFormatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[a-zA-Z0-9]') });
  final _formatterInts = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]')});
  final _formatterDoubles = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[.0-9]')});
  String? _accountHint;
  String copiedText = '';
  double width = 1000;


  @override
  void initState() {
    super.initState();
    _focusNodes.forEachIndexed((node, index) {
      node.addListener(() {
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

    _formatterInts.updateMask(mask: '#####################');
   _formatterDoubles.updateMask(mask: '#####################');
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    _accountController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) => BlocListener<ServiceInsertBloc, ServiceInsertState>(
    listener: (context, state) {
      if (state is ServiceInsertError) {
        RequestUtil.catchNetworkError(context: context, obj: state.error);
      } else if (state is ServiceInsertSuccess) {
          if(Navigator.of(context).canPop()) {
            Navigator.of(context).pop<SupplierAccount>(state.account);      
          } else {
            Navigation.toOrganizations();       
          }
        Multiplatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Услуга id:${state.account?.id} добавлена',
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
              title: 'Добавление услуги',
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<ServiceInsertBloc, ServiceInsertState>(
                buildWhen: (prev, next) {
                  if (next is ServiceInsertInitial) return true;
                  if (next is ServiceInsertInitLoading) return true;
                  if (next is ServiceInsertInitError) return true;
                  return false;
                },
                builder: (context, state) {
                  Widget body = Container();
                  if (state is ServiceInsertInitError) {
                    body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const Text('Невозможно начать процедуру добавления'),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          onPressed: () => context
                              .read<ServiceInsertBloc>()
                              .add(ServiceInsertInit()),
                          child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                        )
                      ],
                    );
                  } else if (state is ServiceInsertInitLoading) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  } else if (state is ServiceInsertInitial) {
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
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          key: _parentFieldKeys[0],
                                          fieldKey: _fieldKeys[0],
                                          focusNode: _focusNodes[0],
                                          labelText: 'Код услуги (ЕРИП)',
                                          mandatory: true,
                                          maxLength: 20,
                                          onSaved: (value) {
                                            _account.paymentSystemServiceCode = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          labelText: 'Краткое наименование',
                                          maxLength: 100,
                                          onSaved: (value) {
                                            _account.serviceShortName = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    const DivPadding(),                                     
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16, bottom: 20),
                                        child: ConnectionStatusPicker(
                                          value: _account.enabled,
                                          onTap: (value) {
                                            setState(() {
                                              _account.enabled = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 8,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          key: _parentFieldKeys[2],
                                          fieldKey: _fieldKeys[2],
                                          focusNode: _focusNodes[2],
                                          labelText: 'Полное наименование',
                                          mandatory: true,
                                          maxLength: 255,
                                          onSaved: (value) {
                                            _account.serviceName = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    const DivPadding(),                                        
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: WebDatePicker(
                                          labelText: 'Дата подключения услуги',
                                          mandatory: true,
                                          onChange: (value) => _dateStart = value,
                                          validator: () {
                                            if (_dateStart == null) {
                                              return 'Выберите дату';
                                            }
                                            if (_dateEnd == null) {
                                              return null;
                                            }
                                            if (_dateStart!.isAfter(_dateEnd!)) {
                                              return 'Дата начала должна быть меньше даты окончания';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: WebDatePicker(
                                          labelText: 'Дата прекращения доступа',
                                          mandatory: true,
                                          onChange: (value) => _dateEnd = value,
                                          validator: () {
                                            if (_dateEnd == null) {
                                              return 'Выберите дату';
                                            }
                                            if (_dateStart == null) {
                                              return null;
                                            }
                                            if (_dateEnd!.isBefore(_dateStart!)) {
                                              return 'Дата окончания должна быть позже даты начала';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    const DivPadding(),   
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                        child: TextFieldDropdownSearch<Bank>(
                                          title: 'Банк *',
                                          items: [Bank(id: -1, name: 'Не выбрано', bic: ''),...state.banks],
                                          itemBuilder: (item) => item.name,
                                          selected: _selectedBank,
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
                                            _account.bankId = value?.id;
                                          },
                                          validator: () {
                                            if (_selectedBank == null) {
                                              return 'Выберите банк';
                                            }
                                            if (_selectedBank!.id == -1) {
                                              return 'Выберите банк';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                        child: AttrTextField(
                                          key: _parentFieldKeys[3],
                                          fieldKey: _fieldKeys[3],
                                          focusNode: _focusNodes[3],
                                          controller: _accountController,
                                          formatter: _accountFormatter,
                                          maxLength: 28,
                                          labelText: 'Номер счета',
                                          mandatory: true,
                                          hint: _accountHint,
                                          isReadOnly: _selectedBank == null,
                                          onSaved: (value) {
                                            _account.account = value.replaceAll(' ', '');
                                          },
                                          validator: (value) {
                                            final acc = value.replaceAll(' ', '');
                                            if (acc.length != 28) {
                                              return 'Заполните поле';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16, bottom: 20),
                                        child: Text(
                                          'Параметры платежа',
                                          style: AppStyles.headerTextStyleLess,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 2,
                                      colM: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          formatter: _formatterDoubles, //NumberTextInputFormatter(decimalRange: 2),
                                          labelText: 'Минимум',
                                          maxLength: 128,
                                          onSaved: (value) {
                                            _account.payMin = value.toDoubleOrNull();
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) return null;
                                            final payMin = value.toDoubleOrNull();
                                            if (payMin == null) {
                                              return 'Некорректное значение';
                                            } 
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),                                
                                    Div(
                                      colL: 2,
                                      colM: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          formatter: _formatterDoubles, //NumberTextInputFormatter(decimalRange: 2),
                                          labelText: 'Максимум',
                                          maxLength: 128,
                                          onSaved: (value) {
                                            _account.payMax = value.toDoubleOrNull();
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) return null;
                                            final payMax = value.toDoubleOrNull();
                                            if (payMax == null) {
                                              return 'Некорректное значение';
                                            } 
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Column(
                                          children: [
                                            AttrLogic(
                                              value: _account.advanceEnabled,
                                              onChanged: (value) => setState(() => _account.advanceEnabled = value),
                                              text: 'Разрешать изменять сумму требования при оплате',
                                              padding: EdgeInsets.zero,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const DivPadding(),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: TextFieldDropdownSearch<ServiceScenario>(
                                          title: 'Сценарий проведения платежа *',
                                          showSearchBox: false,
                                          maxHeight: 150,
                                          items: [ServiceScenario(id: -1, name: 'Не выбрано'),...state.scenarios],
                                          itemBuilder: (item) => item.name,
                                          selected: _selectedScenario,
                                          onTap: (item) {
                                            if (item.id == -1) {
                                              _selectedScenario = null;
                                            } else {
                                              _selectedScenario = item;
                                            }
                                            setState(() {});
                                          },
                                          onSaved: (value) {
                                            _account.scenarioId = value?.id;
                                          },
                                          validator: () {
                                            if (_selectedScenario == null) {
                                              return 'Выберите сценарий';
                                            }
                                            if (_selectedScenario!.id == -1) {
                                              return 'Выберите сценарий';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    const DivPadding(),
                                    Div(
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                        child: Text(
                                          'Лицевой счет',
                                          style: AppStyles.headerTextStyleLess,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          labelText: 'Наименование',
                                          maxLength: 128,
                                          onSaved: (value) {
                                            _account.attrName = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: TextFieldDropdownSearch<PersonalAccountValueType>(
                                          title: 'Тип *',
                                          showSearchBox: false,
                                          maxHeight: 290,
                                          items: PersonalAccountValueType.values,
                                          itemBuilder: (item) => item.name,
                                          selected: _selectedAccountType,
                                          onTap: (item) => setState(() => _selectedAccountType = item),
                                          onSaved: (_) {
                                            _account.valueType = _selectedAccountType.inJson;
                                          },
                                          validator: () {
                                            if (_selectedAccountType == PersonalAccountValueType.none) {
                                              return 'Необходимо выбрать тип';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: SizedBox()
                                      ),
                                    ),                                      
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          keyboardType: const TextInputType.numberWithOptions(),
                                          formatter: _formatterInts, //NumberTextInputFormatter(decimalRange: 0),
                                          labelText: 'Минимальная длина',
                                          maxLength: 128,
                                          onSaved: (value) {
                                            _account.minLength = value.toIntOrNull();
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) return null;
                                            final minLength = value.toDoubleOrNull();
                                            if (minLength == null) {
                                              return 'Некорректное значение';
                                            } 
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          keyboardType: const TextInputType.numberWithOptions(),
                                          formatter: _formatterInts, //NumberTextInputFormatter(decimalRange: 0),
                                          labelText: 'Максимальная длина',
                                          maxLength: 128,
                                          onSaved: (value) {
                                            _account.maxLength = value.toIntOrNull();
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) return null;
                                            final maxLength = value.toDoubleOrNull();
                                            if (maxLength == null) {
                                              return 'Некорректное значение';
                                            } 
                                            return null;
                                          },                                         
                                        ),
                                      ),
                                    ),
                                   Div(
                                    colL: 12,
                                    colM: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Text(
                                        'Дополнительные параметры платежа',
                                        style: AppStyles.headerTextStyleLess,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                   ),
                                   Div(
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: AttrLogic(
                                          value:  _selectedScenario?.id == 1 || _selectedScenario?.id == null? _account.nameGroup : _account.nameGroup = true,
                                          editable: _selectedScenario?.id == 1,
                                          onChanged: (value) => setState(() {
                                            _account.nameGroup = value;                                      
                                          }),
                                          text: '',
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),  
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: ReadOnlyTextField(
                                          labelText: 'Фамилия',
                                          isChangeStatus: _account.nameGroup,
                                        ),
                                      ),
                                    ),  
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: ReadOnlyTextField(
                                          labelText: 'Имя',
                                          isChangeStatus: _account.nameGroup
                                        ),
                                      ),
                                    ),  
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child:  Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: ReadOnlyTextField(
                                          labelText: 'Отчество',
                                          isChangeStatus: _account.nameGroup
                                        ),
                                      ),
                                    ), 
                                    Div(
                                      colL: 12,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: AttrLogic(
                                          value: _selectedScenario?.id == 1 || _selectedScenario?.id == null? _account.adressGroup : _account.adressGroup = true,
                                          editable: _selectedScenario?.id == 1,
                                          onChanged: (value) => setState(() {   

                                            _account.adressGroup = value;
                                            
                                          }),
                                          text: '',
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ), 
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: ReadOnlyTextField(
                                          labelText: 'Нас. пункт',
                                          isChangeStatus: _account.adressGroup
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: ReadOnlyTextField(
                                          labelText: 'Улица',
                                          isChangeStatus: _account.adressGroup
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          children:  [
                                            SizedBox(
                                              width: 90,
                                              child: ReadOnlyTextField(                                               
                                                labelText: 'Дом',
                                                isChangeStatus: _account.adressGroup
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 94,
                                              child: ReadOnlyTextField(
                                                labelText: 'Корпус',
                                                isChangeStatus: _account.adressGroup
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 100,
                                              child: ReadOnlyTextField(
                                                labelText: 'Квартира',
                                                isChangeStatus: _account.adressGroup
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),                                                                                                                                                                                                                                                                                      
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                        child: TextFieldDropdownSearch<bool>(
                                          title: 'Признак генерации номера лицевого счета',
                                          showSearchBox: false,
                                          maxHeight: 100,
                                          items: const [false, true],
                                          itemBuilder: (item) => item ? 'Номер лицевого счета генерируется' : 'Номер лицевого счета не генерируется',
                                          selected: _account.autogenPan,
                                          onTap: (item) => setState(() => _account.autogenPan = item),
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 4,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                        child: TextFieldDropdownSearch<PersonalAccountStornoMode>(
                                          title: 'Признак сторнирования операций по услуге',
                                          showSearchBox: false,
                                          maxHeight: 150,
                                          items: PersonalAccountStornoMode.values,
                                          itemBuilder: (item) => item.name,
                                          selected: _selectedAccountStornoMode,
                                          onTap: (item) => setState(() => _selectedAccountStornoMode = item),
                                          onSaved: (_) {
                                            _account.stornoMode = _selectedAccountStornoMode.inJson;
                                          }
                                        ),
                                      ),
                                    )
                                  ]
                                )
                              )
                            )
                          );
                        }
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
                  SaveServiceButton(
                    onTap: _onSaveTap,
                  )
                ],
              ),
            ),
          ],
        ),
      )
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

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _account..dateStart = _dateStart
      ..dateEnd = _dateEnd;
      context.read<ServiceInsertBloc>().add(ServiceInsertRun(_account));
    }
  }
}