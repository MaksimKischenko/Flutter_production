
import 'package:flutter/material.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/date_helper.dart';
import 'package:isc_web_app/utils/utils.dart';
import 'package:isc_web_app/widgets/date_picker_widget.dart';
import 'package:isc_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

class ClaimsFilterWebScreen extends StatefulWidget {
  final ClaimsFilterData data;

  const ClaimsFilterWebScreen({required this.data});

  @override
  _ClaimsFilterWebScreenState createState() => _ClaimsFilterWebScreenState();
}

class _ClaimsFilterWebScreenState extends State<ClaimsFilterWebScreen> {


  late DateTime _dateFrom;
  late DateTime _dateTo;
  final _filterFormKey = GlobalKey<FormState>();
  final _accNumController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  final _statusController = TextEditingController();

  late ClaimStatus _selectedStatus;

  final _nodeAccNum = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.data.status;
    _statusController.text = _selectedStatus.claimStatusName;

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
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
      buttonActive: true,
      useSpacer: true,
      title: 'Фильтр',
      buttonTitle: 'Применить',
      onPressed: _onApplyTap,
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
                    ]
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _statusController,
                    onTap: _onStatusTap,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Тип требований',
                        alignLabelWithHint: true,
                        labelStyle: AppStyles.inputLabelUnderlineStyle,
                        enabledBorder: AppStyles.inputBorderOutline,
                        border: AppStyles.inputBorderOutline,
                        errorBorder: AppStyles.errorWebBorder,
                        focusedErrorBorder: AppStyles.errorWebBorder,
                        isDense: true,                        
                        suffixIcon: const Icon(
                          Icons.expand_more,
                          color: AppStyles.mainColor,        
                      )),
                  ),
                ])),
      ));

  void _onApplyTap() {
    if (_filterFormKey.currentState?.validate() ?? false) {
      _filterFormKey.currentState?.save();
      Navigator.of(context).pop<ClaimsFilterData>(ClaimsFilterData(
        accNum: _accNumController.text,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        status: _selectedStatus,
      ));
    }
  }

  Future<void> _onStatusTap() async {
    final value = await Multiplatform.showDropdown<ClaimStatus>(
      context: context,
      title: 'Тип требований',
      items: ClaimStatus.values,
      builder: (item) => item.claimStatusName,
      selected: _selectedStatus,
    );

    if (value != null) {
      _statusController.text = value.claimStatusName;
      _selectedStatus = value;
    }
  }
}
