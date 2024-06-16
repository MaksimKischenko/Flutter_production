import 'package:bpc/data/data.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'widgets/widgets.dart';

class AddDeviceWebScreen extends StatefulWidget {
  final Device? device;
  final String itemUnit;

  const AddDeviceWebScreen({this.device, required this.itemUnit});

  @override
  _AddDeviceWebScreenState createState() => _AddDeviceWebScreenState();
}

class _AddDeviceWebScreenState extends State<AddDeviceWebScreen> {
  final _addDeviceFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _tarifController = TextEditingController();
  final _lastRegController = TextEditingController();

  late String _name;
  late double _tarif;
  late double _lastReg;

  final _nodeName = FocusNode();
  final _nodeTariff = FocusNode();
  final _nodeLastReg = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.device != null) {
      _nameController.text = widget.device!.nameDevice ?? '';
      _tarifController.text = widget.device!.tariff.toString();
      _lastRegController.text = widget.device!.evalue.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tarifController.dispose();
    _lastRegController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        title: widget.device != null
            ? 'Редактирование прибора учета'
            : 'Новый прибор учета',
        buttonTitle: widget.device != null ? 'Сохранить' : 'Готово',
        onPressed: _onSaveTap,
        buttonActive: true,
        body: KeyboardActions(
          config: keyboardConfig,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _addDeviceFormKey,
              child: ListView(
                children: [
                  ItemUnitText(widget.itemUnit),
                  const SizedBox(height: 8),
                  DeviceNameField(
                    focusNode: _nodeName,
                    controller: _nameController,
                    onSaved: (value) => _name = value,
                  ),
                  const SizedBox(height: 16),
                  DeviceTarifField(
                    focusNode: _nodeTariff,
                    controller: _tarifController,
                    onSaved: (value) => _tarif = value,
                  ),
                  const SizedBox(height: 16),
                  DeviceLastRegField(
                    focusNode: _nodeLastReg,
                    controller: _lastRegController,
                    onSaved: (value) => _lastReg = value,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  KeyboardActionsConfig get keyboardConfig =>
      AppStyles.keyboardConfig(actions: [
        KeyboardActionsItem(
            focusNode: _nodeName,
            displayDoneButton: false,
            displayActionBar: false),
        KeyboardActionsItem(
            focusNode: _nodeTariff,
            displayArrows: false,
            toolbarButtons: [AppStyles.doneButton]),
        KeyboardActionsItem(
            focusNode: _nodeLastReg,
            displayArrows: false,
            toolbarButtons: [AppStyles.doneButton])
      ]);

  void _onSaveTap() {
    if (_addDeviceFormKey.currentState?.validate() ?? false) {
      _addDeviceFormKey.currentState?.save();

      //TODO: pop required much data
      Navigator.of(context).pop<Device>(Device(
        itemUnit: widget.itemUnit,
        nameDevice: _name,
        tariff: _tarif,
        evalue: _lastReg,
      ));
    }
  }
}
