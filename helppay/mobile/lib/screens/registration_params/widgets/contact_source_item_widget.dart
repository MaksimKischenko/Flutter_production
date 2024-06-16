import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/screens/registration_params/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'contact_source_item_widget');

class ContactSourceItemWidget extends StatefulWidget {
  final dynamic Function(String) onSaved;
  final String? selectedContactOption;
  final String? initialPhoneNumber;
  final int index;
  final List<MdomResponseParam> paramsCopy;
  const ContactSourceItemWidget({
    super.key,
    required this.onSaved,
    required this.index,
    required this.paramsCopy,
    this.selectedContactOption,
    this.initialPhoneNumber,
  });
  @override
  State<ContactSourceItemWidget> createState() =>
      _ContactSourceItemWidgetState();
}

class _ContactSourceItemWidgetState extends State<ContactSourceItemWidget> {
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
    // TODO: implement initState
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
    // _log('type ${type}');
    // _log('name ${param.name}');
    // _log('minlength - $minLength');
    // _log('maxlength - $maxLength');
  }

  @override
  Widget build(BuildContext context) {
    Widget? returnedWidget;
    if (type == ParamType.str && param.alias == 'PHONE' ||
        param.alias == 'EMAIL') {
      returnedWidget = ParamField(
        labelText: mandatory ? '${param.name}*' : param.name,
        hintText: param.hint,
        initialValue:
            param.alias == 'PHONE' ? widget.initialPhoneNumber : param.evalue,
        maxLength: maxLength,
        editable: editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (widget.selectedContactOption == 'PHONE' &&
              param.alias == 'PHONE' &&
              value.isEmpty) {
            return 'Заполните данные для выбранного способа оповещения';
            // return context
            // .t.mobileScreens.registrationParams.paramField.errors.empty;
          }
          if (widget.selectedContactOption == 'EMAIL' &&
              param.alias == 'EMAIL' &&
              value.isEmpty) {
            return 'Заполните данные для выбранного способа оповещения';
            // return context
            // .t.mobileScreens.registrationParams.paramField.errors.empty;
          }
          // if (!mandatory && value.isEmpty) return null;
          if (widget.selectedContactOption == 'EMAIL' &&
              param.alias == 'EMAIL' &&
              value.length < minLength) {
            return 'Минимальная длина не подходит';
            // return context.t.mobileScreens.registrationParams.paramField.errors
            //     .minLength(minLength: minLength);
          }
          if (widget.selectedContactOption == 'PHONE' &&
              param.alias == 'PHONE' &&
              value.length < minLength) {
            return 'Минимальная длина телефона не подходит';
            // return context.t.mobileScreens.registrationParams.paramField.errors
            //     .minLength(minLength: minLength);
          }

          return validator.call(value);
        },
        onSaved: (value) => widget.onSaved(value),
      );
    }

    return returnedWidget != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: returnedWidget,
          )
        : const SizedBox.shrink();
  }
}
