import 'package:flutter/material.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/utils/date_helper.dart';
import 'package:isc_web_app/utils/utils.dart';
import 'package:isc_web_app/widgets/date_picker_widget.dart';
import 'package:isc_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

class PaymentsFilterWebScreen extends StatefulWidget {
  final PaymentsFilterData data;

  const PaymentsFilterWebScreen({required this.data});

  @override
  _PaymentsFilterWebScreenState createState() =>
      _PaymentsFilterWebScreenState();
}

class _PaymentsFilterWebScreenState extends State<PaymentsFilterWebScreen> {
  late DateTime _dateFrom; 
  late DateTime _dateTo; 

  final _filterFormKey = GlobalKey<FormState>();


  final _accNumController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  final _dateTypeController = TextEditingController();
  final _statusController = TextEditingController();
  late PaymentStatus _selectedStatus;
  late PaymentDateType _selectedDateType; 

  final _nodeAccNum = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.data.status;
    _selectedDateType = widget.data.dateType;   
    _statusController.text = _selectedStatus.paymentStatusName;
    _dateTypeController.text = _selectedDateType.name;

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
    _dateTypeController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        useSpacer: true,
        title: 'Фильтр',
        buttonTitle: 'Применить',
        onPressed: _onApplyTap,
        buttonActive: true,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _filterFormKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),                
                children: [
                  AccNumField(
                    focusNode: _nodeAccNum,
                    controller: _accNumController,
                  ),
                  const SizedBox(height: 16),
                  DateTypeField(
                    controller: _dateTypeController,
                    onTap: _onDateTypeTap,
                  ),   
                  const SizedBox(height: 16),                                 
                  Row(
                    children: [
                      Expanded(
                        child: WebDatePicker(
                        initialDate: _dateFrom,
                        labelText: 'с', 
                        onChange: (value) {
                          _dateFrom = value ?? DateTime.now();
                        },
                        validator: () {
                          if (_dateFrom.isAfter(_dateTo)) {
                            return 'Ошибка';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: WebDatePicker(
                        initialDate: _dateTo,
                        labelText: 'по',
                        onChange: (value) {
                          _dateTo = value ?? DateTime.now();
                        },                          
                        validator: () {
                          if (_dateTo.isBefore(_dateFrom)) {
                            return 'Ошибка';
                          }
                          return null;
                        }),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  PaymentStatusField(
                    controller: _statusController,
                    onTap: _onStatusTap,
                  ),
                  const SizedBox(height: 16),                  
                ],
              ),
            ),
          ),
      );

  void _onApplyTap() {
    if (_filterFormKey.currentState?.validate() ?? false) {
      _filterFormKey.currentState?.save();
      Navigator.of(context).pop<PaymentsFilterData>(
        PaymentsFilterData(
          serviceCode: 101, 
          dateType: _selectedDateType,          
          accNum: _accNumController.text,
          dateFrom: _dateFrom,
          dateTo: _dateTo,
          status: _selectedStatus,
        ),
      );
    }
  }

  Future<void> _onDateTypeTap() async {
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

  Future<void> _onStatusTap() async {
    final value = await Multiplatform.showDropdown<PaymentStatus>(
      context: context,
      title: 'Тип платежей',
      items: PaymentStatus.values,
      builder: (item) => item.paymentStatusName,
      selected: _selectedStatus,
    );
    if (value != null) {
      _statusController.text = value.paymentStatusName;
      _selectedStatus = value;
    }
  }
}
