import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:tuple/tuple.dart';

import 'widgets/widgets.dart';

class PaymentsFilterScreen extends StatefulWidget {
  final PaymentsFilterData data;
  final ScrollController? scrollController;

  const PaymentsFilterScreen({
    required this.data,
    required this.scrollController
  });

  @override
  _PaymentsFilterScreenState createState() => _PaymentsFilterScreenState();
}

class _PaymentsFilterScreenState extends State<PaymentsFilterScreen> {
  late DataManager _dataManager;

  late DateTime _dateFrom;// = DateTime.now();
  late DateTime _dateTo;// = DateTime.now();

  final _filterFormKey = GlobalKey<FormState>();

  late List<Service> _servicesList;

  final _serviceController = TextEditingController();
  final _accNumController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  final _dateTypeController = TextEditingController();
  final _paymentTypeController = TextEditingController();

  Service? _selectedService;
  Tuple2<int, String>? _selectedDateType;
  Tuple2<int, String>? _selectedPaymentType;

  final _dateTypesList = const <Tuple2<int, String>>[
    Tuple2(0, 'Дата перечисления'),
    Tuple2(1, 'Дата приема платежа')
  ];

  final _paymentTypesList = const <Tuple2<int, String>> [
    Tuple2(0, 'Все'),
    Tuple2(1, 'Зарегистрированные'),
    Tuple2(2, 'Оплаченные (есть номер ПП)'),
    Tuple2(-1, 'Успешно сторнированные'),
    // Tuple2(-2, "Начато сторнирование"),
    // Tuple2(-3, "Начата регистрация"),
    // Tuple2(-4, 'С отмененной регистрацией'),
    Tuple2(-9, 'Возврат начат'),
    Tuple2(-10, 'Возврат выполнен'),
    Tuple2(-11, 'Ожидание отмены возврата')
  ];

  final _nodeAccNum = FocusNode();

  @override
  void initState() {
    super.initState();

    _dataManager = InjectionComponent.getDependency<DataManager>();
    _servicesList = _dataManager.servicesList;

    _selectedService = widget.data.service;
    _serviceController.text = widget.data.service?.name ?? '';

    _selectedDateType = _dateTypesList.firstOrNullWhere((element) => element.item1 == widget.data.dateType);
    if (_selectedDateType != null) {
      _dateTypeController.text = _selectedDateType!.item2;
    }
    //_selectedDateType = widget.filters.dateType;

    final paymentTypeFromWidget = widget.data.paymentsType;
    _selectedPaymentType = _paymentTypesList.firstOrNullWhere((element) => element.item1 == paymentTypeFromWidget);
    if (_selectedPaymentType != null) {
      _paymentTypeController.text = _selectedPaymentType!.item2; 
    }

    if (widget.data.accNum != null) {
      _accNumController.text = widget.data.accNum.toString();
    }

  
    _dateFrom = widget.data.dateFrom.toDateFormatted();
    _dateTo = widget.data.dateTo.toDateFormatted();

    _dateFromController.text = widget.data.dateFrom;
    _dateToController.text = widget.data.dateTo;
  }

  @override
  void dispose() {
    _accNumController.dispose();
    _dateFromController.dispose();
    _dateToController.dispose();
    _serviceController.dispose();
    _dateTypeController.dispose();
    _paymentTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DismissOutside(
    child: Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Фильтр'),
          actions: [
            TextButton(
              child: const Text(
                'Применить',
                style: TextStyle(
                  color: AppStyles.mainColor,
                  // fontSize: 16,
                  fontWeight: FontWeight.w400
                ),
              ),
              onPressed: () {
                if (_filterFormKey.currentState?.validate() ?? false) {
                  _filterFormKey.currentState?.save();
                  Navigator.of(context).pop<PaymentsFilterData>(
                    PaymentsFilterData(
                      service: _selectedService!,
                      dateType: _selectedDateType!.item1,
                      accNum: _accNumController.text,
                      dateFrom: _dateFromController.text,
                      dateTo: _dateToController.text,
                      paymentsType: _selectedPaymentType!.item1
                    )
                  );
                }
              },
            )
          ],
        ),
        body: KeyboardActions(
          config: _buildConfig(context),
          disableScroll: true,
          child: FullScreen(
            topSafe: false,
            bottomSafe: false,
            controller: widget.scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _filterFormKey,
                child: Column(
                  children: [
                    ServiceField(
                      controller: _serviceController,
                      onTap: () => _showServicesDropDown(_servicesList)
                    ),
                    const SizedBox(height: 16),
                    DateTypeField(
                      controller: _dateTypeController,
                      onTap: () => _showClaimDateTypeDropDown(_dateTypesList),
                    ),
                    const SizedBox(height: 16),
                    AccNumField(
                      focusNode: _nodeAccNum,
                      controller: _accNumController,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DateField(
                            controller: _dateFromController,
                            onTap: _showDateFromPicker,
                            label: 'с',
                            validator: () {
                              if (_dateFrom.isAfter(_dateTo)) {
                                return 'Ошибка';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DateField(
                            controller: _dateToController,
                            onTap: _showDateToPicker,
                            label: 'по',
                            validator: () {
                              if (_dateTo.isBefore(_dateFrom)) {
                                return 'Ошибка';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    PaymentTypeField(
                      controller: _paymentTypeController,
                      onTap: () => _showPaymentTypeDropDown(_paymentTypesList),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  KeyboardActionsConfig _buildConfig(BuildContext context) => AppStyles.keyboardConfig(
    context,
    actions: [
      KeyboardActionsItem(
        focusNode: _nodeAccNum,
        displayDoneButton: false,
        displayActionBar: false
      ),
    ]
  );

  // ignore: avoid_void_async
  void _showServicesDropDown(List<Service> list) async {
    final value = await Multiplatform.showDropDown(
      context: context,
      list: list,
      visibleList: list.map((item) => item.name).toList(),
      selected: _selectedService,
      title: 'Услуга'
    );
    if (value != null) {
      _serviceController.text = value.name;
      _selectedService = value;
    }
  }

  // ignore: avoid_void_async
  void _showClaimDateTypeDropDown(List<Tuple2<int, String>> list) async {
    final value = await Multiplatform.showDropDown(
      context: context,
      list: list,
      visibleList: list.map((item) => item.item2).toList(),
      selected: _selectedDateType,
      title: 'Тип даты'
    );
    if (value != null) {
      _dateTypeController.text = value.item2;
      _selectedDateType = value; 
    }
  }

  // ignore: avoid_void_async
  void _showPaymentTypeDropDown(List<Tuple2<int, String>> list) async {
    final value = await Multiplatform.showDropDown(
      context: context,
      list: list,
      visibleList: list.map((item) => item.item2).toList(),
      selected: _selectedPaymentType,
      title: 'Тип платежей'
    );
    if (value != null) {
      _paymentTypeController.text = value.item2;
      _selectedPaymentType = value;
    }
  }

  // ignore: avoid_void_async
  void _showDateFromPicker() async {
    final value = await Multiplatform.showdatePicker(
      context: context,
      initialDate: _dateFrom,
      firstDate: _dateFrom.subtract(const Duration(days: 20000)),
      lastDate: DateTime.now().add(const Duration(days: 20000))
    );
    if (value != null) {
      _dateFrom = DateTime(value.year, value.month, value.day);
      _dateFromController.text = _dateFrom.toStringFormatted();
    }
  }

  // ignore: avoid_void_async
  void _showDateToPicker() async {
    final value = await Multiplatform.showdatePicker(
      context: context,
      initialDate: _dateFrom.isAfter(_dateTo) ? _dateFrom : _dateTo,
      firstDate: _dateFrom,
      lastDate: DateTime.now().add(const Duration(days: 20000))
    );
    if (value != null) {
      _dateTo = DateTime(value.year, value.month, value.day);
      _dateToController.text = _dateTo.toStringFormatted();
    }
  }
}