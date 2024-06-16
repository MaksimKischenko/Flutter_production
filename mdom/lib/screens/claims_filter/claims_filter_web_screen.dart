import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'widgets/widgets.dart';

class ClaimsFilterWebScreen extends StatefulWidget {
  final ClaimsFilterData data;

  const ClaimsFilterWebScreen({required this.data});

  @override
  _ClaimsFilterWebScreenState createState() => _ClaimsFilterWebScreenState();
}

class _ClaimsFilterWebScreenState extends State<ClaimsFilterWebScreen> {
  late DataManager _dataManager;

  late DateTime _dateFrom;
  late DateTime _dateTo;

  final _filterFormKey = GlobalKey<FormState>();

  late List<Service> _servicesList;

  final _serviceController = TextEditingController();
  final _accNumController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  final _statusController = TextEditingController();

  Service? _selectedService;
  late ClaimStatus _selectedStatus;

  final _nodeAccNum = FocusNode();

  @override
  void initState() {
    super.initState();

    _dataManager = InjectionComponent.getDependency<DataManager>();
    _servicesList = _dataManager.servicesList;

    _selectedService = widget.data.service;
    if (_selectedService != null) {
      _serviceController.text = _selectedService!.name;
    }

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
    _serviceController.dispose();
    _accNumController.dispose();
    _dateFromController.dispose();
    _dateToController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
      buttonActive: true,
      title: 'Фильтр',
      buttonTitle: 'Применить',
      onPressed: _onApplyTap,
      body: KeyboardActions(
        config: keyboardConfig,
        disableScroll: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
              key: _filterFormKey,
              child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ServiceField(
                      controller: _serviceController,
                      onTap: _onServicesTap,
                    ),
                    const SizedBox(height: 16),
                    AccNumField(
                      focusNode: _nodeAccNum,
                      controller: _accNumController,
                    ),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(
                        child: DateField(
                            controller: _dateFromController,
                            label: 'с',
                            onTap: _showDateFromPicker,
                            validator: () {
                              if (_dateFrom.isAfter(_dateTo)) {
                                return 'Ошибка';
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DateField(
                            controller: _dateToController,
                            label: 'по',
                            onTap: _showDateToPicker,
                            validator: () {
                              if (_dateTo.isBefore(_dateFrom)) {
                                return 'Ошибка';
                              }
                              return null;
                            }),
                      )
                    ]),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _statusController,
                      onTap: _onStatusTap,
                      readOnly: true,
                      decoration: const InputDecoration(
                          labelText: 'Тип требований',
                          suffixIcon: Padding(
                              padding: EdgeInsets.only(top: 16, left: 10),
                              child: Icon(
                                Icons.expand_more,
                                color: AppStyles.mainColor,
                                size: 35,
                              ))),
                    ),
                  ])),
        ),
      ));

  void _onApplyTap() {
    if (_filterFormKey.currentState?.validate() ?? false) {
      _filterFormKey.currentState?.save();
      Navigator.of(context).pop<ClaimsFilterData>(ClaimsFilterData(
        service: _selectedService,
        accNum: _accNumController.text,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        status: _selectedStatus,
      ));
    }
  }

  KeyboardActionsConfig get keyboardConfig =>
      AppStyles.keyboardConfig(actions: [
        KeyboardActionsItem(
            focusNode: _nodeAccNum,
            displayDoneButton: false,
            displayActionBar: false),
      ]);

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
  void _onStatusTap() async {
    final value = await Multiplatform.showDropdown<ClaimStatus>(
      context: context,
      title: 'Тип требований',
      items: ClaimStatus.values,
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
