import 'package:bpc/data/remote_models/mdom_base_models.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/registration_params/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegistretionParamsFieldBuilder extends StatefulWidget {
  final List<MdomResponseParam> paramsCopy;
  final int index;
  const RegistretionParamsFieldBuilder({
    super.key,
    required this.paramsCopy,
    required this.index,
  });

  @override
  State<RegistretionParamsFieldBuilder> createState() =>
      RegistretionParamsFieldBuilderState();
}

class RegistretionParamsFieldBuilderState
    extends State<RegistretionParamsFieldBuilder> {
  @override
  Widget build(BuildContext context) {
    final param = widget.paramsCopy[widget.index];

    final mandatory = (param.mandatory ?? 0) == 1;
    final minLength = param.minLength ?? 0;
    final maxLength = param.maxLength ?? 99;
    final type = ParamType.values[param.type];
    final keyboardType = type.keyboardType;
    final inputFormatters = type.inputFormatters;
    final validator = type.validator;
    final editable = (param.edit ?? 0) == 1;

    Widget? child;

    if (type == ParamType.str ||
        type == ParamType.integ ||
        type == ParamType.doubl ||
        type == ParamType.composite) {
      child = ParamField(
        labelText: mandatory ? '${param.name}*' : param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        maxLength: maxLength,
        editable: editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (mandatory && value.isEmpty) {
            return 'Поле обязательно для заполнения';
          }
          if (!mandatory && value.isEmpty) return null;
          if (value.length < minLength) {
            return 'Минимальная длина $minLength';
          }

          return validator.call(value);
        },
        onSaved: (value) {
          widget.paramsCopy[widget.index].evalue = value;
        },
      );
    } else if (type == ParamType.date) {
      child = ParamDate(
        labelText: param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        editable: editable,
        onSaved: (value) {
          widget.paramsCopy[widget.index].evalue = value;
        },
      );
    } else if (type == ParamType.logic) {
      child = ParamLogic(
        text: param.name,
        value: _stringToBool(widget.paramsCopy[widget.index].evalue),
        editable: editable,
        onChanged: (value) {
          setState(() {
            widget.paramsCopy[widget.index].evalue = _boolToString(value);
          });
        },
      );
    }

    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.index != widget.paramsCopy.length - 1 ? 16 : 0),
      child: child ?? const SizedBox.shrink(),
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
}
