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
import 'package:web_cabinet_nkfo/utils/date_helper.dart';
import 'package:web_cabinet_nkfo/utils/multiplatform.dart';
import 'package:web_cabinet_nkfo/utils/request_util.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ServiceEditScreen extends StatefulWidget {
  static const pageName = 'Услуга. Редактирование';

  @override
  _ServiceEditScreenState createState() => _ServiceEditScreenState();
}

class _ServiceEditScreenState extends State<ServiceEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _focusNodes = List.generate(1, (_) => FocusNode());
  final _parentFieldKeys = List.generate(1, (index) => Key('field $index'));
  final _fieldKeys = List.generate(1, (_) => GlobalKey<FormFieldState>());

  Bank? _selectedBank;
  ServiceScenario? _selectedScenario;
  DateTime? _dateEnd;
  PersonalAccountValueType _selectedAccountType = PersonalAccountValueType.none;
  bool? _autogenPan;
  PersonalAccountStornoMode _selectedAccountStornoMode = PersonalAccountStornoMode.beforePayment;

  final _shortNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _accountController = TextEditingController();
  final _payMinController = TextEditingController();
  final _payMaxController = TextEditingController();
  final _attrNameController = TextEditingController();
  final _minLengthController = TextEditingController();
  final _maxLengthController = TextEditingController();

  final _accountFormatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[a-zA-Z0-9]') });
  final _formatterInts = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]')});
  final _formatterDoubles = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[.0-9]')});
  String? _accountHint;
  String copiedText = '';
  double width = 1000;

  SupplierAccount? _service;
  final _serviceUpdate = SupplierAccountUpdateRequest();

  bool get isSaveAvailable {
    if (_service == null) return false;
    return _service!.enabled != _serviceUpdate.enabled
    || _service!.stornoModeEnum !=_selectedAccountStornoMode
    || _service!.valueTypeEnum != _selectedAccountType
    || _service!.autogenPan !=_serviceUpdate.autogenPan
    || _service!.advanceEnabled != _serviceUpdate.advanceEnabled
    || _service!.claimOnly != _serviceUpdate.claimOnly
    || _service!.nameGroup != _serviceUpdate.nameGroup
    || _service!.adressGroup != _serviceUpdate.adressGroup
    || _service?.scenarioId != _selectedScenario?.id
    || (_service!.serviceShortName ?? '') != _shortNameController.text
    || (_service!.serviceName ?? '') != _nameController.text
    || (_service!.dateEnd) != _dateEnd
    || (_service!.account ?? '') != _accountController.text
    || (_service!.payMin ?? '') != _payMinController.text
    || (_service!.payMax ?? '') != _payMaxController.text
    || (_service!.attrName ?? '') != _attrNameController.text
    || (_service!.minLength ?? '') != _minLengthController.text
    || (_service!.maxLength ?? '') != _maxLengthController.text;
  }


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
    _shortNameController.dispose();
    _nameController.dispose();
    _dateEndController.dispose();
    _accountController.dispose();
    _payMinController.dispose();
    _payMaxController.dispose();
    _attrNameController.dispose();
    _minLengthController.dispose();
    _maxLengthController.dispose();
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
                BlocBuilder<ServiceUpdateBloc, ServiceUpdateState>(
                  buildWhen: (_, next) => next is ServiceUpdateInitial,
                  builder: (context, state) {
                    String? serviceName;
                    Color? statusColor;
                    String? statusName;
                    List<Widget>? actions;
                    if (state is ServiceUpdateInitial) {
                      serviceName = state.service.serviceName;
                      statusColor = state.service.statusColor;
                      statusName = state.service.statusText;
                    }
                    return CommonAppBar(
                      title: 'Редактирование услуги',
                      organizationName: serviceName,
                      statusColor: statusColor,
                      statusName: statusName,
                      actions: actions,
                    );
                  },
                ),
                const Divider(),
                Expanded(
                  child: BlocConsumer<ServiceUpdateBloc, ServiceUpdateState>(
                    listener: (context, state) {
                      if (state is ServiceUpdateInitial) {
                        _service = state.service;

                        _serviceUpdate
                          ..enabled = state.service.enabled
                          ..advanceEnabled = state.service.advanceEnabled
                          ..claimOnly = state.service.claimOnly
                          ..nameGroup = state.service.nameGroup
                          ..adressGroup = state.service.adressGroup;
                        _selectedBank = state.banks.firstOrNullWhere((e) => e.id == state.service.bankId);
                        _selectedScenario = state.scenarios.firstOrNullWhere((e) => e.id == state.service.scenarioId);
                        _selectedAccountType = state.service.valueTypeEnum;
                        _selectedAccountStornoMode = state.service.stornoModeEnum;
                        _autogenPan = state.service.autogenPan;
                        if (_selectedBank != null) {
                          //_accountFormatter.updateMask(mask: 'BY##${_selectedBank!.bic.substring(0, 4)}####################');
                          _accountController.text = _accountFormatter.maskText(state.service.account ?? '');
                        }
                        _dateEnd = state.service.dateEnd;

                        _shortNameController.text = state.service.serviceShortName ?? '';
                        _nameController.text = state.service.serviceName ?? '';
                        _dateEndController.text = state.service.dateEnd!.toStringFormatted();
                        // Если база отвечает 0 или -1 и поэтому убираем это из поля зрения фронта
                        _payMinController.text = (state.service.payMin?.toString() ?? '') == '0'? '' : state.service.payMin?.toString() ?? '';
                        _payMaxController.text = (state.service.payMax?.toString() ?? '') == '-1'? '' : state.service.payMax?.toString() ?? '';
                        _attrNameController.text = state.service.attrName ?? '';
                        _minLengthController.text = (state.service.minLength?.toString() ?? '') == '0'? '' : state.service.minLength?.toString() ?? '';
                        _maxLengthController.text = (state.service.maxLength?.toString() ?? '') == '-1'? '' : state.service.maxLength?.toString() ?? '';
                      } else if (state is ServiceUpdateSuccess) {
                        if(Navigator.of(context).canPop()) {
                          Navigator.of(context).pop<SupplierAccount>(state.service);
                        } else {
                          Navigation.toOrganizations();
                        }
                        Multiplatform.showMessage(
                          context: context,
                          title: 'Успешно',
                          message: 'Услуга отредактирована',
                          type: DialogType.success
                        );
                      } else if (state is ServiceUpdateError) {
                        RequestUtil.catchNetworkError(
                          context: context,
                          obj: state.error
                        );
                      }
                    },
                    buildWhen: (prev, next) {
                      if (next is ServiceUpdateInitial) return true;
                      if (next is ServiceUpdateInitLoading) return true;
                      if (next is ServiceUpdateInitError) return true;
                      return false;
                    },
                    builder: (context, state) {
                      Widget body = Container();
                      if (state is ServiceUpdateInitError) {
                        body = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: double.maxFinite),
                            const Text('Невозможно просмотреть услугу'),
                            const SizedBox(height: 8),
                            CupertinoButton(
                              onPressed: () => context
                                  .read<ServiceUpdateBloc>()
                                  .add(ServiceUpdateInit()),
                              child: const Text('Попробовать снова'),
                            )
                          ],
                        );
                      } else if (state is ServiceUpdateInitLoading) {
                        body = const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: double.maxFinite),
                            LoadingIndicator()
                          ],
                        );
                      } else if (state is ServiceUpdateInitial) {
                        body = SingleChildScrollView(
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
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: AttrTextField(
                                              initialValue: state.service.paymentSystemServiceCode ?? '',
                                              labelText: 'Код услуги (ЕРИП)',
                                              isReadOnly: true,
                                            ),
                                          ),
                                        ),
                                        Div(
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: AttrTextField(
                                              initialValue: state.service.id.toString(),
                                              labelText: 'Номер услуги организации',
                                              isReadOnly: true,
                                            ),
                                          ),
                                        ),
                                        const DivPadding(),    
                                        Div(
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                            child: AttrTextField(
                                              controller: _shortNameController,
                                              labelText: 'Краткое наименование',
                                              maxLength: 100,
                                              onSaved: (value) {
                                                if ((_service!.serviceShortName ?? '') != value) {
                                                  _serviceUpdate.serviceShortName = value;
                                                } else {
                                                  _serviceUpdate.serviceShortName = null;
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
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                            child: ConnectionStatusPicker(
                                              value: _serviceUpdate.enabled ?? false,
                                              onTap: (value) {
                                                setState(() {
                                                  _serviceUpdate.enabled = value;
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
                                              key: _parentFieldKeys[0],
                                              fieldKey: _fieldKeys[0],
                                              focusNode: _focusNodes[0],
                                              controller: _nameController,
                                              labelText: 'Полное наименование',
                                              mandatory: true,
                                              maxLength: 255,
                                              onSaved: (value) {
                                                if ((_service!.serviceName ?? '') != value) {
                                                  _serviceUpdate.serviceName = value;
                                                } else {
                                                  _serviceUpdate.serviceName = null;
                                                }
                                              },
                                              onChanged: (_) => setState(() {}),
                                            ),
                                          ),
                                        ),
                                        const DivPadding(),
                                        Div(
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 16, bottom: 20),
                                            child: WebDatePicker(
                                              initialValue: state.service.dateStart!.toStringFormatted(),
                                              labelText: 'Дата подключения услуги',
                                              editable: false,
                                              onChange: (value) {},
                                            ),
                                          ),
                                        ),
                                        Div(
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: WebDatePicker(
                                              initialValue: state.service.dateEnd!.toStringFormatted(),
                                              labelText: 'Дата прекращения доступа',
                                              mandatory: true,
                                              onChange: (value) {
                                                setState(() {
                                                  _dateEnd = value;
                                                });
                                              },
                                              validator: () {
                                                if (_dateEnd == null) {
                                                  return 'Выберите дату';
                                                }
                                                final _dateStart = state.service.dateStart;
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
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                                if (_service!.bankId != _selectedBank?.id) {
                                                  _serviceUpdate.bankId = _selectedBank?.id;
                                                } else {
                                                  _serviceUpdate.bankId = null;
                                                }
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
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: AttrTextField(
                                              controller: _accountController,
                                              formatter:_accountFormatter,
                                              labelText: 'Номер счета *',
                                              hint: _accountHint,
                                              maxLength: 28,
                                              isReadOnly: _selectedBank == null,
                                              onSaved: (v) {
                                                final value = v.replaceAll(' ', '');
                                                if ((_service!.account ?? '') != value) {
                                                  _serviceUpdate.account = value;
                                                } else {
                                                  _serviceUpdate.account = null;
                                                }
                                              },
                                              validator: (value) {
                                                final acc = value.replaceAll(' ', '');
                                                if (acc.length != 28) {
                                                  return 'Заполните поле';
                                                }
                                                return null;
                                              },
                                              onChanged: (_) => setState(() {}),
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
                                              formatter: _formatterDoubles,
                                              controller: _payMinController,
                                              labelText: 'Минимум',
                                              maxLength: 128,
                                              onSaved: (value) {
                                                if ((_service!.payMin ?? '') != value) {
                                                  _serviceUpdate.payMin = value.toDoubleOrNull() ?? 0;
                                                } else {
                                                  _serviceUpdate.payMin = 0;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) return null;
                                                final payMin = value.toDoubleOrNull();
                                                if (payMin == null) {
                                                  return 'Некорректное значение';
                                                } 
                                                return null;
                                              },
                                              onChanged: (_) => setState(() {}),
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
                                              formatter: _formatterDoubles,
                                              controller: _payMaxController,
                                              labelText: 'Максимум',
                                              maxLength: 128,
                                              onSaved: (value) {
                                                if ((_service!.payMax ?? '') != value) {
                                                  _serviceUpdate.payMax = value.toDoubleOrNull() ?? -1;
                                                } else {
                                                  _serviceUpdate.payMax = -1;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) return null;
                                                final payMax = value.toDoubleOrNull();
                                                if (payMax == null) {
                                                  return 'Некорректное значение';
                                                } 
                                                return null;
                                              },
                                              onChanged: (_) => setState(() {}),
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
                                                  value: _serviceUpdate.advanceEnabled ?? false,
                                                  onChanged: (value) => setState(() => _serviceUpdate.advanceEnabled = value),
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
                                            padding: const EdgeInsets.only(left: 16, bottom: 20),
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
                                                if (_service!.scenarioId != value?.id) {
                                                  _serviceUpdate.scenarioId = value?.id;
                                                } else {
                                                  _serviceUpdate.scenarioId = null;
                                                }
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
                                        Div(
                                          colL: 12,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 16, bottom: 20),
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
                                              controller: _attrNameController,
                                              labelText: 'Наименование',
                                              maxLength: 128,
                                              onSaved: (value) {
                                                if ((_service!.attrName ?? '') != value) {
                                                  _serviceUpdate.attrName = value;
                                                } else {
                                                  _serviceUpdate.attrName = null;
                                                }
                                              },
                                              onChanged: (_) => setState(() {}),
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
                                                if (_service!.valueTypeEnum != _selectedAccountType) {
                                                  _serviceUpdate.valueType = _selectedAccountType.inJson;
                                                } else {
                                                  _serviceUpdate.valueType = null;
                                                }
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
                                        const DivPadding(),
                                        Div(
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: AttrTextField(
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              formatter: _formatterInts, //NumberTextInputFormatter(decimalRange: 1),
                                              controller: _minLengthController,
                                              labelText: 'Минимальная длина',
                                              maxLength: 128,
                                              onSaved: (value) {
                                                if ((_service!.minLength ?? '') != value) {
                                                  _serviceUpdate.minLength = value.toIntOrNull() ?? 0;
                                                } else {
                                                  _serviceUpdate.minLength = 0;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) return null;
                                                final minLength = value.toIntOrNull();
                                                if (minLength == null) {
                                                  return 'Некорректное значение';
                                                } 
                                                return null;
                                              },
                                              onChanged: (_) => setState(() {}),
                                            ),
                                          ),
                                        ),
                                        Div(
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: AttrTextField(
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              formatter: _formatterInts, //NumberTextInputFormatter(decimalRange: 1),
                                              controller: _maxLengthController,
                                              labelText: 'Максимальная длина',
                                              maxLength: 128,
                                              onSaved: (value) {
                                                if ((_service!.maxLength ?? '') != value) {
                                                  _serviceUpdate.maxLength = value.toIntOrNull() ?? -1;
                                                } else {
                                                  _serviceUpdate.maxLength = -1;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) return null;
                                                final maxLength = value.toIntOrNull();
                                                if (maxLength == null) {
                                                  return 'Некорректное значение';
                                                } 
                                                return null;
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
                                              value:  _selectedScenario?.id == 1 || _selectedScenario?.id == null? _serviceUpdate.nameGroup : _serviceUpdate.nameGroup = true,
                                              editable: _selectedScenario?.id == 1,
                                              onChanged: (value) => setState(() {
                                                _serviceUpdate.nameGroup = value;
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
                                              isChangeStatus: _serviceUpdate.nameGroup,
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
                                              isChangeStatus: _serviceUpdate.nameGroup
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
                                              isChangeStatus: _serviceUpdate.nameGroup
                                            ),
                                          ),
                                        ), 
                                        Div(
                                          colL: 12,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: AttrLogic(
                                              value: _selectedScenario?.id == 1 || _selectedScenario?.id == null ? _serviceUpdate.adressGroup : _serviceUpdate.adressGroup = true,
                                              editable: _selectedScenario?.id == 1,
                                              onChanged: (value) => setState(() {
                                                _serviceUpdate.adressGroup = value;
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
                                              isChangeStatus: _serviceUpdate.adressGroup
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
                                              isChangeStatus: _serviceUpdate.adressGroup
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
                                                    isChangeStatus: _serviceUpdate.adressGroup
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                  width: 94,
                                                  child: ReadOnlyTextField(
                                                    labelText: 'Корпус',
                                                    isChangeStatus: _serviceUpdate.adressGroup
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                  width: 100,
                                                  child: ReadOnlyTextField(
                                                    labelText: 'Квартира',
                                                    isChangeStatus: _serviceUpdate.adressGroup
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
                                            padding: const EdgeInsets.only(left: 16, top: 20),
                                            child: TextFieldDropdownSearch<bool>(
                                              title: 'Признак генерации номера лицевого счета',
                                              items: const [false, true],
                                              showSearchBox: false,
                                              maxHeight: 100,
                                              itemBuilder: (item) => item ? 'Номер лицевого счета генерируется' : 'Номер лицевого счета не генерируется',
                                              selected: _autogenPan,
                                              onTap: (item) => setState(() => _serviceUpdate.autogenPan = item),                                              
                                            ),
                                          ),
                                        ),
                                        Div(
                                          colL: 4,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 16, top: 20),
                                            child: TextFieldDropdownSearch<PersonalAccountStornoMode>(
                                              title: 'Признак сторнирования операций по услуге',
                                              showSearchBox: false,
                                              maxHeight: 150,
                                              items: PersonalAccountStornoMode.values,
                                              itemBuilder: (item) => item.name,
                                              selected: _selectedAccountStornoMode,
                                              onTap: (item) => setState(() => _selectedAccountStornoMode = item),
                                              onSaved: (_) {
                                                if (_service!.stornoModeEnum != _selectedAccountStornoMode) {
                                                  _serviceUpdate.stornoMode = _selectedAccountStornoMode.inJson;
                                                } else {
                                                  _serviceUpdate.stornoMode = '';
                                                }
                                              }
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                );
                              }
                            )
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
                      SaveButton(
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

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (_service!.enabled == _serviceUpdate.enabled) {
        _serviceUpdate.enabled = null;
      }
      if (_service!.advanceEnabled == _serviceUpdate.advanceEnabled) {
        _serviceUpdate.advanceEnabled = null;
      }
      if (_service!.claimOnly == _serviceUpdate.claimOnly) {
        _serviceUpdate.claimOnly = null;
      }
      _serviceUpdate.dateEnd  = _dateEnd;
      context.read<ServiceUpdateBloc>().add(ServiceUpdateRun(_serviceUpdate));
    }
  }
}