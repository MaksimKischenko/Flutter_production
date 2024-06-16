import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/utils.dart';

class FilterItem extends StatefulWidget {
  final ServiceFilter item;
  late final FilterType type;
  final String? initialValue;
  final Function(int code, String value) onSaved;
  // only for bool value
  final Function(int code, bool? value) onLogicChange;

  FilterItem(
      {Key? key,
      required this.item,
      required this.initialValue,
      required this.onSaved,
      required this.onLogicChange})
      : type = FilterTypeExtension.fromString(item.type),
        super(key: key);

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  late TextEditingController _controller;
  bool? logicValue;

  @override
  void initState() {
    if (widget.type == FilterType.logic) {
      logicValue =
          widget.initialValue == null ? null : widget.initialValue == '1';
    }
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == FilterType.logic) {
      return GestureDetector(
        onTap: () {
          final newValue = logicValue == null
              ? true
              : logicValue!
                  ? false
                  : null;

          setState(() {
            logicValue = newValue;
          });
          widget.onLogicChange(widget.item.code, newValue);
        },
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.item.name,
                  // style: AppStyles.inputLabelStyle
                  style: const TextStyle(
                      color: AppStyles.mainTextColor, fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              Checkbox(
                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: const VisualDensity(horizontal: -2),
                tristate: true,
                value: logicValue,
                onChanged: (_) {
                  final newValue = logicValue == null
                      ? true
                      : logicValue!
                          ? false
                          : null;

                  setState(() {
                    logicValue = newValue;
                  });
                  widget.onLogicChange(widget.item.code, newValue);
                },
                activeColor: AppStyles.mainColor,
              )
            ],
          ),
        ),
      );
    } else {
      return TextFormField(
        controller: _controller,
        // initialValue: widget.initialValue,
        autocorrect: false,
        inputFormatters: widget.type.inputFormatters,
        textInputAction: TextInputAction.done,
        maxLength: widget.item.maxLength,
        readOnly: widget.type == FilterType.date,
        onTap: widget.type == FilterType.date ? _showDatePicker : null,
        keyboardType: widget.type.keyboardType,
        style: const TextStyle(
          color: AppStyles.mainTextColor,
        ),
        decoration: InputDecoration(
            counterText: '',
            // counterText: item.maxLength == 0
            //     ? ''
            //     : 'до ${item.maxLength} символов',
            alignLabelWithHint: true,
            // filled: true,
            isDense: true,
            // fillColor: const Color(0xfff7f7f9),
            labelText: widget.item.name,
            labelStyle: const TextStyle(color: AppStyles.mainTextColor),
            // helperText: hintText,
            hintStyle: const TextStyle(color: AppStyles.mainTextColor),
            border: AppStyles.inputBorder,
            focusedBorder: AppStyles.inputBorderFocused,
            enabledBorder: AppStyles.inputBorderEnabled),
        validator: (value) {
          if (value?.isNotEmpty ?? false) {
            // check minLength
            if (widget.item.minLength != null) {
              if (widget.item.minLength! > value!.length)
                return 'Минимальная длина - ${widget.item.minLength}';
            }
            // validators for item type
            return widget.type.validator.call(value);
          }
          return null;
        },
        onSaved: (value) => widget.onSaved(widget.item.code, value!),
      );
    }
  }

  // ignore: avoid_void_async
  void _showDatePicker() async {
    final value = await Multiplatform.showdatePicker(
        context: context,
        initialDate:
            _controller.text.toDateFormatted(format: widget.item.format) ??
                DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 20000)),
        lastDate: DateTime.now().add(const Duration(days: 20000)));

    if (value != null) {
      final _dueDate = DateTime(value.year, value.month, value.day);
      _controller.text = _dueDate.toStringFormatted(format: widget.item.format);
    }
  }
}
