import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

class AttrTimeSecondary extends StatefulWidget {
  final String? labelText;
  final String? initialValue;
  final bool needValidation;
  final Function(DateTime value)? onSaved;
  final Function(DateTime value)? onChanged;
  final String? Function(String?)? validator;

  const AttrTimeSecondary({
    this.labelText,
    this.initialValue,
    this.needValidation = true,
    this.onSaved,
    this.onChanged,
    this.validator,
  });

  @override
  _AttrTimeSecondaryState createState() => _AttrTimeSecondaryState();
}

class _AttrTimeSecondaryState extends State<AttrTimeSecondary> {
  TextEditingController? _timeController;
  final _formatter =
      MaskTextInputFormatter(mask: '', filter: {'#': RegExp('[0-9]')});

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##:##');
    _timeController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 70,
        child: TextFormField(
            controller: _timeController,
            inputFormatters: [_formatter],
            cursorColor: AppStyles.mainColor,
            style: const TextStyle(color: AppStyles.mainTextColor),
            decoration: InputDecoration(
                alignLabelWithHint: true,
                filled: true,
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
                  borderRadius: BorderRadius.circular(5)
                ),
                fillColor: AppStyles.mainColor.withOpacity(0.03),
                labelStyle: AppStyles.labelTextFieldStyle,
                hintStyle: const TextStyle(
                  color: AppStyles.mainTextColor,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1)
                ),
                // enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
                //     borderRadius: BorderRadius.circular(5)
                // )
            ),
            validator: (value) {
              if(widget.needValidation) {
                if (value?.isEmpty ?? true ) {
                  return 'Неккоректное \nвремя';
                }
                final list = value!.split(':');
                final hours = int.parse(list.first);
                final minutes = int.parse(list.last);
                if (hours > 24 || minutes > 59) {
                  _timeController?.clear();
                  return 'Неккоректное \nвремя';
                }
                return widget.validator?.call(value);
              }
              return null;
            },
            onChanged: (value) => widget.onChanged?.call(value.toDateFormattedOnlyTime() ?? DateTime.now()),
            onSaved: (value) => widget.onSaved
                ?.call(value?.toDateFormattedOnlyTime() ?? DateTime.now())),
      );
}
