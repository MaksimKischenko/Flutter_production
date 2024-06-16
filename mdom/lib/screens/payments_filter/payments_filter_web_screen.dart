import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'widgets/widgets.dart';

class PaymentsFilterWebScreen extends StatefulWidget {
  final PaymentsFilterData data;

  const PaymentsFilterWebScreen({required this.data});

  @override
  _PaymentsFilterWebScreenState createState() =>
      _PaymentsFilterWebScreenState();
}

class _PaymentsFilterWebScreenState extends State<PaymentsFilterWebScreen> {
  late DataManager _dataManager;

  late DateTime _dateFrom; // = DateTime.now();
  late DateTime _dateTo; // = DateTime.now();

  final _filterFormKey = GlobalKey<FormState>();

  late List<Service> _servicesList;

  final _serviceController = TextEditingController();
  final _accNumController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  final _dateTypeController = TextEditingController();
  final _statusController = TextEditingController();

  Service? _selectedService;
  late PaymentDateType _selectedDateType;
  late PaymentStatus _selectedStatus;

  final _nodeAccNum = FocusNode();

  @override
  void initState() {
    super.initState();

    _dataManager = InjectionComponent.getDependency<DataManager>();
    _servicesList = _dataManager.servicesList;

    _selectedService = widget.data.service;
    _serviceController.text = widget.data.service?.name ?? '';

    _selectedDateType = widget.data.dateType;
    _dateTypeController.text = _selectedDateType.name;
    //_selectedDateType = widget.filters.dateType;

    _selectedStatus = widget.data.status;
    _statusController.text = _selectedStatus.filterName;

    if (widget.data.accNum != null) {
      _accNumController.text = widget.data.accNum.toString();
    }

    _dateFrom = widget.data.dateFrom;
    _dateTo = widget.data.dateTo;

    _dateFromController.text = widget.data.dateFrom.toStringFormatted();
    _dateToController.text = widget.data.dateTo.toStringFormatted();
  }

  @override
  void dispose() {
    _accNumController.dispose();
    _dateFromController.dispose();
    _dateToController.dispose();
    _serviceController.dispose();
    _dateTypeController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        title: 'Фильтр',
        buttonTitle: 'Применить',
        onPressed: _onApplyTap,
        buttonActive: true,
        body: KeyboardActions(
          config: keyboarConfig,
          disableScroll: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _filterFormKey,
              child: ListView(
                children: [
                  ServiceField(
                    controller: _serviceController,
                    onTap: _onServicesTap,
                  ),
                  const SizedBox(height: 16),
                  DateTypeField(
                    controller: _dateTypeController,
                    onTap: _onDateTypeTap,
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
                  PaymentStatusField(
                    controller: _statusController,
                    onTap: _onStatusTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _onApplyTap() {
    if (_filterFormKey.currentState?.validate() ?? false) {
      _filterFormKey.currentState?.save();
      Navigator.of(context).pop<PaymentsFilterData>(
        PaymentsFilterData(
          service: _selectedService!,
          dateType: _selectedDateType,
          accNum: _accNumController.text,
          dateFrom: _dateFrom,
          dateTo: _dateTo,
          status: _selectedStatus,
        ),
      );
    }
  }

  KeyboardActionsConfig get keyboarConfig => AppStyles.keyboardConfig(
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeAccNum,
            displayDoneButton: false,
            displayActionBar: false,
          ),
        ],
      );

  // ignore: avoid_void_async
  void _onServicesTap() async {
    final value = await Multiplatform.showDropdown<Service>(
      context: context,
      title: 'Услуга',
      items: _servicesList,
      builder: (item) => item.name,
      selected: _selectedService,
    );
    if (value != null) {
      _serviceController.text = value.name;
      _selectedService = value;
    }
  }

  // ignore: avoid_void_async
  void _onDateTypeTap() async {
    final value = await Multiplatform.showDropdown<PaymentDateType>(
      context: context,
      title: 'Тип даты',
      items: PaymentDateType.values,
      builder: (item) => item.name,
      selected: _selectedDateType,
    );
    if (value != null) {
      _dateTypeController.text = value.name;
      _selectedDateType = value;
    }
  }

  // ignore: avoid_void_async
  void _onStatusTap() async {
    final value = await Multiplatform.showDropdown<PaymentStatus>(
      context: context,
      title: 'Тип платежей',
      items: PaymentStatus.values,
      builder: (item) => item.filterName,
      selected: _selectedStatus,
    );
    if (value != null) {
      _statusController.text = value.filterName;
      _selectedStatus = value;
    }
  }

  // ignore: avoid_void_async
  void _showDateFromPicker() async {
    final value = await Multiplatform.showdatePicker(
        context: context,
        initialDate: _dateFrom,
        firstDate: _dateFrom.subtract(const Duration(days: 20000)),
        lastDate: DateTime.now().add(const Duration(days: 20000)));
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
        lastDate: DateTime.now().add(const Duration(days: 20000)));
    if (value != null) {
      _dateTo = DateTime(value.year, value.month, value.day);
      _dateToController.text = _dateTo.toStringFormatted();
    }
  }
}
