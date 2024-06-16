import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class AccountForm extends StatefulWidget {
  final MdomResponseParams params;
  final ProductsTab selectedTab;


  const AccountForm({
    Key? key,
    required this.params,
    required this.selectedTab
  }): super(key: key);
  
  @override
  AccountFormState createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();

  late MdomResponseParams _params;
  late List<MdomResponseParam> _paramsVisible;
  late List<MdomResponseParam> _paramsInputed;
  late List<MdomResponseParam> _paramsVisibleAfterMainPart;

  MdomResponseParam? accountNumberParam;

  @override
  void initState() {
    super.initState();

    _params = widget.params;
    _paramsVisible = _params.params.where(_filter).toList();
    _paramsInputed = _paramsVisible.map((e) => e.copyWith()).toList();

    accountNumberParam = _paramsInputed.firstOrNullWhere((param) => _params.findByAlias(AliasList.number)?.id == param.id);
    _paramsVisibleAfterMainPart = _paramsVisible.where(_filterAfterMainPart).toList();
  }

  /// filter visible elements
  bool _filter(MdomResponseParam param) {
    if ((param.view ?? 0) == 0) return false;
    return true;
  }

  /// filter elements from main part
  bool _filterAfterMainPart(MdomResponseParam param) {
    // Номер счета
    if (param.id == accountNumberParam?.id) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountNumberField(
                onSaved: (accountNumber) {
                  accountNumberParam?.evalue = accountNumber;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _buildItem(index),
                  itemCount: _paramsVisibleAfterMainPart.length,
                ),
              ),
              
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildItem(int index) {
    final param = _paramsVisibleAfterMainPart[index];

    final mandatory = (param.mandatory ?? 0) == 1;
    final minLength = param.minLength ?? 0;
    final maxLength = param.maxLength ?? 99;
    final type = ParamType.values[param.type];
    final keyboardType = type.keyboardType;
    final inputFormatters = type.inputFormatters;
    final validator = type.validator;
    final editable = (param.edit ?? 0) == 1;

    Widget? widget;
    if (type == ParamType.str
        || type == ParamType.integ
        || type == ParamType.doubl
        || type == ParamType.composite) {
      widget = ParamField(
        labelText: mandatory
            ? '${param.name}*'
            : param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        maxLength: maxLength,
        editable: editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (mandatory && value.isEmpty) {
            return context.t.mobileScreens.productAdd.accountForm.paramField.errors.empty;
          }
          if (!mandatory && value.isEmpty) return null;
          if (value.length < minLength) {
            return context.t.mobileScreens.productAdd.accountForm.paramField.errors.minLength(minLength: minLength);
          }

          return validator.call(value);
        },
        onSaved: (value) {
          _paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue = value;
        },
      );
    } else if (type == ParamType.date) {
      widget = ParamDate(
        labelText: param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        editable: editable,
        onSaved: (value) {
          _paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue = value;
        },
      );
    } else if (type == ParamType.logic) {
      widget = ParamLogic(
        text: param.name,
        value: _stringToBool(_paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue),
        editable: editable,
        onChanged: (value) {
          setState(() {
            _paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue = _boolToString(value);
          });
        },
      );
    }

    widget ??= const SizedBox();
    return Padding(
      padding: EdgeInsets.only(bottom: index != _paramsVisibleAfterMainPart.length - 1 ? 16 : 0),
      child: widget,
    );
  }

  bool? _stringToBool(String? value) {
    bool? ret;
    if (value == 'Y') ret = true;
    if (value == 'N') ret = false;
    return ret;
  }

  String? _boolToString(bool? value) {
    String? ret;
    if (value == true) ret = 'Y';
    if (value == false) ret = 'N';
    return ret;
  }

  void onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final returnData = <MdomResponseParam>[..._paramsInputed];

      final defaultFlagTemp = _params.findByAlias(AliasList.defaultFlag);
      final defaultFlag = defaultFlagTemp!.copyWith(evalue: '0');
      returnData.add(defaultFlag);

      final typePanTemp = _params.findByAlias(AliasList.typePan);
      final typePan = typePanTemp!.copyWith();
      returnData.add(typePan);

      context.read<ProductsBloc>().add(
        ProductsAdd(
          tab: widget.selectedTab,
          params: returnData
        )
      );
    }
  }
}