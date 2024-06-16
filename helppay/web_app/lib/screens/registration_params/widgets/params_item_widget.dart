import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/screens/registration_params/widgets/widgets.dart';

class ParamsItemWidget extends StatefulWidget {
  final dynamic Function(String) onSaved;
  final Function(bool?) onChanged;
  final int index;
  final List<MdomResponseParam> paramsCopy;
  const ParamsItemWidget({
    super.key,
    required this.paramsCopy,
    required this.index,
    required this.onSaved,
    required this.onChanged,
  });
  @override
  State<ParamsItemWidget> createState() => _ParamsItemWidgetState();
}

class _ParamsItemWidgetState extends State<ParamsItemWidget> {
  late MdomResponseParam param;

  late bool mandatory;
  late int minLength;
  late int maxLength;
  late ParamType type;
  late TextInputType keyboardType;
  late List<TextInputFormatter> inputFormatters;
  late String? Function(String) validator;
  late bool editable;
  @override
  void initState() {
    super.initState();
    param = widget.paramsCopy[widget.index];
    mandatory = (param.mandatory ?? 0) == 1;
    minLength = param.minLength ?? 0;
    maxLength = param.maxLength ?? 99;
    type = ParamType.values[param.type];
    keyboardType =
        param.alias == 'PHONE' ? TextInputType.number : type.keyboardType;
    inputFormatters = type.inputFormatters;
    validator = type.validator;
    editable = (param.edit ?? 0) == 1;
  }

  @override
  Widget build(BuildContext context) {
    Widget? returnedWidget;
    if ((type == ParamType.str ||
            type == ParamType.integ ||
            type == ParamType.doubl ||
            type == ParamType.composite) &&
        (widget.paramsCopy[widget.index].alias != 'PHONE' &&
            widget.paramsCopy[widget.index].alias != 'EMAIL' &&
            widget.paramsCopy[widget.index].alias != 'SOURCECOMMUNICATION')) {
      returnedWidget = ParamField(
        labelText: mandatory ? '${param.name}*' : param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        maxLength: maxLength,
        editable: editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (mandatory && value.isEmpty) {
            return context
                .t.mobileScreens.registrationParams.paramField.errors.empty;
          }
          if (!mandatory && value.isEmpty) return null;
          if (value.length < minLength) {
            return context.t.mobileScreens.registrationParams.paramField.errors
                .minLength(minLength: minLength);
          }

          return validator.call(value);
        },
        onSaved: (value) => widget.onSaved(value),
      );
    } else if (type == ParamType.date) {
      returnedWidget = ParamDate(
        labelText: param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        editable: editable,
        onSaved: (value) => widget.onSaved(value),
      );
    } else if (type == ParamType.logic) {
      returnedWidget = ParamLogic(
        text: param.name,
        value: _stringToBool(widget.paramsCopy[widget.index].evalue),
        editable: editable,
        onChanged: (value) => widget.onChanged(value),
      );
    }
    return returnedWidget != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: returnedWidget,
          )
        : const SizedBox.shrink();
  }

  bool? _stringToBool(String? value) {
    bool? ret;
    if (value == 'Y') ret = true;
    if (value == 'N') ret = false;
    return ret;
  }
}
