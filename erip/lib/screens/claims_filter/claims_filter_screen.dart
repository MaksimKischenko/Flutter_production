import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/models/claims_filter_data.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:tuple/tuple.dart';

import 'widgets/widgets.dart';

class ClaimsFilterScreen extends StatefulWidget {
  final ClaimsFilterData data;
  final ScrollController? scrollController;

  const ClaimsFilterScreen({
    required this.data,
    required this.scrollController
  });

  @override
  _ClaimsFilterScreenState createState() => _ClaimsFilterScreenState();
}

class _ClaimsFilterScreenState extends State<ClaimsFilterScreen> {
  late DataManager _dataManager;

  late DateTime _dateFrom;
  late DateTime _dateTo;

  final _filterFormKey = GlobalKey<FormState>();

  late List<Service> _servicesList;

  final _serviceController = TextEditingController();
  final _accNumController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  final _claimTypeController = TextEditingController();

  Service? _selectedService;
  Tuple2<int, String>? _selectedClaimType;

  final _claimTypesList = const <Tuple2<int, String>>[
    Tuple2(0, 'Все'),
    Tuple2(1, 'Неоплаченные'),
    Tuple2(2, 'Полностью оплаченные'),
    Tuple2(3, 'Частично оплаченные'),
    Tuple2(4, 'Просроченные')
  ];

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

    final claimTypeFromWidget = widget.data.claimsType;
    _selectedClaimType = _claimTypesList.firstOrNullWhere((element) => element.item1 == claimTypeFromWidget);
    if (_selectedClaimType != null) {
      _claimTypeController.text = _selectedClaimType!.item2;
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
    _serviceController.dispose();
    _accNumController.dispose();
    _dateFromController.dispose();
    _dateToController.dispose();
    _claimTypeController.dispose();
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
                  _filterFormKey.currentState!.save();
                  Navigator.of(context).pop<ClaimsFilterData>(
                    ClaimsFilterData(
                      service: _selectedService,
                      accNum: _accNumController.text,
                      dateFrom: _dateFromController.text,
                      dateTo: _dateToController.text,
                      claimsType: _selectedClaimType!.item1,
                    )
                  );
                }
              },
            )
          ]
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
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ServiceField(
                      controller: _serviceController,
                      onTap: () => _showServicesDropDown(_servicesList),
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
                            label: 'с',
                            onTap: _showDateFromPicker,
                            validator: () {
                              if (_dateFrom.isAfter(_dateTo)) {
                                return 'Ошибка';
                              }
                              return null;
                            }
                          ),
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
                            }
                          ),
                        )
                      ]
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8)
                    ),
                    TextFormField(
                      controller: _claimTypeController,
                      onTap: () => _showClaimTypeDropDown(_claimTypesList),
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Тип требований',
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(top: 16, left: 10),
                          child: Icon(
                            Icons.expand_more,
                            color: AppStyles.mainColor,
                            size: 35,
                          )
                        )
                      ),
                    ),
                  ]
                )
              ),
            ),
          ),
        )
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
    final value = await Multiplatform.showDropDown<Service>(
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
  void _showClaimTypeDropDown(List<Tuple2<int, String>> list) async {
    final value = await Multiplatform.showDropDown<Tuple2<int, String>>(
      context: context,
      list: list,
      visibleList: list.map((item) => item.item2).toList(),
      selected: _selectedClaimType,
      title: 'Тип требований'
    );

    if (value != null) {
      _claimTypeController.text = value.item2;
      _selectedClaimType = value;
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