// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'widgets/widgets.dart';

class AddDeviceScreen extends StatefulWidget {
  final Device? device;
  final String itemUnit;

  const AddDeviceScreen({
    this.device,
    required this.itemUnit
  });

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _addDeviceFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _tarifController = TextEditingController();
  final _lastRegController = TextEditingController();

  late String name;
  late double tarif;
  late double lastReg;

  final _nodeName = FocusNode();
  final _nodeTariff = FocusNode();
  final _nodeLastReg = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.device != null) {
      _nameController.text = widget.device!.nameDevice;
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
  Widget build(BuildContext context) => DismissOutside(
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Закрыть',
        ),
        centerTitle: true,
        title: Text(
          widget.device != null
          ? 'Редактирование прибора учета'
          : 'Новый прибор учета'
        ),
        actions: [
          TextButton(
            child: Text(
              widget.device != null
                  ? 'Сохранить'
                  : 'Готово',
              style: const TextStyle(
                color: AppStyles.mainColor,
                // fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),
            onPressed: () {
              if (_addDeviceFormKey.currentState?.validate() ?? false) {
                _addDeviceFormKey.currentState!.save();
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key: _addDeviceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemUnitText(widget.itemUnit),
                  const SizedBox(height: 8),
                  DeviceNameField(
                    focusNode: _nodeName,
                    controller: _nameController,
                    onSaved: (value) => name = value,
                  ),
                  const SizedBox(height: 16),
                  DeviceTarifField(
                    focusNode: _nodeTariff,
                    controller: _tarifController,
                    onSaved: (value) => tarif = value,
                  ),
                  const SizedBox(height: 16),
                  DeviceLastRegField(
                    focusNode: _nodeLastReg,
                    controller: _lastRegController,
                    onSaved: (value) => lastReg = value,
                  ),
                ],
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
        focusNode: _nodeName,
        displayDoneButton: false,
        displayActionBar: false
      ),
      KeyboardActionsItem(
        focusNode: _nodeTariff,
        displayArrows: false,
        toolbarButtons: [AppStyles.doneButton]
      ),
      KeyboardActionsItem(
        focusNode: _nodeLastReg,
        displayArrows: false,
        toolbarButtons: [AppStyles.doneButton]
      )
    ]
  );
}