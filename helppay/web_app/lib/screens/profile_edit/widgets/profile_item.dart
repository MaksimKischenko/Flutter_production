import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'profile_item');

class ProfileItem extends StatefulWidget {
  final String? selectedContactOption;
  final MdomResponseParam item;
  final List<MdomRequestParam> paramsEdited;
  final int index;
  const ProfileItem({
    super.key,
    required this.item,
    required this.paramsEdited,
    required this.index,
    this.selectedContactOption,
  });

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  late bool mandatory;
  late int minLength;
  late int maxLength;
  late ParamType type;
  late TextInputType keyboardType;
  late List<TextInputFormatter> inputFormatters;
  late Function validator;

  @override
  void initState() {
    super.initState();
    mandatory = (widget.item.mandatory ?? 0) == 1;
    minLength = widget.item.minLength ?? 0;
    maxLength = widget.item.maxLength ?? 99;
    type = ParamType.values[widget.item.type];
    keyboardType = type.keyboardType;
    inputFormatters = type.inputFormatters;
    validator = widget.item.alias == 'EMAIL' ? validateEmail : type.validator;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return
    // final param = params[index];

    _log('selected contact option ${widget.selectedContactOption}');
    _log('item index ${widget.index}');
    _log('item value  ${widget.item.evalue}');

    if (type == ParamType.str ||
        type == ParamType.integ ||
        type == ParamType.doubl ||
        type == ParamType.composite) {
      return Padding(
        padding: EdgeInsets.only(
            top: widget.index == 0 ? 8 : 0,
            bottom: widget.index != widget.paramsEdited.length - 1 ? 16 : 0),
        child: ParamField(
          isMobileInputField: widget.item.alias == 'PHONE',
          labelText: mandatory ? '${widget.item.name}*' : widget.item.name,
          hintText:
              widget.item.alias == 'PHONE' ? '## ###-##-##' : widget.item.hint,
          initialValue: (widget.item.evalue?.startsWith('375') ?? false)
              ? widget.item.evalue!.replaceRange(0, 3, '')
              : widget.item.evalue!,
          maxLength: maxLength,
          editable: true,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: (value) {
            _log('field value $value');
            if (widget.selectedContactOption == 'PHONE' &&
                widget.item.alias == 'PHONE' &&
                value.isEmpty) {
              return 'Заполните данные для выбранного способа оповещения';
              // return context
              // .t.mobileScreens.registrationParams.paramField.errors.empty;
            }
            if (widget.selectedContactOption == 'EMAIL' &&
                widget.item.alias == 'EMAIL' &&
                value.isEmpty) {
              return 'Заполните данные для выбранного способа оповещения';
              // return context
              // .t.mobileScreens.registrationParams.paramField.errors.empty;
            }
            // if (!mandatory && value.isEmpty) return null;
            if (widget.selectedContactOption == 'EMAIL' &&
                widget.item.alias == 'EMAIL' &&
                value.length < minLength) {
              return 'Минимальная длина не подходит';
              // return context.t.mobileScreens.registrationParams.paramField.errors
              //     .minLength(minLength: minLength);
            }
            if (widget.selectedContactOption == 'PHONE' &&
                widget.item.alias == 'PHONE' &&
                value.length < minLength) {
              return 'Минимальная длина телефона не подходит';
              // return context.t.mobileScreens.registrationParams.paramField.errors
              //     .minLength(minLength: minLength);
            }
            if (mandatory && value.isEmpty) {
              return context
                  .t.mobileScreens.profileEdit.paramField.errors.empty;
            }
            if (!mandatory && value.isEmpty) return null;
            if (value.length < minLength) {
              return context.t.mobileScreens.profileEdit.paramField.errors
                  .minLength(minLength: minLength);
            }

            return widget.item.alias == 'EMAIL'
                ? validator.call(value, widget.selectedContactOption)
                : validator.call(value);
          },
          onSaved: (value) {
            widget.paramsEdited[widget.index].evalue =
                widget.item.alias == 'PHONE' ? '375$value' : value;
          },
        ),
      );
    } else if (type == ParamType.date) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: widget.index != widget.paramsEdited.length - 1 ? 16 : 0),
        child: ParamDate(
          labelText: widget.item.name,
          hintText: widget.item.hint,
          initialValue: widget.item.evalue,
          editable: true,
          onSaved: (value) {
            widget.paramsEdited[widget.index].evalue = value;
          },
        ),
      );
    } else if (type == ParamType.logic) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: widget.index != widget.paramsEdited.length - 1 ? 16 : 0),
        child: ParamLogic(
          text: widget.item.name,
          value: _stringToBool(widget.paramsEdited[widget.index].evalue),
          editable: true,
          onChanged: (value) {
            setState(() {
              widget.paramsEdited[widget.index].evalue = _boolToString(value);
            });
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  String? validateEmail(String? value, String selectedContactOption) {
    if (selectedContactOption == 'PHONE') {
      return null;
    } else {
      if (value == null || value.isEmpty) {
        return t.mobileScreens.profileEdit.emailValidator.emptyEmail;
      }
      final emailRegex = RegExp(
          r'^[a-zA-Z0-9/!#$%&*+-=?^_{}|"]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
      if (!emailRegex.hasMatch(value)) {
        return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
      }

      if (value.length > 320) {
        return t.mobileScreens.profileEdit.emailValidator.invalidLength;
      }

      final parts = value.split('@');
      if (parts.length != 2 || parts[0].isEmpty || parts[1].isEmpty) {
        return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
      }

      final hostParts = parts[1].split('.');
      for (final part in hostParts) {
        if (part.isEmpty ||
            part.length > 63 ||
            part.startsWith('-') ||
            part.endsWith('-')) {
          return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
        }
      }

      final tld = hostParts.last;
      final validTlds = [
        'by',
        'com',
        'ru',
        'americanexpress'
      ]; // Ваши допустимые домены первого уровня
      if (!validTlds.contains(tld)) {
        return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
      }

      return null;
    }
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
